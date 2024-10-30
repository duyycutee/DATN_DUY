using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using QLKhachSan.Models;
using QLKhachSan.ViewModels;
using QLKhachSan.ViewModels.Admin;
using System.Runtime.Intrinsics.Arm;
using X.PagedList;


namespace QLKhachSan.Areas.Admin.Controllers
{
    [Area("admin")]
    [Authorize(Roles = "Admin")]
    public class HomeAdminController : Controller
    {
        QLKhachSanTTTNContext db = new QLKhachSanTTTNContext();
        [Route("admin")]
        public IActionResult Index(int? maks)
        {
            var email = HttpContext.Session.GetString("email");


            var currentYear = DateTime.Now.Year;
            var months = Enumerable.Range(1, 12).ToList();

            var soks = (from ks in db.KhachSans
                        where ks.Duyet == 1
                        select ks).Count();
            var songuoidung = (from nd in db.KhachHangs
                               where nd.HieuLuc == 0
                               select nd).Count();
            var sophong = (from p in db.Phongs
                           join lp in db.LoaiPhongs on p.MaLp equals lp.MaLp
                           join ks in db.KhachSans on lp.MaKs equals ks.MaKs
                           where ks.Duyet == 1
                           select p).Count();
            var sohd = (from hd in db.HoaDons
                        join dp in db.DatPhongs on hd.SoHoaDon equals dp.SoHoaDon
                        where dp.IsDelete == 0
                        select hd).Count();

            var monthlyData = (from dp in db.DatPhongs
                               join p in db.Phongs on dp.MaPhong equals p.MaPhong
                               join lp in db.LoaiPhongs on p.MaLp equals lp.MaLp
                               join ks in db.KhachSans on lp.MaKs equals ks.MaKs
                               where dp.NgayDen.Value.Year == currentYear && ks.MaKs == maks
                               group dp by new { dp.NgayDen.Value.Year, dp.NgayDen.Value.Month } into g
                               select new
                               {
                                   Month = g.Key.Month,
                                   Year = g.Key.Year,
                                   Bookings = g.Count(),
                                   Cancellations = g.Count(dp => dp.IsDelete == 1)
                               }).ToList();


            var datphong = new List<int>();
            var huyphong = new List<int>();

            foreach (var month in months)
            {
                var data = monthlyData.FirstOrDefault(m => m.Year == currentYear && m.Month == month);
                datphong.Add(data?.Bookings ?? 0);
                huyphong.Add(data?.Cancellations ?? 0);
            }

            var today = DateTime.Today;
            var maPhongTrong = db.DatPhongs
                .Where(dp => dp.NgayDen <= today && dp.NgayDi >= today)
                .Select(dp => dp.MaPhong)
                .Distinct()
                .ToList();

            var phongtrong = (from p in db.Phongs
                              join lp in db.LoaiPhongs on p.MaLp equals lp.MaLp
                              join ks in db.KhachSans on lp.MaKs equals ks.MaKs
                              where !maPhongTrong.Contains(p.MaPhong) && ks.Duyet == 1 && ks.MaKs == maks
                              select p).Count();

            var ngaydatToday = (from dp in db.DatPhongs
                                join p in db.Phongs on dp.MaPhong equals p.MaPhong
                                join lp in db.LoaiPhongs on p.MaLp equals lp.MaLp
                                join ks in db.KhachSans on lp.MaKs equals ks.MaKs
                                join hd in db.HoaDons on dp.SoHoaDon equals hd.SoHoaDon
                                where dp.IsDelete == 0 && ks.MaKs == maks
                                where hd.NgayThanhToan.Value.Date == DateTime.Today
                                select hd).Count();
            var ngaytraToday = (from dp in db.DatPhongs
                                join p in db.Phongs on dp.MaPhong equals p.MaPhong
                                join lp in db.LoaiPhongs on p.MaLp equals lp.MaLp
                                join ks in db.KhachSans on lp.MaKs equals ks.MaKs
                                where dp.NgayDi == DateTime.Today && ks.MaKs == maks select dp).Count(); 
            var ngayhuyToday = (from dp in db.DatPhongs
                                join p in db.Phongs on dp.MaPhong equals p.MaPhong
                                join lp in db.LoaiPhongs on p.MaLp equals lp.MaLp
                                join ks in db.KhachSans on lp.MaKs equals ks.MaKs
                                where dp.NgayHuy.Value.Date == DateTime.Today && ks.MaKs == maks
                                select dp).Count();

            // Tính tổng số giao dịch hôm nay
            var totalToday = ngaydatToday + ngaytraToday + ngayhuyToday;

            // Tính tỷ lệ phần trăm cho từng loại giao dịch
            ViewBag.PercDatPhong = totalToday > 0 ? (ngaydatToday * 100) / totalToday : 0;
            ViewBag.PercTraPhong = totalToday > 0 ? (ngaytraToday * 100) / totalToday : 0;
            ViewBag.PercHuyPhong = totalToday > 0 ? (ngayhuyToday * 100) / totalToday : 0;

            var khachsan = (from ks in db.KhachSans
                            join kh in db.KhachHangs on ks.IdnguoiTao equals kh.MaKh
                            select new { ks.MaKs, ks.TenKhachSan }).ToList();
            ViewBag.ks = khachsan;
            //ViewBag.MaKS = maks;
            ViewBag.Months = months.Select(m => new DateTime(currentYear, m, 1).ToString("MM/yyyy")).ToList();
            ViewBag.Bookings = datphong;
            ViewBag.Cancellations = huyphong;
            ViewBag.datphong = datphong.Sum();
            ViewBag.huyphong = huyphong.Sum();

            ViewBag.soks = soks;
            ViewBag.sond = songuoidung;
            ViewBag.sohd = sohd;
            ViewBag.sophong = sophong;
            ViewBag.sophongtrong = phongtrong;

            ViewBag.ngaydatToday = ngaydatToday;
            ViewBag.ngaytraToday = ngaytraToday;
            ViewBag.ngayhuyToday = ngayhuyToday;
            return View();
        }

    }
}
