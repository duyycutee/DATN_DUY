using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using QLKhachSan.Models;
using QLKhachSan.ViewModels;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http.Extensions;
using MessagePack;
using QLKhachSan.Helpers;
using System.Net.Mail;
using System.Net;
using QLKhachSan.ViewModels.Admin;
using NuGet.Common;
using System.Net.Http;
using Microsoft.EntityFrameworkCore;
using X.PagedList;

namespace QLKhachSan.Controllers
{
    public class KhachHangController : Controller
    {
        private readonly QLKhachSanTTTNContext db;

        public KhachHangController(QLKhachSanTTTNContext context)
        {
            db = context;
        }
		#region Đăng ký
		public IActionResult DangKy()
        {
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> SendOtp(string email)
        {
            if (!IsValidEmail(email))
            {
                return Json(new { success = false, message = "Địa chỉ email không hợp lệ" });
            }

            var otp = GenerateOtp();
            HttpContext.Session.SetString("maOTP", otp.ToString());
            HttpContext.Session.SetString("OtpEmail", email);
            HttpContext.Session.SetString("OtpCreationTime", DateTime.Now.ToString());
            var otp1 = HttpContext.Session.GetString("maOTP");
            var otpCreationTimeString = HttpContext.Session.GetString("OtpCreationTime");
            var fromAddress = new MailAddress("vudinhduy3012003@gmail.com", "Hotel");
            var toAddress = new MailAddress(email);
            var smtpClient = new SmtpClient("smtp.gmail.com")
            {
                Port = 587,
                Credentials = new NetworkCredential("vudinhduy3012003@gmail.com", "yhifkumtzgqnbblm"),
                EnableSsl = true,
            };
            var mailMessage = new MailMessage(fromAddress, toAddress)
            {
                Subject = "Mã OTP của bạn",
                Body = $"Mã OTP của bạn là {otp}",
                IsBodyHtml = true
            };
            smtpClient.Send(mailMessage);
            return Json(new { success = true, message = "Mã OTP đã được gửi đến email của bạn" });
        }
        [HttpPost]
        public IActionResult DangKy(DangKyVM model)
        {
            if (ModelState.IsValid)
            {
                var otp = HttpContext.Session.GetString("maOTP");
                var otpEmail = HttpContext.Session.GetString("OtpEmail");
                var otpCreationTimeString = HttpContext.Session.GetString("OtpCreationTime");
                var otpCreationTime = otpCreationTimeString != null ? DateTime.Parse(otpCreationTimeString) : (DateTime?)null;

                var email = db.KhachHangs.FirstOrDefault(x => x.Email == model.Email);
                if (otpEmail != model.Email)
                {
                    TempData["Message"] = "Email không khớp với email đã nhận OTP";
                    return View(model);
                }
                if (email != null)
                {
                    TempData["Message"] = "Email đã tồn tại";
                    return View(model);
                }
                if (model.Password != model.ConfirmPassword)
                {
                    TempData["Message"] = "Mật khẩu không trùng nhau";
                    return View(model);
                }
                if (otp == null || otpCreationTime == null || DateTime.Now > otpCreationTime.Value.AddMinutes(5))
                {
                    TempData["Message"] = "OTP không tồn tại hoặc đã hết hạn";
                    return View(model);
                }
                if (otp != model.OTP)
                {
                    TempData["Message"] = "Mã OTP không chính xác";
                    return View(model);
                }

                int userId = model.LoaiTaiKhoan == "doanhnghiep" ? 1 : 0;

                KhachHang kh = new KhachHang
                {
                    TenKh = model.TenKh,
                    GioiTinh = model.GioiTinh,
                    Email = model.Email,
                    Password = MD5Hash(model.Password),
                    NgaySinh = model.NgaySinh,
                    DiaChi = model.DiaChi,
                    Sdt = model.Sdt,
                    UserId = userId,
                    HieuLuc = 0
                };
                db.Add(kh);
                db.SaveChanges();

                TempData["Message"] = "Đăng ký thành công";
                return RedirectToAction("Index", "Home");
            }
            return View(model);
        }

        private string GenerateOtp()
        {
            Random rand = new Random();
            return rand.Next(100000, 999999).ToString();
        }


        private bool IsValidEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email; // Kiểm tra xem địa chỉ có khớp với cú pháp không
            }
            catch
            {
                return false; // Nếu có lỗi, địa chỉ email không hợp lệ
            }
        }
		#endregion

		#region Đăng nhập
		public IActionResult DangNhap(string? ReturnUrl)
        {
            ViewBag.ReturnUrl = ReturnUrl;
            return View();
        }
        [HttpPost]
		public async Task<IActionResult> DangNhap(DangNhapVM model, string? ReturnUrl)
		{
			if (ModelState.IsValid)
			{
				var kh = db.KhachHangs.FirstOrDefault(x => x.Email == model.email);
				var nv = db.Admins.FirstOrDefault(x => x.Email == model.email);

                if (nv != null)
				{
					if (nv.Password == MD5Hash(model.password))
					{
						// Đăng nhập thành công cho admin
						var claims = new List<Claim>
				{
					new Claim(ClaimTypes.Email, nv.Email),
					new Claim(ClaimTypes.Role, "Admin")
				};
						var claimsIdentity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
						var authProperties = new AuthenticationProperties
						{
							// Lưu session nếu cần thiết
							IsPersistent = true
						};
						await HttpContext.SignInAsync(
							CookieAuthenticationDefaults.AuthenticationScheme,
							new ClaimsPrincipal(claimsIdentity),
							authProperties);
                        HttpContext.Session.SetString("email", model.email);
                        return RedirectToAction("Index", "HomeAdmin", new { area = "admin" });
					}
					else
					{
						// Sai mật khẩu cho admin
						TempData["Message"] = "Mật khẩu không chính xác";
						return View();
					}
				}

				if (kh == null)
				{
					TempData["Message"] = "Tài khoản không tồn tại";
					return View();
				}

				if (kh.HieuLuc == 1)
				{
					TempData["Message"] = "Tài khoản đã bị khóa";
					return View();
				}

				// Xác thực cho khách hàng
				if (kh.Password == MD5Hash(model.password))
				{
                    var IdKH = (from kh1 in db.KhachHangs
                                where kh1.Email == model.email
                                select kh1.UserId).FirstOrDefault();
                    var IdKHString = IdKH.ToString();
                    HttpContext.Session.SetString("idKH", IdKHString);
                    var claims = new List<Claim>
			        {
				        new Claim(ClaimTypes.Email, kh.Email),
				        new Claim(ClaimTypes.Name, kh.TenKh),
				        new Claim("CustomerID", kh.MaKh.ToString()),
                        new Claim("UserId", kh.UserId.ToString())
			        };
					if (kh.UserId == 1)
					{
						claims.Add(new Claim(ClaimTypes.Role, "DoanhNghiep"));
                        HttpContext.Session.SetString("UserType", "DoanhNghiep");
                    }
                    else
                    {
                        claims.Add(new Claim(ClaimTypes.Role, "KhachHang"));
                        HttpContext.Session.SetString("UserType", "KhachHang");
                    }
                    var claimsIdentity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
					var authProperties = new AuthenticationProperties
					{
						// Lưu session nếu cần thiết
						IsPersistent = false
					};
					await HttpContext.SignInAsync(
						CookieAuthenticationDefaults.AuthenticationScheme,
						new ClaimsPrincipal(claimsIdentity),
						authProperties);
                    if (ReturnUrl == "/admin")
                    {
                        return RedirectToAction("Index", "Home");
                    }
     //               if (Url.IsLocalUrl(ReturnUrl))
					//{
					//	return Redirect(ReturnUrl);
					//}
					else
					{
                        HttpContext.Session.SetString("email", model.email);
                        TempData["Message"] = "Đăng nhập thành công";
                        return RedirectToAction("Index", "Home");
					}
				}
				else
				{
					TempData["Message"] = "Mật khẩu không chính xác";
					return View();
				}
			}

			return View();
		}
		#endregion

		#region Đăng xuất
		public async Task<IActionResult> DangXuat()
        {
            HttpContext.Session.Remove("email");
            await HttpContext.SignOutAsync();
            return RedirectToAction("Index", "Home");
        }
		#endregion

		#region Quên mật khẩu
		[HttpGet]
		public IActionResult QuenMatKhau()
		{
			return View();
		}
		[HttpPost]
        public async Task<IActionResult> QuenMatKhau(LayMatKhauVM model, string email)
        {
            int token = int.Parse(DateTimeOffset.Now.ToString("ffffff"));
            if (!IsValidEmail(email))
            {
                TempData["Message"] = "Email không tồn tại";
                return View("QuenMatKhau");
            }
            var khachhang = db.KhachHangs.SingleOrDefault(p => p.Email == email);

            if (khachhang != null)
            {
                HttpContext.Session.SetString("Email", model.Email);
                var smtpClient = new SmtpClient("smtp.gmail.com")
                {
                    Port = 587,
                    Credentials = new NetworkCredential("vudinhduy3012003@gmail.com", "yhifkumtzgqnbblm"),
                    EnableSsl = true,

                };
                var resetLink = Url.Action("LayMatKhau", "KhachHang", new { token,email }, Request.Scheme);

                // Tạo nội dung email với đường dẫn đặt lại mật khẩu
                var emailContent = $"Nhấp vào <a href=\"{resetLink}\">đây</a> để đặt lại mật khẩu:";
                var fromAddress = new MailAddress("vudinhduy3012003@gmail.com", "KhachSanVIP");

                // Tạo địa chỉ email người nhận
                var toAddress = new MailAddress(email);

                // Tạo đối tượng MailMessage
                var mailMessage = new MailMessage(fromAddress, toAddress)
                {
                    Subject = "Đặt Lại Mật Khẩu",
                    Body = emailContent,
                    IsBodyHtml = true // Đặt true nếu bạn sử dụng HTML trong nội dung email
                };

                // Gửi email
                QuenMatKhau forget = new QuenMatKhau
                {
                    Token = token.ToString(),
                    Email = email,
                    NgayTao = DateTime.Now
                };
                db.QuenMatKhaus.Add(forget);
                db.SaveChanges();
                smtpClient.Send(mailMessage);
                TempData["Message"] = "Vui lòng check email của bạn";
                return View("QuenMatKhau");
            }
            TempData["Message"] = "Email không tồn tại";
            // Redirect hoặc hiển thị thông báo thành công.
            return View("QuenMatKhau");
        }
        [HttpGet]
		public IActionResult LayMatKhau(string token, string email)
		{
            var quenmk = db.QuenMatKhaus.Where(x => x.Token == token && x.Email == email && x.NgayTao > DateTime.Now.AddMinutes(-10)).FirstOrDefault();
            if (quenmk == null)
            {
                return BadRequest();
            }
            LayMatKhauVM result = new LayMatKhauVM
            {
                Email = email
            };
            return View(result);
		}
        [HttpPost]
        public IActionResult LayMatKhau(LayMatKhauVM model)
        {
            //email = HttpContext.Session.GetString("Email");


            var khachhang = db.KhachHangs.SingleOrDefault(p => p.Email == model.Email);

            // Kiểm tra xem khách hàng có tồn tại và email trùng khớp hay không
            if (khachhang != null && string.Equals(khachhang.Email, model.Email, StringComparison.OrdinalIgnoreCase))
            {
                // Thực hiện các thao tác khác với đối tượng khachhang
                if (model.MatKhauMoi != model.ConfirmMK)
                {
                    TempData["Message"] = "Mật khẩu không trùng nhau";
                    return View(model);
                }
                else
                {
                    khachhang.Password = MD5Hash(model.MatKhauMoi);
                    db.Update(khachhang);
                    db.SaveChanges();
                    TempData["Message"] = "Lấy lại mật khẩu thành công";
                    return Redirect("/");
                }
            }
            else
            {
                TempData["Message"] = "Email không tồn tại hoặc không trùng khớp";
                return View(model);
            }

            return View(model);
        }
		#endregion

		#region Đổi mật khẩu
		public IActionResult DoiMK()
        {
            return View();
        }
        [HttpPost]
        public IActionResult DoiMK(LayMatKhauVM model)
        {
            if (ModelState.IsValid)
            {
                string email = HttpContext.Session.GetString("email");
                var khachhang = db.KhachHangs.SingleOrDefault(p => p.Email == email);
                if (khachhang.Password != MD5Hash(model.MatKhauCu))
                {
                    TempData["Message"] = "Mật khẩu hiện tại không đúng!";
                    return View(model);
                }
                if (model.MatKhauMoi != model.ConfirmMK)
                {
                    TempData["Message"] = "Mật khẩu không trùng nhau!";
                    return View(model);
                }
                if(model.MatKhauMoi.Length <6 && model.ConfirmMK.Length<6)
                {
                    TempData["Message"] = "Mật khẩu phải lớn hơn 6 ký tự!";
                    return View(model);
                }
                else
                {
                    khachhang.Password = MD5Hash(model.MatKhauMoi);
                    db.Update(khachhang);
                    db.SaveChanges();
                    return Redirect("/");
                }
            }
            return View(model);
        }
		#endregion

		#region Lịch sử đặt phòng
		public IActionResult LichSuDatPhong(int? page)
        {
            int pageSize = 8;
            int pageNumber = page == null || page < 0 ? 1 : page.Value;
            var email = HttpContext.Session.GetString("email");
            var result = (from kh in db.KhachHangs
                          join hd in db.HoaDons on kh.MaKh equals hd.MaKh
                          join dp in db.DatPhongs on hd.SoHoaDon equals dp.SoHoaDon
                          join p in db.Phongs on dp.MaPhong equals p.MaPhong
                          join lp in db.LoaiPhongs on p.MaLp equals lp.MaLp
                          join ks in db.KhachSans on lp.MaKs equals ks.MaKs
                          where kh.Email == email
						  orderby hd.NgayThanhToan descending
						  select new LSDatPhongVM
                          {
                              sohd = hd.SoHoaDon,
                              tenkh = kh.TenKh,
                              ngayden = dp.NgayDen,
                              ngaydi = dp.NgayDi,
                              ngaythanhtoan = hd.NgayThanhToan,
                              tinhtrang = hd.TinhTrang,
                              songuoi = dp.SoNguoi,
                              tenphong = p.TenPhong,
                              tenks = ks.TenKhachSan
                          }).ToList();
            PagedList<LSDatPhongVM> lst = new PagedList<LSDatPhongVM>(result, pageNumber, pageSize);
            return View(lst);
        }
		#endregion

		#region Hủy phòng
		public IActionResult HuyPhong(int? id)
        {
            var hoadon = (from hd in db.HoaDons
                          where hd.SoHoaDon == id
                          select hd).FirstOrDefault();
            hoadon.TinhTrang = "Đã hủy";
            var datphong = (from dp in db.DatPhongs
                            where dp.SoHoaDon == id
                            select dp).FirstOrDefault();
            datphong.IsDelete = 1;
            datphong.NgayHuy = DateTime.Now;
            db.SaveChanges();
            return RedirectToAction("ProFile");
        }
		#endregion

		#region ProFile
		[Authorize]
        public IActionResult ProFile()
        {
            var customerId = HttpContext.User.Claims.SingleOrDefault(p => p.Type == "CustomerID").Value;
            var kh = db.KhachHangs.SingleOrDefault(p => p.MaKh.ToString() == customerId);
            if (kh != null)
            {
                ViewBag.KhachHang = kh;
            }
            return View();
        }
        [HttpPost]
        public IActionResult SaveProfile(KhachHang model)
        {
            if (ModelState.IsValid)
            {
                // Tìm khách hàng trong cơ sở dữ liệu
                var customerId = HttpContext.User.Claims.SingleOrDefault(p => p.Type == "CustomerID")?.Value;
                var existingKhachHang = db.KhachHangs.SingleOrDefault(p => p.MaKh.ToString() == customerId);
                if (existingKhachHang != null)
                {
                    // Cập nhật thông tin từ form chỉnh sửa
                    existingKhachHang.TenKh = model.TenKh;
                    existingKhachHang.DiaChi = model.DiaChi;
                    existingKhachHang.Sdt = model.Sdt;

                    db.SaveChanges(); // Lưu thay đổi vào cơ sở dữ liệu

                    // Chuyển hướng lại trang thông tin cá nhân sau khi lưu thành công
                    return RedirectToAction("ProFile");
                }
            }

            // Nếu không thành công, hiển thị lại trang chỉnh sửa với thông tin đã nhập và thông báo lỗi
            return View("ProFile", model);
        }
        public IActionResult IsAuthenticated()
        {
            bool isAuthenticated = User.Identity.IsAuthenticated;

            return Json(new { isAuthenticated = isAuthenticated });
        }
		#endregion
		private string MD5Hash(string input)
        {
            using (MD5 md5hash = MD5.Create())
            {
                byte[] data = md5hash.ComputeHash(Encoding.UTF8.GetBytes(input));
                StringBuilder sBuilder = new StringBuilder();
                for (int i = 0; i < data.Length; i++)
                {
                    sBuilder.Append(data[i].ToString("x2"));
                }
                return sBuilder.ToString();
            }
        }
    }
}
