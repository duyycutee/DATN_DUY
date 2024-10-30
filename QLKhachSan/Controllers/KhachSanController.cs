using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using QLKhachSan.Models;
using QLKhachSan.SignalRChat;
using QLKhachSan.ViewModels;
using System.Collections.Generic;
using X.PagedList;

namespace QLKhachSan.Controllers
{
    public class KhachSanController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly QLKhachSanTTTNContext db;
        private readonly IHubContext<ChatHub> _hubContext;
        public KhachSanController(ILogger<HomeController> logger, QLKhachSanTTTNContext context, IHubContext<ChatHub> hubContext)
        {
            _logger = logger;
            db = context;
            _hubContext = hubContext;
        }
		#region Khách sạn
		public IActionResult KhachSan(int? page)
        {
            int pageSize = 8;
            int pageNumber = page == null || page < 0 ? 1 : page.Value;
            var listKS = db.KhachSans.AsTracking()
                .Where(x => x.Duyet == 1)
                .OrderBy(x => x.TenKhachSan)
                .Join(db.TinhThanhs, ks => ks.MaTinh, t => t.MaTinh, (ks, t) => new KhachSanVM
                {
                    MaTinh = ks.MaTinh,
                    MaKS = ks.MaKs,
                    TenKS = ks.TenKhachSan,
                    Anh = ks.Anh,
                    DiaChi = ks.DiaChi,
                    DanhGia = ks.DanhGia,
                    Mota = ks.MoTa
                })
                .ToList();
            var khuvuc = (from ks in db.KhachSans
                          join t in db.TinhThanhs on ks.MaTinh equals t.MaTinh
                          where ks.Duyet == 1
                          group ks by t.TenTinh into g
                          select new
                          {
                              TenTinh = g.Key,
                              Count = g.Count()
                          }).ToList();
            var starCounts = new Dictionary<int, int>
    {
        { 0, db.KhachSans.Count(ks => ks.DanhGia == 0 && ks.Duyet == 1) },
        { 1, db.KhachSans.Count(ks => ks.DanhGia == 1 && ks.Duyet == 1) },
        { 2, db.KhachSans.Count(ks => ks.DanhGia == 2 && ks.Duyet == 1) },
        { 3, db.KhachSans.Count(ks => ks.DanhGia == 3 && ks.Duyet == 1) },
        { 4, db.KhachSans.Count(ks => ks.DanhGia == 4 && ks.Duyet == 1) },
        { 5, db.KhachSans.Count(ks => ks.DanhGia == 5 && ks.Duyet == 1) }
    };
            ViewBag.khuvuc = khuvuc;
            ViewBag.starCounts = starCounts;
            PagedList<KhachSanVM> pagedListResult = new PagedList<KhachSanVM>(listKS, pageNumber, pageSize);
            return View(pagedListResult);
        }
        public IActionResult KhachSanTheoTinh(int matinh, int? page)
        {
            int pageSize = 8;
            int pageNumber = page == null || page < 0 ? 1 : page.Value;
            var listKS = db.KhachSans.AsTracking()
                .Where(x => x.MaTinh == matinh && x.Duyet == 1)
                .OrderBy(x => x.TenKhachSan)
                .Join(db.TinhThanhs, ks => ks.MaTinh, t => t.MaTinh, (ks, t) => new KhachSanVM
                {
                    MaTinh = ks.MaTinh,
                    MaKS = ks.MaKs,
                    TenKS = ks.TenKhachSan,
                    Anh = ks.Anh,
                    DiaChi = ks.DiaChi,
                    DanhGia = ks.DanhGia,
                    Mota = ks.MoTa
                })
                .ToList();
            var districts = db.KhachSans
                                    .Where(ks => ks.Duyet == 1 && ks.MaTinh == matinh).ToList()
                                    .Select(ks => ks.DiaChi.Split(',')[2].Trim()) // Lấy phần tử thứ 3 trong chuỗi địa chỉ (là tên quận)
                                    .Distinct() // Lọc các giá trị trùng lặp
                                    .ToList();

            // Đếm số lượng khách sạn trong mỗi quận
            var khuvuc = districts.Select(district => new
            {
                DiaChi = district,
                Count = db.KhachSans.Count(ks => ks.Duyet == 1 && ks.MaTinh == matinh && ks.DiaChi.Contains(district))
            }).ToList();
            var starCounts = new Dictionary<int, int>
    {
        { 0, db.KhachSans.Count(ks => ks.DanhGia == 0 && ks.Duyet == 1 && ks.MaTinh == matinh) },
        { 1, db.KhachSans.Count(ks => ks.DanhGia == 1 && ks.Duyet == 1 && ks.MaTinh == matinh) },
        { 2, db.KhachSans.Count(ks => ks.DanhGia == 2 && ks.Duyet == 1 && ks.MaTinh == matinh) },
        { 3, db.KhachSans.Count(ks => ks.DanhGia == 3 && ks.Duyet == 1 && ks.MaTinh == matinh) },
        { 4, db.KhachSans.Count(ks => ks.DanhGia == 4 && ks.Duyet == 1 && ks.MaTinh == matinh) },
        { 5, db.KhachSans.Count(ks => ks.DanhGia == 5 && ks.Duyet == 1 && ks.MaTinh == matinh) }
    };
            ViewBag.khuvuc = khuvuc;
            ViewBag.starCounts = starCounts;
            ViewBag.matinh = matinh;
            //ViewBag.giatb = giatb;
            // Tạo PagedList từ danh sách SanPhamVM
            PagedList<KhachSanVM> pagedListResult = new PagedList<KhachSanVM>(listKS, pageNumber, pageSize);
            return View(pagedListResult);
        }
        [HttpGet]
        public IActionResult GetAddress(int maKS)
        {
            var address = db.KhachSans
                                .Where(k => k.MaKs == maKS)
                                .Select(k => k.DiaChi)
                                .FirstOrDefault();
            return Ok(address);
        }
		#endregion

		#region Chi tiết khách sạn
		public IActionResult ChiTietKS(int MaKS, int? pagePhong, int? pageDanhGia)
        {
            int pageSizePhong = 9;
            int pageSizeDanhGia = 5;
            int pageNumberPhong = pagePhong == null || pagePhong < 0 ? 1 : pagePhong.Value;
            int pageNumberDanhGia = pageDanhGia == null || pageDanhGia < 0 ? 1 : pageDanhGia.Value;
            var email = HttpContext.Session.GetString("email");
            if(email == null)
            {
                HttpContext.Session.SetString("check", "0");
            }
            else
            {
                var idKH = (from kh in db.KhachHangs
                            where kh.Email == email
                            select kh.MaKh).FirstOrDefault();
                var idDanhGia = (from hd in db.HoaDons
                                 select hd.MaKh).ToList();
                if (idDanhGia.Contains(idKH))
                {
                    HttpContext.Session.SetString("check", "1");
                }
            }
            var result = from p in db.Phongs
                         join lp in db.LoaiPhongs on p.MaLp equals lp.MaLp
                         where lp.MaKs == MaKS
                         select new ChiTietPhongVM
                         {
                             MaPhong = p.MaPhong,
                             TenPhong = p.TenPhong,
                             AnhPhong = p.Anh,
                             Gia = lp.Gia,
                             SoNguoiToiDa = lp.SoNguoiToiDa,
                         };
            var danhgia = from dg in db.Gopies
                          where dg.MaKs == MaKS
                          select new DanhGiaKS
                          {
                              TenKh = (from kh in db.KhachHangs
                                       where kh.MaKh == dg.MaKh
                                       select kh.TenKh).FirstOrDefault(),
                              NgayComment = dg.NgayComment,
                              Comment = dg.Comment,
                              DiemNhanVien = dg.DiemNhanVien,
                              DiemThucAn = dg.DiemDoAn,
                              DiemThoaiMai = dg.DiemThoaiMai,
                              DiemSachSe = dg.DiemSachSe,
                              DiemDichVu = dg.DiemDichVu
                          };
            var soVote = (from x in db.Gopies
                          where x.MaKs == MaKS
                          select x.Id).Count();
            ViewBag.soVote = soVote;
            var diemNhanVien = db.Gopies.Where(dg => dg.MaKs == MaKS).Select(dg => dg.DiemNhanVien);
            var diemThucAn = db.Gopies.Where(dg => dg.MaKs == MaKS).Select(dg => dg.DiemDoAn);
            var diemSachSe = db.Gopies.Where(dg => dg.MaKs == MaKS).Select(dg => dg.DiemSachSe);
            var diemThoaiMai = db.Gopies.Where(dg => dg.MaKs == MaKS).Select(dg => dg.DiemThoaiMai);
            var diemDichVu = db.Gopies.Where(dg => dg.MaKs == MaKS).Select(dg => dg.DiemDichVu);

            if (diemNhanVien.Any() && diemThucAn.Any() && diemSachSe.Any() && diemThoaiMai.Any() && diemDichVu.Any())
            {
                ViewBag.dtbNhanVien = Math.Round((decimal)diemNhanVien.Average(), 1);
                ViewBag.dtbThucAn = Math.Round((decimal)diemThucAn.Average(), 1);
                ViewBag.dtbSachSe = Math.Round((decimal)diemSachSe.Average(), 1);
                ViewBag.dtbThoaiMai = Math.Round((decimal)diemThoaiMai.Average(), 1);
                ViewBag.dtbDichVu = Math.Round((decimal)diemDichVu.Average(), 1);
            }
            var thietbi = (from tb in db.ThietBis
                           select tb.TenTb).ToList();
            var loaiphong = (from lp in db.LoaiPhongs
                             join p in db.Phongs on lp.MaLp equals p.MaLp
                             join ks in db.KhachSans on lp.MaKs equals ks.MaKs
                             where lp.MaKs == MaKS
                             select lp.TenLp).Distinct().ToList();
            var songuoitoida = db.LoaiPhongs
                              .Select(lp => lp.SoNguoiToiDa)
                              .Max();
            var viewModel = new ChiTietDanhGia
            {
                ChiTietPhong = result.ToPagedList(pageNumberPhong, pageSizePhong),
                DanhGia = danhgia.ToPagedList(pageNumberDanhGia, pageSizeDanhGia),
            };
            ViewBag.maks = MaKS;
            ViewBag.LoaiPhong = loaiphong;
            ViewBag.songuoitoida = songuoitoida;
            ViewBag.thietbi = thietbi;
            return View(viewModel);
        }
		#endregion

		#region Khách sạn HOT
        public IActionResult KhachSanHot(int? page)
        {
            int pageSize = 8;
            int pageNumber = page == null || page < 0 ? 1 : page.Value;
            var listKS = (from ks in db.KhachSans
                          join t in db.TinhThanhs on ks.MaTinh equals t.MaTinh
                          where ks.Duyet == 1
                          let gopiesCount = db.Gopies.Count(dg => dg.MaKs == ks.MaKs)
                          let averageRating = db.Gopies.Where(dg => dg.MaKs == ks.MaKs).Average(dg => (dg.DiemDichVu + dg.DiemThoaiMai + dg.DiemSachSe + dg.DiemDoAn + dg.DiemNhanVien) / 5)
                          where gopiesCount >= 10 && averageRating >= 8
                          orderby ks.TenKhachSan
                          select new KhachSanVM
                          {
                              MaTinh = ks.MaTinh,
                              MaKS = ks.MaKs,
                              TenKS = ks.TenKhachSan,
                              Anh = ks.Anh,
                              DiaChi = ks.DiaChi,
                              DanhGia = ks.DanhGia,
                              Mota = ks.MoTa
                          }).ToList();

            var khuvuc = (from ks in db.KhachSans
                          join t in db.TinhThanhs on ks.MaTinh equals t.MaTinh
                          where ks.Duyet == 1
                          let gopiesCount = db.Gopies.Count(dg => dg.MaKs == ks.MaKs)
                          let averageRating = db.Gopies.Where(dg => dg.MaKs == ks.MaKs)
                                                        .Average(dg => (dg.DiemDichVu + dg.DiemThoaiMai + dg.DiemSachSe + dg.DiemDoAn + dg.DiemNhanVien) / 5)
                          where gopiesCount > 20 && averageRating >= 8
                          group ks by t.TenTinh into g
                          select new
                          {
                              TenTinh = g.Key,
                              Count = g.Count()
                          }).ToList();
            var starCounts = new Dictionary<int, int>
    {
        { 0, db.KhachSans.Count(ks => ks.DanhGia == 0 && ks.Duyet == 1) },
        { 1, db.KhachSans.Count(ks => ks.DanhGia == 1 && ks.Duyet == 1) },
        { 2, db.KhachSans.Count(ks => ks.DanhGia == 2 && ks.Duyet == 1) },
        { 3, db.KhachSans.Count(ks => ks.DanhGia == 3 && ks.Duyet == 1) },
        { 4, db.KhachSans.Count(ks => ks.DanhGia == 4 && ks.Duyet == 1) },
        { 5, db.KhachSans.Count(ks => ks.DanhGia == 5 && ks.Duyet == 1) }
    };
            ViewBag.khuvuc = khuvuc;
            ViewBag.starCounts = starCounts;
            PagedList<KhachSanVM> pagedListResult = new PagedList<KhachSanVM>(listKS, pageNumber, pageSize);
            return View(pagedListResult);
        }
        #endregion

        #region Lọc khách sạn
        [HttpPost]
        public IActionResult LocKhachSan(List<string> selectKhuvuc, List<int> selectStars,int matinh)
        {
            IQueryable<KhachSan> filteredHotels;
            if (matinh > 0)
            {
                 filteredHotels = db.KhachSans.AsTracking()
                .Where(x => x.Duyet == 1 && x.MaTinh == matinh);
            }
            else
            {
                 filteredHotels = db.KhachSans.AsTracking()
                .Where(x => x.Duyet == 1);
            }

            if (selectKhuvuc != null && selectKhuvuc.Count > 0)
            {
                List<KhachSan> tempFilteredHotels = new List<KhachSan>();
                

                if(matinh != 0)
                {
                    foreach (var kv in selectKhuvuc)
                    {
                        // Tạo danh sách các khách sạn lọc theo địa chỉ (khu vực cụ thể)
                        var khuVucFilteredHotels = filteredHotels.Where(x => x.DiaChi.Contains(kv));

                        // Lọc theo tên tỉnh từ bảng TinhThanh

                        // Gộp kết quả lọc từ cả hai điều kiện vào danh sách tạm thời
                        tempFilteredHotels.AddRange(khuVucFilteredHotels);

                    }
                }
                var tinhThanhFilteredHotels = filteredHotels.Join(db.TinhThanhs, ks => ks.MaTinh, t => t.MaTinh, (ks, t) => new { ks, t })
                                                             .Where(x => selectKhuvuc.Contains(x.t.TenTinh))
                                                             .Select(x => x.ks);
                tempFilteredHotels.AddRange(tinhThanhFilteredHotels);
                // Loại bỏ các khách sạn trùng lặp trong danh sách tạm thời
                filteredHotels = tempFilteredHotels.AsQueryable();

            }
            if (selectStars != null && selectStars.Count > 0)
            {
                if(matinh > 0)
                {
                    filteredHotels = filteredHotels.Where(x => x.DanhGia.HasValue && selectStars.Contains(x.DanhGia.Value) && x.MaTinh == matinh);
                }
                else
                {
                    filteredHotels = filteredHotels.Where(x => x.DanhGia.HasValue && selectStars.Contains(x.DanhGia.Value));
                }
            }
            var result = filteredHotels
                .OrderBy(x => x.TenKhachSan)
                .Select(ks => new KhachSanVM
                {
                    MaTinh = ks.MaTinh,
                    MaKS = ks.MaKs,
                    TenKS = ks.TenKhachSan,
                    Anh = ks.Anh,
                    DiaChi = ks.DiaChi,
                    DanhGia = ks.DanhGia,
                    Mota = ks.MoTa
                }).ToList();
            return PartialView("_PartialKhachSan", result);
        }
        #endregion

        #region Đánh giá khách sạn
        [HttpPost]
        public IActionResult DanhGia(DanhGiaKS model, int maks)
        {
            var email = HttpContext.Session.GetString("email");
            var maKh = (from kh in db.KhachHangs
                        where kh.Email == email
                        select kh.MaKh).FirstOrDefault();
            var tenKhachHang = (from kh in db.KhachHangs
                                where kh.MaKh == maKh
                                select kh.TenKh).FirstOrDefault();
            var danhgia = new GopY
            {
                MaKs = maks,
                MaKh = maKh,
                NgayComment = DateTime.Now,
                Comment = model.Comment,
                DiemNhanVien = model.DiemNhanVien,
                DiemDoAn = model.DiemThucAn,
                DiemSachSe = model.DiemSachSe,
                DiemThoaiMai = model.DiemThoaiMai,
                DiemDichVu = model.DiemDichVu
            };
            db.Add(danhgia);
            db.SaveChanges();
            var review = new DanhGiaKS
            {
                TenKh = tenKhachHang,
                NgayComment = DateTime.Now,
                Comment = model.Comment,
                DiemNhanVien = model.DiemNhanVien,
                DiemThucAn = model.DiemThucAn,
                DiemSachSe = model.DiemSachSe,
                DiemThoaiMai = model.DiemThoaiMai,
                DiemDichVu = model.DiemDichVu
            };
            _hubContext.Clients.All.SendAsync("ReceiveReview", review);
            return Json(new { success = true, redirectTo = Url.Action("ChiTietKS", "KhachSan") });
        }
		#endregion
	}
}
