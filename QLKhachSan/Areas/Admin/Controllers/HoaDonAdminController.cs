using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using QLKhachSan.Models;
using QLKhachSan.ViewModels;
using QLKhachSan.ViewModels.Admin;
using X.PagedList;

namespace QLKhachSan.Areas.Admin.Controllers
{
    [Area("admin")]
    [Authorize(Roles = "Admin")]
    public class HoaDonAdminController : Controller
    {
        QLKhachSanTTTNContext db = new QLKhachSanTTTNContext();
		#region Hóa đơn
		[Route("hoadon")]
        public IActionResult HoaDon(int?maks, int? page)
        {
            int pageSize = 8;
            int pageNumber = page == null || page < 0 ? 1 : page.Value;
            var hoadon = (from hd in db.HoaDons
						  join dp in db.DatPhongs on hd.SoHoaDon equals dp.SoHoaDon
						  join p in db.Phongs on dp.MaPhong equals p.MaPhong
						  join lp in db.LoaiPhongs on p.MaLp equals lp.MaLp
						  join ks in db.KhachSans on lp.MaKs equals ks.MaKs
						  where ks.MaKs == maks
						  select new HoaDonVM
                            {
                                sohoadon = hd.SoHoaDon,
                                tenphong = p.TenPhong,
                                ngaythanhtoan = hd.NgayThanhToan,
                                ngayden = dp.NgayDen,
                                ngaydi = dp.NgayDi,
                                tenkh = hd.TenKh,
                                songuoi = dp.SoNguoi,
                                sdt = hd.Sdt,
                                tinhtrang = hd.TinhTrang
                            }).OrderBy(x => x.sohoadon);
			var khachsan = (from ks in db.KhachSans
							join kh in db.KhachHangs on ks.IdnguoiTao equals kh.MaKh
							select new { ks.MaKs, ks.TenKhachSan }).ToList();
			ViewBag.ks = khachsan;
			ViewBag.MaKS = maks;
			PagedList<HoaDonVM> lst = new PagedList<HoaDonVM>(hoadon, pageNumber, pageSize);

            return View(lst);
        }

        [Route("SuaHD")]
        [HttpGet]
        public IActionResult SuaHD(int id)
        {
            var hoadon = (from hd in db.HoaDons
                          join dp in db.DatPhongs on hd.SoHoaDon equals dp.SoHoaDon
                          join p in db.Phongs on dp.MaPhong equals p.MaPhong
                          where hd.SoHoaDon == id
                          select new HoaDonVM
                          {
                              sohoadon = hd.SoHoaDon,
                              maphong = p.MaPhong,
                              tenphong = p.TenPhong,
                              ngaythanhtoan = hd.NgayThanhToan,
                              ngayden = dp.NgayDen,
                              ngaydi = dp.NgayDi,
                              tenkh = hd.TenKh,
                              songuoi = dp.SoNguoi,
                              sdt = hd.Sdt,
                              tinhtrang = hd.TinhTrang
                          }).FirstOrDefault();
            return View(hoadon);
        }
        [Route("SuaHD")]
        [HttpPost]
        public IActionResult SuaHD(HoaDonVM model)
        {
            var hoadon = db.HoaDons.FirstOrDefault(p => p.SoHoaDon == model.sohoadon);
            if (hoadon != null)
            {
                hoadon.NgayThanhToan = model.ngaythanhtoan;
                hoadon.TenKh = model.tenkh;
                hoadon.Sdt = model.sdt;
                hoadon.TinhTrang = model.tinhtrang;

                db.Update(hoadon);

                var dp = db.DatPhongs.FirstOrDefault(p => p.SoHoaDon == model.sohoadon);
                if (dp != null)
                {
                    dp.NgayDen = model.ngayden;
                    dp.NgayDi = model.ngaydi;
                    dp.SoNguoi = model.songuoi;

                    db.Update(dp);
                }

                db.SaveChanges();
                TempData["Message"] = "Cập nhật hóa đơn thành công!";
                return RedirectToAction("HoaDon");
            }
            return View();
        }
		[Route("timkiemhoadon")]
		public IActionResult TimKiemHoaDon(int maks,string searchTerm, int? page)
		{
			int pageSize = 8;
			int pageNumber = page ?? 1;

			var hoadonQuery = from hd in db.HoaDons
							  join dp in db.DatPhongs on hd.SoHoaDon equals dp.SoHoaDon
							  join p in db.Phongs on dp.MaPhong equals p.MaPhong
							  join lp in db.LoaiPhongs on p.MaLp equals lp.MaLp
							  join ks in db.KhachSans on lp.MaKs equals ks.MaKs
                              where ks.MaKs == maks
							  select new HoaDonVM
							  {
								  sohoadon = hd.SoHoaDon,
								  tenphong = p.TenPhong,
								  ngaythanhtoan = hd.NgayThanhToan,
								  ngayden = dp.NgayDen,
								  ngaydi = dp.NgayDi,
								  tenkh = hd.TenKh,
								  songuoi = dp.SoNguoi,
								  sdt = hd.Sdt,
								  tinhtrang = hd.TinhTrang
							  };

			if (!string.IsNullOrEmpty(searchTerm))
			{
				hoadonQuery = hoadonQuery.Where(hd => hd.sohoadon.ToString().Contains(searchTerm)
												   || hd.tenphong.Contains(searchTerm)
												   || hd.tenkh.Contains(searchTerm)
												   || hd.sdt.Contains(searchTerm)
												   || hd.tinhtrang.Contains(searchTerm));
			}

			var hoadonList = hoadonQuery.OrderBy(x => x.sohoadon).ToPagedList(pageNumber, pageSize);
			var khachsan = (from ks in db.KhachSans
							join kh in db.KhachHangs on ks.IdnguoiTao equals kh.MaKh
							select new { ks.MaKs, ks.TenKhachSan }).ToList();
			ViewBag.ks = khachsan;
			ViewBag.MaKS = maks;
			ViewBag.SearchTerm = searchTerm;
			return View(hoadonList);
		}
		#endregion

	}
}
