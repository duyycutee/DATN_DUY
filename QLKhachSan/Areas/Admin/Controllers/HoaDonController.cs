using Microsoft.AspNetCore.Mvc;
using QLKhachSan.Models;

namespace QLKhachSan.Areas.Admin.Controllers
{
    [Area("admin")]
    public class HoaDonController : Controller
    {
        QLKhachSanTTTNContext db = new QLKhachSanTTTNContext();
        [Route("hoadon")]
        public IActionResult HoaDon()
        {
            return View();
        }
    }
}
