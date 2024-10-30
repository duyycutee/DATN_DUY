using DinkToPdf;
using DinkToPdf.Contracts;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.AspNetCore.Mvc.ViewEngines;
using Microsoft.AspNetCore.Mvc.ViewFeatures;
using Microsoft.EntityFrameworkCore;
using QLKhachSan.Models;
using QLKhachSan.ViewModels;
using QLKhachSan.ViewModels.Admin;
using X.PagedList;

namespace QLKhachSan.Controllers
{
    
    [Authorize]
	public class DoanhNghiepController : Controller
    {
        private readonly QLKhachSanTTTNContext db;
        private readonly IConverter _converter;
        private readonly IWebHostEnvironment _webHostEnvironment;

        public DoanhNghiepController(IWebHostEnvironment webHostEnvironment, QLKhachSanTTTNContext context, IConverter converter)
        {
            _webHostEnvironment = webHostEnvironment;
            db = context;
            _converter = converter;
        }
		#region DoanhThuKhachSan
		public IActionResult DoanhThuKS(int? nam, int? maKhachSan)
        {
            if (!IsUserType("DoanhNghiep"))
            {
                return RedirectToAction("Index", "Home");
            }
            var result = (from hd in db.HoaDons
                          join dp in db.DatPhongs on hd.SoHoaDon equals dp.SoHoaDon
                          join p in db.Phongs on dp.MaPhong equals p.MaPhong
                          join lp in db.LoaiPhongs on p.MaLp equals lp.MaLp
                          join ks in db.KhachSans on lp.MaKs equals ks.MaKs
                          where hd.NgayThanhToan.Value.Year == nam && (maKhachSan == null || ks.MaKs == maKhachSan)
                          group new { hd, dp, p, lp } by new { hd.NgayThanhToan.Value.Month, hd.NgayThanhToan.Value.Year } into g
                          select new DoanhThuVM
                          {
                              Nam = g.Key.Year,
                              Thang = g.Key.Month,
                              TongTien = g.Sum(x => (decimal)(x.lp.Gia * (x.dp.NgayDi.Value.Day - x.dp.NgayDen.Value.Day + 1)) * 60 / 100
                                   + (x.hd.TinhTrang == "Đã hủy" ? (decimal)(x.lp.Gia * (x.dp.NgayDi.Value.Day - x.dp.NgayDen.Value.Day + 1)) * 40 / 100 : 0))
                          }).ToList();
            var email = HttpContext.Session.GetString("email");
            var khachsan = (from ks in db.KhachSans
                            join kh in db.KhachHangs on ks.IdnguoiTao equals kh.MaKh
                            where kh.Email == email
                            select new { ks.MaKs, ks.TenKhachSan }).ToList();
            ViewBag.ks = khachsan;
            ViewBag.nam = nam;
            return View(result);
        }
        #endregion

        #region HoaDonKhachSan
        public IActionResult HoaDonKS(int? maks, int? page)
        {
            if (!IsUserType("DoanhNghiep"))
            {
                return RedirectToAction("Index", "Home");
            }
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
                          }).OrderByDescending(hd => hd.ngaythanhtoan).ToList();
            var email = HttpContext.Session.GetString("email");
            var khachsan = (from ks in db.KhachSans
                            join kh in db.KhachHangs on ks.IdnguoiTao equals kh.MaKh
                            where kh.Email == email
                            select new { ks.MaKs, ks.TenKhachSan }).ToList();
            PagedList<HoaDonVM> lst = new PagedList<HoaDonVM>(hoadon, pageNumber, pageSize);
            ViewBag.pageSize = pageSize;
            ViewBag.MaKS = maks;
            ViewBag.ks = khachsan;
            return View(lst);
        }
        public IActionResult InHoaDon(int sohoadon)
        {
            if (!IsUserType("DoanhNghiep"))
            {
                return RedirectToAction("Index", "Home");
            }
            var hoaDon = db.HoaDons.FirstOrDefault(hd => hd.SoHoaDon == sohoadon);

            if (hoaDon == null)
            {
                return NotFound(); // Trả về mã lỗi 404 nếu không tìm thấy hóa đơn
            }
            var tongtien = (from hd in db.HoaDons
                            join dp in db.DatPhongs on hd.SoHoaDon equals dp.SoHoaDon
                            join p in db.Phongs on dp.MaPhong equals p.MaPhong
                            join lp in db.LoaiPhongs on p.MaLp equals lp.MaLp
                            join ks in db.KhachSans on lp.MaKs equals ks.MaKs
                            where hd.SoHoaDon == sohoadon
                            select lp.Gia * (dp.NgayDi.Value.Day - dp.NgayDen.Value.Day + 1)).FirstOrDefault();
            var chiTietHoaDon = (from hd in db.HoaDons
                                 join dp in db.DatPhongs on hd.SoHoaDon equals dp.SoHoaDon
                                 join p in db.Phongs on dp.MaPhong equals p.MaPhong
                                 join lp in db.LoaiPhongs on p.MaLp equals lp.MaLp
                                 join ks in db.KhachSans on lp.MaKs equals ks.MaKs
                                 where hd.SoHoaDon == sohoadon
                                 select new
                                 {
                                     hd.SoHoaDon,
                                     hd.NgayThanhToan,
                                     ks.DiaChi,
                                     ks.TenKhachSan,
                                     p.TenPhong,
                                     dp.NgayDen,
                                     dp.NgayDi,
                                     dp.SoNguoi
                                 }).FirstOrDefault();
            var ttKH = (from hd in db.HoaDons
                        join kh in db.KhachHangs on hd.MaKh equals kh.MaKh
                        where hd.SoHoaDon == sohoadon
                        select new
                        {
                            kh.TenKh,
                            kh.DiaChi,
                            kh.Sdt,
                            kh.Email
                        }).FirstOrDefault();
            string logoPath = Path.Combine(_webHostEnvironment.WebRootPath, "img", "logo6.png");
            string logoBase64 = ConvertImageToBase64(logoPath);
            var invoiceHtml = @"
    <div style='font-family: Arial, sans-serif; width: 80%; margin: 0 auto; border: 2px solid #ccc; padding: 20px;'>
        <div  style='width:100%; display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;'>
            <div style='width: 16.666667%; text-align: right;'>
                <img src='data:image/jpg;base64," + logoBase64 + @"' alt='Logo' style='max-height: 100px;'>
            </div>
            <div style='width: 83.333333%;'>
                <br/>
                <p style='margin: 5px 0;'><strong>Điện thoại:</strong>" + chiTietHoaDon.DiaChi + @"</p>
                <p style='margin: 5px 0;'><strong>Điện thoại:</strong> 0903888888</p>
            </div>
        </div>
        <h1 style='text-align: center; margin-bottom: 20px; color: #333;'>Hóa đơn Đặt phòng Khách sạn</h1>
        <div style='margin-bottom: 20px;'>
            <p><strong>Số hóa đơn:</strong> " + chiTietHoaDon.SoHoaDon + @"</p>
            <p><strong>Ngày Thu Tiền:</strong> " + chiTietHoaDon.NgayThanhToan + @"</p>
        </div>
        <div style='border: 1px solid #ccc; padding: 10px; margin-bottom: 20px; background-color: #f9f9f9;'>
            <h3 style='text-align: center; margin-top: 0;'>Họ Tên & Địa Chỉ Khách Hàng</h3>
            <p><strong>Họ tên khách hàng:</strong> " + ttKH.TenKh + @"</p>
            <p><strong>Địa chỉ khách hàng:</strong> " + ttKH.DiaChi + @"</p>
            <p><strong>Số điện thoại khách hàng:</strong> " + ttKH.Sdt + @"</p>
            <p><strong>Địa chỉ Email khách hàng:</strong> " + ttKH.Email + @"</p>
        </div>
        <div style='border: 1px solid #ccc; padding: 10px; background-color: #f9f9f9;'>
            <h3 style='text-align: center; margin-top: 0;'>Thông tin chi tiết</h3>
            <p><strong>Tên Khách Sạn:</strong> " + chiTietHoaDon.TenKhachSan + @"</p>
            <p><strong>Thời Gian:</strong> " + chiTietHoaDon.NgayDen + " - " + chiTietHoaDon.NgayDi + @"</p>
            <p><strong>Tên Phòng:</strong> " + chiTietHoaDon.TenPhong + @"</p>
            <p><strong>Số Người:</strong> " + chiTietHoaDon.SoNguoi + @"</p>
        </div>
        <div style='text-align: right; margin-top: 20px;'>
            <h2 style='margin-bottom: 0;'>TỔNG CỘNG TIỀN THANH TOÁN</h2>
            <p style='font-size: 1.2em;'><strong>Tổng Tiền:</strong> " + tongtien + " VND" + @"</p>
        </div>
        <div style='margin-top: 40px; text-align: center;'>
            <p style='margin-bottom: 20px;'>Hóa đơn này được chiết xuất tự động dành cho khách hàng.</p>
        </div>
    </div>
";



            var globalSettings = new GlobalSettings
            {
                ColorMode = ColorMode.Color,
                Orientation = Orientation.Portrait,
                PaperSize = PaperKind.A4,
                Margins = new MarginSettings { Top = 10, Bottom = 10 }
            };

            var objectSettings = new ObjectSettings
            {
                PagesCount = true,
                HtmlContent = invoiceHtml,
                WebSettings = { DefaultEncoding = "UTF-8" }
            };

            var document = new HtmlToPdfDocument
            {
                GlobalSettings = globalSettings,
                Objects = { objectSettings }
            };

            var pdfBytes = _converter.Convert(document);
            var fileName = $"bill-{sohoadon}.pdf";
            var hoadon = (from hd in db.HoaDons
                          where hd.SoHoaDon == sohoadon
                          select hd).FirstOrDefault();
            hoadon.NgayTao = DateTime.Now;
            db.Update(hoadon);
            db.SaveChanges();
            return File(pdfBytes, "application/pdf", fileName);
        }
        public static string ConvertImageToBase64(string imagePath)
        {
            byte[] imageArray = System.IO.File.ReadAllBytes(imagePath);
            return Convert.ToBase64String(imageArray);
        }
        [HttpGet]
        public IActionResult SuaHD(int id)
        {
            if (!IsUserType("DoanhNghiep"))
            {
                return RedirectToAction("Index", "Home");
            }
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
                return RedirectToAction("HoaDonKS");
            }
            return View(model);
        }

        #endregion

        #region KhachSanDoanhNghiep
        public IActionResult KhachSan(int? page)
        {
            if (!IsUserType("DoanhNghiep"))
            {
                return RedirectToAction("Index", "Home");
            }
            int pageSize = 8;
            int pageNumber = page == null || page < 0 ? 1 : page.Value;
            var email = HttpContext.Session.GetString("email");
            var idKH = (from kh in db.KhachHangs
                        where kh.Email == email
                        select kh.MaKh).FirstOrDefault();
            var khachsan = (from ks in db.KhachSans
                            join tt in db.TinhThanhs on ks.MaTinh equals tt.MaTinh
                            join kh in db.KhachHangs on ks.IdnguoiTao equals kh.MaKh
                            where kh.MaKh == idKH
                            select new KhachSanVM
                            {
                                MaKS = ks.MaKs,
                                TenKS = ks.TenKhachSan,
                                Anh = ks.Anh,
                                TenTinh = tt.TenTinh,
                                DiaChi = ks.DiaChi,
                                Duyet = ks.Duyet,
                                Mota = ks.MoTa
                            }).ToList();
            PagedList<KhachSanVM> lst = new PagedList<KhachSanVM>(khachsan, pageNumber, pageSize);
            return View(lst);
        }
        public IActionResult ThemKS()
        {
            if (!IsUserType("DoanhNghiep"))
            {
                return RedirectToAction("Index", "Home");
            }
            var lastMaKS = db.Phongs.OrderByDescending(p => p.MaPhong).FirstOrDefault()?.MaPhong ?? 0;
            var nextMaKS = lastMaKS + 1;
            ViewBag.nextMaKS = nextMaKS;
            return View();
        }
        [HttpPost]
        public IActionResult ThemKS(KhachSanVM model, IFormFile Anh)
        {
            if (ModelState.IsValid)
            {
                var fileName = Path.GetFileName(Anh.FileName);
                // Lưu tệp vào thư mục trên máy chủ
                var filePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "img", "Images", "khachsan", fileName);

                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    Anh.CopyTo(stream);
                }

                var matinh = (from tt in db.TinhThanhs
                              where tt.TenTinh == model.TenTinh
                              select tt.MaTinh).FirstOrDefault();
                var email = HttpContext.Session.GetString("email");
                var idKH = (from kh in db.KhachHangs
                            where kh.Email == email
                            select kh.MaKh).FirstOrDefault();

                var fullAddress = $"{model.DiaChi}, {model.TenXa}, {model.TenHuyen}, {model.TenTinh}";

                var ks = new KhachSan
                {
                    MaKs = model.MaKS,
                    MaTinh = matinh,
                    TenKhachSan = model.TenKS,
                    DanhGia = model.DanhGia,
                    Anh = fileName,
                    DiaChi = fullAddress,
                    MoTa = model.Mota,
                    Duyet = 0,
                    IdnguoiTao = idKH
                };
                db.Add(ks);
                db.SaveChanges();
                TempData["Message"] = "Bạn đã thêm khách sạn thành công, vui lòng đợi quản trị viên duyệt khách sạn và đừng quên check mail nhá!";
                return Redirect("KhachSan");
            }
            return View();
        }

        [HttpGet]
        public IActionResult SuaKS(int id)
        {
            if (!IsUserType("DoanhNghiep"))
            {
                return RedirectToAction("Index", "Home");
            }
            var khachsan = (from ks in db.KhachSans
                            join tt in db.TinhThanhs on ks.MaTinh equals tt.MaTinh
                            where ks.MaKs == id
                            select new KhachSanVM
                            {
                                MaKS = ks.MaKs,
                                TenKS = ks.TenKhachSan,
                                MaTinh = ks.MaTinh,
                                DiaChi = ks.DiaChi,
                                Anh = ks.Anh,
                                Mota = ks.MoTa,
                                TenTinh = tt.TenTinh
                            }).FirstOrDefault();
            return View(khachsan);
        }
        [HttpPost]
        public IActionResult SuaKS(KhachSanVM model, IFormFile? Anh)
        {
            if (ModelState.IsValid)
            {
                var ks = db.KhachSans.FirstOrDefault(p => p.MaKs == model.MaKS);
                var fullAddress = $"{model.DiaChi}, {model.TenXa}, {model.TenHuyen}, {model.TenTinh}";
                var matinh = (from tt in db.TinhThanhs
                              where tt.TenTinh == model.TenTinh
                              select tt.MaTinh).FirstOrDefault();
                if (ks != null)
                {
                    if (Anh != null && Anh.Length > 0)
                    {
                        var filename = Path.GetFileName(Anh.FileName);
                        var filePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "img", "Images", "khachsan", filename);
                        using (var stream = new FileStream(filePath, FileMode.Create))
                        {
                            Anh.CopyTo(stream);
                        }
                        ks.Anh = filename;
                    }
                    ks.TenKhachSan = model.TenKS;
                    ks.MaTinh = matinh;
                    ks.DiaChi = fullAddress;
                    ks.MoTa = model.Mota;

                    db.Update(ks);
                    db.SaveChanges();
                    TempData["Message"] = "Cập nhật khách sạn thành công!";
                    return RedirectToAction("KhachSan");
                }
            }
            return View(model);
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
        [HttpGet]
        public IActionResult XoaKS(int id)
        {
            if (!IsUserType("DoanhNghiep"))
            {
                return RedirectToAction("Index", "Home");
            }
            var loaiphong = db.LoaiPhongs.Where(x => x.MaKs == id).ToList();
            if (loaiphong.Count() > 0)
            {
                TempData["Message"] = "Không thể xóa khách sạn này vì nó có loại phòng liên quan.";
                return RedirectToAction("KhachSan", "DoanhNghiep");
            }
            var khachSan = db.KhachSans.Find(id);
            if (khachSan == null)
            {
                TempData["Message"] = "Khách sạn không tồn tại";
                return RedirectToAction("KhachSan", "DoanhNghiep");
            }
            db.KhachSans.Remove(khachSan);
            db.SaveChanges();
            TempData["Message"] = "Khách sạn đã được xóa";
            return RedirectToAction("KhachSan", "DoanhNghiep");
        }
        #endregion

        #region LoaiPhongDoanhNghiep
        public IActionResult LoaiPhong(int maks, int? page)
        {
            if (!IsUserType("DoanhNghiep"))
            {
                return RedirectToAction("Index", "Home");
            }
            int pageSize = 8;
            int pageNumber = page == null || page < 0 ? 1 : page.Value;
            var email = HttpContext.Session.GetString("email");
            var loaipphong = (from lp in db.LoaiPhongs
                              join ks in db.KhachSans on lp.MaKs equals ks.MaKs
                              where ks.MaKs == maks
                              select new LoaiPhongVM
                              {
                                  malp = lp.MaLp,
                                  tenks = ks.TenKhachSan,
                                  tenlp = lp.TenLp,
                                  anh = lp.Anh,
                                  songuoitoida = lp.SoNguoiToiDa,
                                  gia = lp.Gia,
                                  thongtin = lp.ThongTin,
                                  kichthuoc = lp.KichThuoc
                              }).OrderBy(x => x.malp);
            PagedList<LoaiPhongVM> lst = new PagedList<LoaiPhongVM>(loaipphong, pageNumber, pageSize);
            var khachsan = (from ks in db.KhachSans
                            join kh in db.KhachHangs on ks.IdnguoiTao equals kh.MaKh
                            where kh.Email == email
                            select new { ks.MaKs, ks.TenKhachSan }).ToList();
            ViewBag.ks = khachsan;
            ViewBag.maks = maks;
            return View(lst);
        }

        public IActionResult ThemLP()
        {
            if (!IsUserType("DoanhNghiep"))
            {
                return RedirectToAction("Index", "Home");
            }
            var email = HttpContext.Session.GetString("email");
            var lastMaLP = db.LoaiPhongs.OrderByDescending(p => p.MaLp).FirstOrDefault()?.MaLp ?? 0;
            var nextMaLP = lastMaLP + 1;
            ViewBag.nextMaLP = nextMaLP;
            var khachsan = from ks in db.KhachSans
                           join kh in db.KhachHangs on ks.IdnguoiTao equals kh.MaKh
                           where kh.Email == email
                           select new
                           {
                               ks.MaKs,
                               ks.TenKhachSan
                           };
            ViewBag.MaKs = new SelectList(khachsan.ToList(), "MaKs", "TenKhachSan");
            var thietbi = (from tb in db.ThietBis
                           select tb.TenTb).ToList();
            ViewBag.thietbi = thietbi;
            return View();
        }
        [HttpPost]
        public IActionResult ThemLP(LoaiPhongVM model, IFormFile Anh, string[] thietbi)
        {
            if (ModelState.IsValid)
            {
                var existingLoaiPhong = db.LoaiPhongs
            .Where(lp => lp.TenLp == model.tenlp && lp.MaKs == model.maks)
            .FirstOrDefault();

                if (existingLoaiPhong != null)
                {
                    TempData["Message"] = "Tên loại phòng đã tồn tại trong khách sạn này.";
                    return RedirectToAction("ThemLP");
                }
                var fileName = Path.GetFileName(Anh.FileName);
                // Lưu tệp vào thư mục trên máy chủ
                var filePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "img", "Images", "phong", fileName);

                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    Anh.CopyTo(stream);
                }
                var loaiphong = new LoaiPhong
                {
                    MaKs = model.maks,
                    TenLp = model.tenlp,
                    Anh = fileName,
                    Gia = model.gia,
                    ThongTin = model.thongtin,
                    SoNguoiToiDa = model.songuoitoida,
                    KichThuoc = model.kichthuoc
                };
                db.Add(loaiphong);
                db.SaveChanges();
                if (thietbi != null && thietbi.Length > 0)
                {
                    var malp = (from lp in db.LoaiPhongs
                                where lp.TenLp == model.tenlp && lp.MaKs == model.maks
                                select lp.MaLp).FirstOrDefault();
                    foreach (var thietBi in thietbi)
                    {
                        var matb = (from tb in db.ThietBis
                                    where tb.TenTb == thietBi
                                    select tb.MaTb).FirstOrDefault();
                        var suDungThietBi = new SuDungThietBi
                        {
                            MaTb = matb,
                            MaLp = malp
                        };
                        db.Add(suDungThietBi);
                    }
                    db.SaveChanges();
                    TempData["Message"] = "Thêm loại phòng thành công";
                }
                return RedirectToAction("LoaiPhong");
            }
            return View(model);
        }

        public IActionResult SuaLP(int id)
        {
            if (!IsUserType("DoanhNghiep"))
            {
                return RedirectToAction("Index", "Home");
            }
            var loaiphong = (from lp in db.LoaiPhongs
                             join ks in db.KhachSans on lp.MaKs equals ks.MaKs
                             join sdtb in db.SuDungThietBis on lp.MaLp equals sdtb.MaLp
                             join tb in db.ThietBis on sdtb.MaTb equals tb.MaTb
                             where lp.MaLp == id
                             select new LoaiPhongVM()
                             {
                                 malp = lp.MaLp,
                                 tenlp = lp.TenLp,
                                 tenks = ks.TenKhachSan,
                                 songuoitoida = lp.SoNguoiToiDa,
                                 gia = lp.Gia,
                                 kichthuoc = lp.KichThuoc,
                                 thongtin = lp.ThongTin,
                                 anh = lp.Anh
                             }).FirstOrDefault();
            var tenthietbi = (from sdtb in db.SuDungThietBis
                              join tb in db.ThietBis on sdtb.MaTb equals tb.MaTb
                              where sdtb.MaLp == id
                              select tb.TenTb).ToList();
            var thietbi = (from tb in db.ThietBis
                           select tb.TenTb).ToList();
            ViewBag.tenthietbi = tenthietbi;
            ViewBag.thietbi = thietbi;
            return View(loaiphong);
        }
        [HttpPost]
        public IActionResult SuaLP(LoaiPhongVM model, IFormFile? Anh, string[] thietbi)
        {
            var lp = db.LoaiPhongs.FirstOrDefault(p => p.MaLp == model.malp);
            if (lp != null)
            {
                if (Anh != null && Anh.Length > 0)
                {
                    var filename = Path.GetFileName(Anh.FileName);
                    var filePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "img", "Images", "phong", filename);
                    using (var stream = new FileStream(filePath, FileMode.Create))
                    {
                        Anh.CopyTo(stream);
                    }
                    lp.Anh = filename;
                }
                lp.TenLp = model.tenlp;
                lp.SoNguoiToiDa = model.songuoitoida;
                lp.Gia = model.gia;
                lp.KichThuoc = model.kichthuoc;
                lp.ThongTin = model.thongtin;

                db.Update(lp);
                db.SaveChanges();
                var oldTBs = db.SuDungThietBis.Where(x => x.MaLp == model.malp).ToList();
                foreach (var tb in oldTBs)
                {
                    db.Remove(tb);
                }
                foreach (var thietBi in thietbi)
                {
                    var matb = (from tb in db.ThietBis
                                where tb.TenTb == thietBi
                                select tb.MaTb).FirstOrDefault();
                    var suDungThietBi = new SuDungThietBi
                    {
                        MaTb = matb,
                        MaLp = model.malp,
                    };
                    db.Add(suDungThietBi);
                }
                db.SaveChanges();
                TempData["Message"] = "Cập nhật loại phòng thành công";
                return RedirectToAction("LoaiPhong");
            }
            return View(model);
        }
        public IActionResult XoaLP(int? id)
        {
            if (!IsUserType("DoanhNghiep"))
            {
                return RedirectToAction("Index", "Home");
            }
            var phong = db.Phongs.Where(x => x.MaLp == id).ToList();
            if (phong.Count() > 0)
            {
                TempData["Message"] = "Không thể xóa loại phòng này";
                return RedirectToAction("LoaiPhong", "DoanhNghiep");
            }
            var loaiphong = db.LoaiPhongs.Find(id);
            if (loaiphong == null)
            {
                TempData["Message"] = "Loại phòng không tồn tại";
                return RedirectToAction("LoaiPhong", "DoanhNghiep");
            }

            db.LoaiPhongs.Remove(loaiphong);
            db.SaveChanges();
            TempData["Message"] = "Loại phòng đã được xóa";
            return RedirectToAction("LoaiPhong", "DoanhNghiep");
        }
        #endregion

        #region PhongDoanhNghiep
        public IActionResult Phong(int maks, int? page)
        {
            if (!IsUserType("DoanhNghiep"))
            {
                return RedirectToAction("Index", "Home");
            }
            int pageSize = 8;
            int pageNumber = page == null || page < 0 ? 1 : page.Value;
            var phong = (from p in db.Phongs
                         join lp in db.LoaiPhongs on p.MaLp equals lp.MaLp
                         join ks in db.KhachSans on lp.MaKs equals ks.MaKs
                         where ks.MaKs == maks
                         select new PhongVM
                         {
                             MaPhong = p.MaPhong,
                             TenPhong = p.TenPhong,
                             Anh = p.Anh,
                             MoTa = p.MoTa,
                             TenLP = lp.TenLp,
                             TenKS = ks.TenKhachSan
                         }).OrderBy(x => x.MaPhong);
            PagedList<PhongVM> lst = new PagedList<PhongVM>(phong, pageNumber, pageSize);
            var datPhongs = db.DatPhongs.ToList(); // Lấy danh sách các đơn đặt phòng
            var datPhongDictionary = new Dictionary<int, List<DateTime>>(); // Dictionary để lưu các ngày đã đặt của từng phòng

            foreach (var datPhong in datPhongs)
            {
                var ngayDen = datPhong.NgayDen.Value.AddDays(-1);
                var soNgayTrongKhoang = (int)(datPhong.NgayDi - datPhong.NgayDen).Value.TotalDays + 1;
                var result = new List<DateTime>();

                for (var i = 0; i < soNgayTrongKhoang; i++)
                {
                    result.Add(ngayDen.AddDays(i + 1));
                }

                // Lưu danh sách các ngày đã đặt vào Dictionary
                if (!datPhongDictionary.ContainsKey(datPhong.MaPhong))
                {
                    datPhongDictionary.Add(datPhong.MaPhong, result);
                }
                else
                {
                    datPhongDictionary[datPhong.MaPhong].AddRange(result);
                }
            }
            var email = HttpContext.Session.GetString("email");
            var khachsan = (from ks in db.KhachSans
                            join kh in db.KhachHangs on ks.IdnguoiTao equals kh.MaKh
                            where kh.Email == email
                            select new { ks.MaKs, ks.TenKhachSan }).ToList();
            ViewBag.MaKS = maks;
            ViewBag.ks = khachsan;

            ViewBag.DatPhongDictionary = datPhongDictionary;

            return View(lst);
        }
        [HttpGet]
        public IActionResult ThemPhong(int? maks)
        {
            if (!IsUserType("DoanhNghiep"))
            {
                return RedirectToAction("Index", "Home");
            }
            var email = HttpContext.Session.GetString("email");
            var lastMaPhong = db.Phongs.OrderByDescending(p => p.MaPhong).FirstOrDefault()?.MaPhong ?? 0;
            var nextMaPhong = lastMaPhong + 1;
            ViewBag.NextMaPhong = nextMaPhong;
            var khachsan = from ks in db.KhachSans
                           join kh in db.KhachHangs on ks.IdnguoiTao equals kh.MaKh
                           where kh.Email == email
                           select new
                           {
                               ks.MaKs,
                               ks.TenKhachSan
                           };
            ViewBag.MaKs = new SelectList(khachsan.ToList(), "MaKs", "TenKhachSan");
            var loaiPhongs = from lp in db.LoaiPhongs
                             where lp.MaKs == maks
                             select new
                             {
                                 lp.MaLp,
                                 lp.TenLp
                             };
            ViewBag.MaLp = new SelectList(loaiPhongs.ToList(), "MaLp", "TenLp");
            return View();
        }
        [HttpPost]
        public IActionResult ThemPhong(PhongVM model, IFormFile Anh, List<IFormFile> AnhDetail)
        {
            var email = HttpContext.Session.GetString("email");
            if (ModelState.IsValid)
            {
                bool isPhongAdded = false;
                int newPhongId = 0;
                // Lấy tên tệp
                var fileName = Path.GetFileName(Anh.FileName);
                // Lưu tệp vào thư mục trên máy chủ
                var filePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "img", "Images", "phong", fileName);

                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    Anh.CopyTo(stream);
                }
                foreach (var file in AnhDetail)
                {
                    if (file != null && file.Length > 0)
                    {
                        var fileName1 = Path.GetFileName(file.FileName);
                        var filePath1 = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "img", "Images", "phong", fileName1);

                        using (var stream = new FileStream(filePath1, FileMode.Create))
                        {
                            file.CopyTo(stream);
                        }
                        var check = db.Ctanhs
                            .Where(ctanh => ctanh.TenAnh.Contains(fileName1))
                            .Count();
                        if (check == 0)
                        {
                            if (!isPhongAdded)
                            {
                                var phong = new Phong
                                {
                                    MaLp = model.MaLP,
                                    TenPhong = model.TenPhong,
                                    Anh = fileName,
                                    MoTa = model.MoTa
                                };
                                db.Add(phong);
                                db.SaveChanges();
                                isPhongAdded = true;
                                newPhongId = phong.MaPhong;
                            }
                            var anhChiTiet = new Ctanh
                            {
                                MaPhong = newPhongId, // Thay bằng ID của phòng chính
                                TenAnh = fileName1
                            };
                            // Lưu thông tin vào cơ sở dữ liệu
                            db.Add(anhChiTiet);
                            db.SaveChanges();
                        }
                        else
                        {
                            TempData["Message"] = "Ảnh chi tiết đã tồn tại";
                            return RedirectToAction("ThemPhong");
                        }
                    }
                }
                TempData["Message"] = "Thêm mới phòng thành công!";
                return RedirectToAction("Phong", "DoanhNghiep");
            }
            var khachsan = from ks in db.KhachSans
                           join kh in db.KhachHangs on ks.IdnguoiTao equals kh.MaKh
                           where kh.Email == email
                           select new
                           {
                               ks.MaKs,
                               ks.TenKhachSan
                           };
            ViewBag.MaKs = new SelectList(khachsan.ToList(), "MaKs", "TenKhachSan");
            var loaiPhongs = from lp in db.LoaiPhongs
                             where lp.MaKs == model.MaKS
                             select new
                             {
                                 lp.MaLp,
                                 lp.TenLp
                             };
            ViewBag.MaLp = new SelectList(loaiPhongs.ToList(), "MaLp", "TenLp");
            return View();
        }
        public IActionResult GetLoaiPhongByKhachSan(int maks)
        {
            var loaiPhongs = db.LoaiPhongs.Where(lp => lp.MaKs == maks).ToList();
            return Json(loaiPhongs);
        }

        [HttpGet]
        public IActionResult SuaPhong(int id)
        {
            if (!IsUserType("DoanhNghiep"))
            {
                return RedirectToAction("Index", "Home");
            }
            var email = HttpContext.Session.GetString("email");
            var maks = (from ks in db.KhachSans
                        join lp in db.LoaiPhongs on ks.MaKs equals lp.MaKs
                        join p in db.Phongs on lp.MaLp equals p.MaLp
                        where p.MaPhong == id
                        select ks.MaKs).FirstOrDefault();
            var loaiPhongs = from lp in db.LoaiPhongs
                             where lp.MaKs == maks
                             select new
                             {
                                 lp.MaLp,
                                 lp.TenLp
                             };
            ViewBag.MaLp = new SelectList(loaiPhongs.ToList(), "MaLp", "TenLp");
            var phong = (from p in db.Phongs
                         join anh in db.Ctanhs on p.MaPhong equals anh.MaPhong
                         where p.MaPhong == id
                         select new PhongVM
                         {
                             MaPhong = p.MaPhong,
                             TenPhong = p.TenPhong,
                             MaLP = p.MaLp,
                             Anh = p.Anh,
                             MoTa = p.MoTa,
                             AnhDetail = anh.TenAnh
                         }).FirstOrDefault();
            return View(phong);
        }
        [HttpPost]
        public IActionResult SuaPhong(PhongVM model, IFormFile Anh, List<IFormFile> AnhDetail)
        {
            var email = HttpContext.Session.GetString("email");
            var phongToUpdate = db.Phongs.FirstOrDefault(p => p.MaPhong == model.MaPhong);
            bool isUpdateAnh = false;
            if (phongToUpdate != null)
            {
                if (Anh != null && Anh.Length > 0)
                {
                    var filename = Path.GetFileName(Anh.FileName);
                    var filePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "img", "Images", "phong", filename);
                    using (var stream = new FileStream(filePath, FileMode.Create))
                    {
                        Anh.CopyTo(stream);
                    }
                    phongToUpdate.Anh = filename;
                }
                phongToUpdate.TenPhong = model.TenPhong;
                phongToUpdate.MaLp = model.MaLP;
                phongToUpdate.MoTa = model.MoTa;

                db.Update(phongToUpdate);
                db.SaveChanges();
                var oldCtanhs = db.Ctanhs.Where(x => x.MaPhong == model.MaPhong).ToList();
                foreach (var oldCtanh in oldCtanhs)
                {
                    db.Remove(oldCtanh);
                }
                foreach (var file in AnhDetail)
                {
                    if (file != null && file.Length > 0)
                    {
                        var fileName1 = Path.GetFileName(file.FileName);
                        var filePath1 = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "img", "Images", "phong", fileName1);

                        using (var stream = new FileStream(filePath1, FileMode.Create))
                        {
                            file.CopyTo(stream);
                        }

                        // Tạo một chi tiết ảnh mới
                        var newCtanh = new Ctanh
                        {
                            MaPhong = model.MaPhong,
                            TenAnh = fileName1
                        };

                        // Thêm chi tiết ảnh mới vào cơ sở dữ liệu
                        db.Add(newCtanh);
                        db.SaveChanges();
                    }
                }
                TempData["Message"] = "Cập nhật phòng thành công.";
                return RedirectToAction("Phong");
            }
            var khachsan = from ks in db.KhachSans
                           join kh in db.KhachHangs on ks.IdnguoiTao equals kh.MaKh
                           where kh.Email == email
                           select new
                           {
                               ks.MaKs,
                               ks.TenKhachSan
                           };
            ViewBag.MaKs = new SelectList(khachsan.ToList(), "MaKs", "TenKhachSan");
            var loaiPhongs = from lp in db.LoaiPhongs
                             where lp.MaKs == model.MaKS
                             select new
                             {
                                 lp.MaLp,
                                 lp.TenLp
                             };
            ViewBag.MaLp = new SelectList(loaiPhongs.ToList(), "MaLp", "TenLp");
            return View(model);
        }
        [HttpGet]
        public IActionResult XoaPhong(int id)
        {
            if (!IsUserType("DoanhNghiep"))
            {
                return RedirectToAction("Index", "Home");
            }
            var datphong = (from dp in db.DatPhongs
                            where dp.NgayDi > DateTime.Now && dp.MaPhong == id
                            select dp).Count();
            if (datphong > 0)
            {
                TempData["Message"] = "Phòng không thể xóa vì phòng đang được đặt";
                return RedirectToAction("Phong");
            }
            db.Remove(db.Phongs.Find(id));
            db.SaveChanges();
            TempData["Message"] = "Đã xóa phòng thành công";
            return RedirectToAction("Phong");
        }
        #endregion

        #region ThietBiPhong
        public IActionResult ThietBi(int? maks, int? page)
        {
            if (!IsUserType("DoanhNghiep"))
            {
                return RedirectToAction("Index", "Home");
            }
            int pageSize = 8;
            int pageNumber = page == null || page < 0 ? 1 : page.Value;
            var thietbi = (from tb in db.ThietBis
                           join sdtb in db.SuDungThietBis on tb.MaTb equals sdtb.MaTb
                           join lp in db.LoaiPhongs on sdtb.MaLp equals lp.MaLp
                           join ks in db.KhachSans on lp.MaKs equals ks.MaKs
                           where ks.MaKs == maks
                           select new ThietBiVM
                           {
                               MaTB = tb.MaTb,
                               TenTB = tb.TenTb,
                               TenLP = lp.TenLp
                           }).OrderBy(x => x.TenLP);
            PagedList<ThietBiVM> lst = new PagedList<ThietBiVM>(thietbi, pageNumber, pageSize);
            var email = HttpContext.Session.GetString("email");
            var khachsan = (from ks in db.KhachSans
                            join kh in db.KhachHangs on ks.IdnguoiTao equals kh.MaKh
                            where kh.Email == email
                            select new { ks.MaKs, ks.TenKhachSan }).ToList();
            ViewBag.pageSize = pageSize;
            ViewBag.MaKS = maks;
            ViewBag.ks = khachsan;
            return View(lst);
        }

        [HttpGet]
        public IActionResult ThemTB(int maks)
        {
            if (!IsUserType("DoanhNghiep"))
            {
                return RedirectToAction("Index", "Home");
            }
            var email = HttpContext.Session.GetString("email");
            var lastMaTB = db.Phongs.OrderByDescending(p => p.MaPhong).FirstOrDefault()?.MaPhong ?? 0;
            var nextMaTB = lastMaTB + 1;
            ViewBag.NextMaTB = nextMaTB;
            var khachsan = from ks in db.KhachSans
                           join kh in db.KhachHangs on ks.IdnguoiTao equals kh.MaKh
                           where kh.Email == email
                           select new
                           {
                               ks.MaKs,
                               ks.TenKhachSan
                           };
            ViewBag.MaKs = new SelectList(khachsan.ToList(), "MaKs", "TenKhachSan");
            var loaiPhongs = from lp in db.LoaiPhongs
                             where lp.MaKs == maks
                             select new
                             {
                                 lp.MaLp,
                                 lp.TenLp
                             };
            ViewBag.MaLp = new SelectList(loaiPhongs.ToList(), "MaLp", "TenLp");
            return View();
        }
        [HttpPost]
        public IActionResult ThemTB(ThietBiVM model)
        {
            if (ModelState.IsValid)
            {
                var thietbi = new ThietBi
                {
                    TenTb = model.TenTB
                };
                db.Add(thietbi);
                db.SaveChanges();
                var maTb = (from tb in db.ThietBis
                            where tb.TenTb == model.TenTB
                            select tb.MaTb).FirstOrDefault();
                var sudungthietbi = new SuDungThietBi
                {
                    MaLp = model.MaLP, // Thay bằng ID của phòng chính
                    MaTb = maTb
                };
                // Lưu thông tin vào cơ sở dữ liệu
                db.Add(sudungthietbi);
                db.SaveChanges();
                TempData["Message"] = "Thêm thiết bị thành công";
                return Redirect("ThietBi");
            }

            return RedirectToAction("ProFile", "KhachHang");
        }
        [HttpGet]
        public IActionResult SuaTB(int id)
        {
            if (!IsUserType("DoanhNghiep"))
            {
                return RedirectToAction("Index", "Home");
            }
            var maks = (from ks in db.KhachSans
                        join lp in db.LoaiPhongs on ks.MaKs equals lp.MaKs
                        join sdtb in db.SuDungThietBis on lp.MaLp equals sdtb.MaLp
                        join tb in db.ThietBis on sdtb.MaTb equals tb.MaTb
                        where tb.MaTb == id
                        select ks.MaKs).FirstOrDefault();
            var loaiPhongs = from lp in db.LoaiPhongs
                             where lp.MaKs == maks
                             select new
                             {
                                 lp.MaLp,
                                 lp.TenLp
                             };
            ViewBag.MaLp = new SelectList(loaiPhongs.ToList(), "MaLp", "TenLp");
            var thietbi = (from tb in db.ThietBis
                           join sdtb in db.SuDungThietBis on tb.MaTb equals sdtb.MaTb
                           join lp in db.LoaiPhongs on sdtb.MaLp equals lp.MaLp
                           where tb.MaTb == id
                           select new ThietBiVM
                           {
                               MaTB = tb.MaTb,
                               TenTB = tb.TenTb,
                               MaLP = sdtb.MaLp
                           }).FirstOrDefault();
            return View(thietbi);
        }
        [HttpPost]
        public IActionResult SuaTB(ThietBiVM model)
        {
            var email = HttpContext.Session.GetString("email");
            if (ModelState.IsValid)
            {
                var tbUpdate = db.ThietBis.FirstOrDefault(p => p.MaTb == model.MaTB);

                tbUpdate.TenTb = model.TenTB;
                db.Update(tbUpdate);
                db.SaveChanges();

                TempData["Message"] = "Cập nhật thiết bị thành công.";
                return RedirectToAction("ThietBi");
            }
            var khachsan = from ks in db.KhachSans
                           join kh in db.KhachHangs on ks.IdnguoiTao equals kh.MaKh
                           where kh.Email == email
                           select new
                           {
                               ks.MaKs,
                               ks.TenKhachSan
                           };
            ViewBag.MaKs = new SelectList(khachsan.ToList(), "MaKs", "TenKhachSan");
            var loaiPhongs = from lp in db.LoaiPhongs
                             where lp.MaKs == model.MaKS
                             select new
                             {
                                 lp.MaLp,
                                 lp.TenLp
                             };
            ViewBag.MaLp = new SelectList(loaiPhongs.ToList(), "MaLp", "TenLp");
            return View(model);
        }
        public IActionResult XoaTB(int id)
        {
            if (!IsUserType("DoanhNghiep"))
            {
                return RedirectToAction("Index", "Home");
            }
            var suDungThietBis = db.SuDungThietBis.Where(s => s.MaTb == id).ToList();
            db.SuDungThietBis.RemoveRange(suDungThietBis);

            var thietBi = db.ThietBis.Find(id);
            if (thietBi != null)
            {
                db.ThietBis.Remove(thietBi);
            }

            db.SaveChanges();
            TempData["Message"] = "Đã xóa thiết bị thành công";
            return RedirectToAction("ThietBi");
        }
        #endregion
        private bool IsUserType(string userType)
        {
            var userTypeInSession = HttpContext.Session.GetString("UserType");
            return userTypeInSession == userType;
        }
    }
}

