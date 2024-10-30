using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication.Google;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using QLKhachSan.Models;
using System.Security.Claims;

namespace QLKhachSan.Controllers
{
    public class LoginGoogleController : Controller
    {
        private readonly QLKhachSanTTTNContext db;

        public LoginGoogleController(QLKhachSanTTTNContext context)
        {
            db = context;
        }
        public async Task Login()
        {
            await HttpContext.ChallengeAsync(GoogleDefaults.AuthenticationScheme,
                new AuthenticationProperties
                {
                    RedirectUri = Url.Action("GoogleResponse")
                });
        }
        public async Task<IActionResult> GoogleResponse()
        {
            var result = await HttpContext.AuthenticateAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            var email = result.Principal.FindFirst(ClaimTypes.Email)?.Value;

            if (string.IsNullOrEmpty(email))
            {
                return Redirect("/");
            }

            HttpContext.Session.SetString("email", email);
            var khachhang = await db.KhachHangs.FirstOrDefaultAsync(u => u.Email == email);

            if (khachhang == null)
            {
                khachhang = new KhachHang
                {
                    Email = email,
                    UserId = 0,
                    HieuLuc = 0
                };
                db.KhachHangs.Add(khachhang);
                await db.SaveChangesAsync();
            }

            await SignInUser(khachhang, result);
            return Redirect("/");
        }

        private async Task SignInUser(KhachHang khachhang, AuthenticateResult result)
        {
            var claims = new List<Claim>
            {
                new Claim(ClaimTypes.Email, khachhang.Email),
                new Claim("CustomerID", khachhang.MaKh.ToString()),
                new Claim("UserId", khachhang.UserId.ToString())
            };

            if (!string.IsNullOrEmpty(khachhang.TenKh))
            {
                claims.Add(new Claim(ClaimTypes.Name, khachhang.TenKh));
            }

            HttpContext.Session.SetString("UserType", khachhang.UserId == 1 ? "DoanhNghiep" : "KhachHang");

            var identity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
            var principal = new ClaimsPrincipal(identity);
            var authProperties = new AuthenticationProperties
            {
                IsPersistent = true
            };
            HttpContext.Session.SetString("idKH", khachhang.UserId.ToString());
            await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, principal, authProperties);
        }
    }
}

