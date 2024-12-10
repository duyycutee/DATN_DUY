using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using QLKhachSan.Models;
using QLKhachSan.ViewModels.Admin;
using QLKhachSan.ViewModels;
using X.PagedList;
using Microsoft.AspNetCore.Mvc.RazorPages;
using NuGet.Common;
using System.Net.Mail;
using System.Net;

namespace QLKhachSan.Areas.Admin.Controllers
{
    [Area("admin")]
    [Authorize(Roles = "Admin")]
    public class KhachSanAdminController : Controller
    {
        QLKhachSanTTTNContext db = new QLKhachSanTTTNContext();
        #region Khách sạn
        [Route("khachsan")]
        public IActionResult KhachSan(int? page)
        {
            int pageSize = 8;
            int pageNumber = page == null || page < 0 ? 1 : page.Value;
            var khachsan = (from ks in db.KhachSans
                            join tt in db.TinhThanhs on ks.MaTinh equals tt.MaTinh
                            select new KhachSanVM
                            {
                                MaKS = ks.MaKs,
                                TenKS = ks.TenKhachSan,
                                Anh = ks.Anh,
                                TenTinh = tt.TenTinh,
                                DiaChi = ks.DiaChi,
                                Duyet = ks.Duyet,
                                Mota = ks.MoTa
                            }).OrderBy(x => x.MaKS);
            var soks = (from ks in db.KhachSans
                       where ks.Duyet == 0
                       select ks).Count();
            ViewBag.soks = soks;
            PagedList<KhachSanVM> lst = new PagedList<KhachSanVM>(khachsan, pageNumber, pageSize);

            return View(lst);
        }
        [Route("themks")]
        [HttpGet]
        public IActionResult ThemKS()
        {
            var lastMaKS = db.Phongs.OrderByDescending(p => p.MaPhong).FirstOrDefault()?.MaPhong ?? 0;
            var nextMaKS = lastMaKS + 1;
            ViewBag.nextMaKS = nextMaKS;
            return View();
        }
        [Route("themks")]
        [HttpPost]
        public IActionResult ThemKS(KhachSanVM model, IFormFile Anh)
        {
            if (ModelState.IsValid)
            {
                var fileName = Path.GetFileName(Anh.FileName);
                // Lưu tệp vào thư mục trên máy chủ
                var filePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "img", "Images","khachsan", fileName);

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

                // Kết hợp địa chỉ cụ thể từ các phần của địa chỉ
                var fullAddress = $"{model.TenTinh}, {model.TenHuyen}, {model.TenXa}, {model.DiaChi}";

                var ks = new KhachSan
                {
                    MaKs = model.MaKS,
                    MaTinh = matinh,
                    TenKhachSan = model.TenKS,
                    DanhGia = model.DanhGia,
                    Anh = fileName,
                    DiaChi = fullAddress,  // Lưu địa chỉ đầy đủ
                    MoTa = model.Mota,
                    Duyet = 0
                };
                db.Add(ks);
                db.SaveChanges();
                TempData["Message"] = "Thêm mới khách sạn thành công!";
                return RedirectToAction("KhachSan");
            }
            return View(model);
        }

        [Route("suaks")]
        [HttpGet]
        public IActionResult SuaKS(int id)
        {
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
        [Route("suaks")]
        [HttpPost]
        public IActionResult SuaKS(KhachSanVM model, IFormFile? Anh)
        {
            if (ModelState.IsValid)
            {
                var ks = db.KhachSans.FirstOrDefault(p => p.MaKs == model.MaKS);
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
                    var fullAddress = $"{model.TenTinh}, {model.TenHuyen}, {model.TenXa}, {model.DiaChi}";
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
        [Route("duyetks")]
        [HttpGet]
        public IActionResult DanhSachDuyet(int? page)
        {
			int pageSize = 8;
			int pageNumber = page == null || page < 0 ? 1 : page.Value;
			var khachsan = (from ks in db.KhachSans
							join tt in db.TinhThanhs on ks.MaTinh equals tt.MaTinh
                            where ks.Duyet == 0
							select new KhachSanVM
							{
								MaKS = ks.MaKs,
								TenKS = ks.TenKhachSan,
								Anh = ks.Anh,
								TenTinh = tt.TenTinh,
								DiaChi = ks.DiaChi,
								Duyet = ks.Duyet,
								Mota = ks.MoTa
							}).OrderBy(x => x.MaKS);
			PagedList<KhachSanVM> lst = new PagedList<KhachSanVM>(khachsan, pageNumber, pageSize);

			return View(lst);
		}

        [Route("Duyet")]
        [HttpPost]
        public IActionResult Duyet(int maKS, int newValue)
        {
            var khachSan = db.KhachSans.Find(maKS);
            if (khachSan != null)
            {
                khachSan.Duyet = newValue;
                db.SaveChanges();

                if (newValue == 1) 
                {
                    var email = (from ks in db.KhachSans
                                 join kh in db.KhachHangs on ks.IdnguoiTao equals kh.MaKh
                                 where ks.MaKs == maKS
                                 select kh.Email).FirstOrDefault();

                    if (!string.IsNullOrEmpty(email))
                    {
                        var smtpClient = new SmtpClient("smtp.gmail.com")
                        {
                            Port = 587,
                            Credentials = new NetworkCredential("vudinhduy3012003@gmail.com", "yhifkumtzgqnbblm"),
                            EnableSsl = true,
                        };

                        // Tạo nội dung email với đường dẫn đặt lại mật khẩu
                        var emailContent = $@"
                    <html>
                    <head>
                        <style>
                            .email-container {{
                                font-family: Arial, sans-serif;
                                line-height: 1.6;
                            }}
                            .email-header {{
                                background-color: #f7f7f7;
                                padding: 10px;
                                border-bottom: 1px solid #ddd;
                            }}
                            .email-body {{
                                padding: 20px;
                            }}
                            .email-footer {{
                                margin-top: 20px;
                                font-size: 12px;
                                color: #888;
                            }}
                        </style>
                    </head>
                    <body>
                        <div class='email-container'>
                            <div class='email-header'>
                                <h2>Khách sạn đã được duyệt!</h2>
                            </div>
                            <div class='email-body'>
                                <p>Xin chào,</p>
                                <p>Khách sạn <strong>{khachSan.TenKhachSan}</strong> tại địa chỉ <strong>{khachSan.DiaChi}</strong> đã được duyệt lên trang web của chúng tôi.</p>
                                <p>Bạn có thể kiểm tra và quản lý thông tin khách sạn của mình từ bảng điều khiển.</p>
                                <p>Trân trọng,</p>
                                <p>Đội ngũ KhachSanVIP</p>
                            </div>
                            <div class='email-footer'>
                                <p>Nếu bạn có bất kỳ câu hỏi nào, xin vui lòng liên hệ với chúng tôi qua email: support@khachsanvip.com</p>
                            </div>
                        </div>
                    </body>
                    </html>";

                        var fromAddress = new MailAddress("vudinhduy3012003@gmail.com", "KhachSanVIP");
                        var toAddress = new MailAddress(email);

                        var mailMessage = new MailMessage(fromAddress, toAddress)
                        {
                            Subject = "Thông báo duyệt khách sạn",
                            Body = emailContent,
                            IsBodyHtml = true // Đặt true để sử dụng HTML trong nội dung email
                        };
                        smtpClient.Send(mailMessage);
                    }
                }

                return Json("Cập nhật thành công!");
            }
            return Json("Không tìm thấy khách sạn!");
        }

        [Route("timkiemks")]
        public IActionResult TimKiemKhachSan(string searchTerm, int? page)
        {
            int pageSize = 8;
            int pageNumber = page == null || page < 0 ? 1 : page.Value;

            var khachsanQuery = from ks in db.KhachSans
                                join tt in db.TinhThanhs on ks.MaTinh equals tt.MaTinh
                                select new KhachSanVM
                                {
                                    MaKS = ks.MaKs,
                                    TenKS = ks.TenKhachSan,
                                    Anh = ks.Anh,
                                    TenTinh = tt.TenTinh,
                                    DiaChi = ks.DiaChi,
                                    Duyet = ks.Duyet,
                                    Mota = ks.MoTa
                                };

            if (!string.IsNullOrEmpty(searchTerm))
            {
                khachsanQuery = khachsanQuery.Where(ks => ks.TenKS.Contains(searchTerm) ||
                                                          ks.TenTinh.Contains(searchTerm) ||
                                                          ks.DiaChi.Contains(searchTerm));
            }

            var khachsanList = khachsanQuery.OrderBy(x => x.MaKS);
            PagedList<KhachSanVM> lst = new PagedList<KhachSanVM>(khachsanList, pageNumber, pageSize);

            ViewBag.SearchTerm = searchTerm; 

            return View("KhachSan", lst); 
        }

		[Route("timkiemkschuaduyet")]
		public IActionResult TimKiemKSChuaDuyet(string searchTerm, int? page)
		{
			int pageSize = 8;
			int pageNumber = page == null || page < 0 ? 1 : page.Value;

			var khachsanQuery = from ks in db.KhachSans
								join tt in db.TinhThanhs on ks.MaTinh equals tt.MaTinh
                                where ks.Duyet == 0
								select new KhachSanVM
								{
									MaKS = ks.MaKs,
									TenKS = ks.TenKhachSan,
									Anh = ks.Anh,
									TenTinh = tt.TenTinh,
									DiaChi = ks.DiaChi,
									Duyet = ks.Duyet,
									Mota = ks.MoTa
								};

			if (!string.IsNullOrEmpty(searchTerm))
			{
				khachsanQuery = khachsanQuery.Where(ks => ks.TenKS.Contains(searchTerm) ||
														  ks.TenTinh.Contains(searchTerm) ||
														  ks.DiaChi.Contains(searchTerm));
			}

			var khachsanList = khachsanQuery.OrderBy(x => x.MaKS);
			PagedList<KhachSanVM> lst = new PagedList<KhachSanVM>(khachsanList, pageNumber, pageSize);

			ViewBag.SearchTerm = searchTerm;

			return View("DanhSachDuyet", lst);
		}

        [Route("xoaks")]
        [HttpGet]
        public IActionResult XoaKS(int id)
        {
            var loaiphong = db.LoaiPhongs.Where(x=>x.MaKs == id).ToList();
			if (loaiphong.Count() > 0)
			{
                TempData["Message"] = "Không thể xóa khách sạn này vì nó có loại phòng liên quan.";
                return RedirectToAction("KhachSan", "KhachSanAdmin");
			}
            var khachSan = db.KhachSans.Find(id);
            if (khachSan == null)
            {
                TempData["Message"] = "Khách sạn không tồn tại";
                return RedirectToAction("KhachSan", "KhachSanAdmin");
            }
            db.KhachSans.Remove(khachSan);
            db.SaveChanges();
            TempData["Message"] = "Khách sạn đã được xóa";
            return RedirectToAction("KhachSan", "KhachSanAdmin");
        }

        //[Route("doanhthu")]
        //      public IActionResult DoanhThu(int? nam)
        //      {
        //          var result = (from hd in db.HoaDons
        //                        join dp in db.DatPhongs on hd.SoHoaDon equals dp.SoHoaDon
        //                        join p in db.Phongs on dp.MaPhong equals p.MaPhong
        //                        join lp in db.LoaiPhongs on p.MaLp equals lp.MaLp
        //                        where hd.NgayThanhToan.Value.Year == nam
        //                        group new { hd, dp, p, lp } by new { hd.NgayThanhToan.Value.Month, hd.NgayThanhToan.Value.Year } into g
        //                        select new DoanhThuVM
        //                        {
        //                            Nam = g.Key.Year,
        //                            Thang = g.Key.Month,
        //                            TongTien = g.Sum(x => (decimal)(x.lp.Gia * (x.dp.NgayDi.Value.Day - x.dp.NgayDen.Value.Day + 1)) * 40 / 100)
        //                        }).ToList();
        //          ViewBag.nam = nam;
        //          return View(result);
        //      }
        #endregion
    }
}
