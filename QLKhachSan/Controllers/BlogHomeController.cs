using Microsoft.AspNetCore.Mvc;
using QLKhachSan.Models;
using QLKhachSan.ViewModels;

namespace QLKhachSan.Controllers
{
    public class BlogHomeController : Controller
    {
        private readonly ILogger<BlogHomeController> _logger;
        private readonly QLKhachSanTTTNContext db;
        public BlogHomeController(ILogger<BlogHomeController> logger, QLKhachSanTTTNContext context)
        {
            _logger = logger;
            db = context;
        }
        public IActionResult Index()
        {
            var result = (from b in db.Blogs
                          select new BlogVM{
                             IDBlog = b.Id,
                             IdAdmin = b.Idadmin,
                             Anh = b.Anh,
                             TieuDe = b.TieuDe,
                             ThongTin = b.ThongTin,
                             NgayDang = b.NgayDang
                          }).ToList();
            return View(result);
        }
        public IActionResult BlogDetail(int id)
        {
            return View();
        }
    }
}
