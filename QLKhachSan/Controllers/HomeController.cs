using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using QLKhachSan.Models;
using QLKhachSan.SignalRChat;
using QLKhachSan.ViewModels;
using System.Diagnostics;
using System.Linq;
using X.PagedList;

namespace QLKhachSan.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly QLKhachSanTTTNContext db;
        private readonly IHubContext<ChatHub> _hubContext;
        public HomeController(ILogger<HomeController> logger, QLKhachSanTTTNContext context, IHubContext<ChatHub> hubContext)
        {
            _logger = logger;
            db = context;
            _hubContext = hubContext;
        }

        public IActionResult Index(int? page)
        {
            int pageSize = 8;
            int pageNumber = page == null || page < 0 ? 1 : page.Value;
            var listSanPhamVM = from t in db.TinhThanhs
                                select new TinhThanhVM
                                {
                                    MaTinh = t.MaTinh,
                                    TenTinh = t.TenTinh,
                                    Anh = t.Anh,
									SoLuongKhachSans = db.KhachSans.Count(khachSan => khachSan.MaTinh == t.MaTinh && khachSan.Duyet == 1)
								};
            PagedList<TinhThanhVM> pagedListResult = new PagedList<TinhThanhVM>(listSanPhamVM, pageNumber, pageSize);
            var tentinh = (from ks in db.TinhThanhs
                         select ks.TenTinh).ToList();
            ViewBag.tentinh = tentinh;
            return View(pagedListResult);
        }
        public IActionResult VeChungToi()
        {
            return View();
        }
        public IActionResult LienHe()
        {
            return View();
        }
        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}