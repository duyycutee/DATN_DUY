using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using QLKhachSan.Models;
using QLKhachSan.ViewModels;
using QLKhachSan.ViewModels.Admin;
using X.PagedList;

namespace QLKhachSan.Areas.Admin.Controllers
{
    [Area("admin")]
    [Authorize(Roles = "Admin")]
    public class BlogAdminController : Controller
    {
        QLKhachSanTTTNContext db = new QLKhachSanTTTNContext();
		#region Blog
		[Route("Blog")]
        public IActionResult Blog(int? page)
        {
            int pageSize = 8;
            int pageNumber = page == null || page < 0 ? 1 : page.Value;
            var blog = (from b in db.Blogs
                        join nv in db.Admins on b.Idadmin equals nv.Id
                        select new BlogVM
                        {
                            IDBlog = b.Id,
                            Anh = b.Anh,
                            TieuDe = b.TieuDe,
                            ThongTin = b.ThongTin,
                            NgayDang = b.NgayDang
                        });
            PagedList<BlogVM> lst = new PagedList<BlogVM>(blog, pageNumber, pageSize);

            return View(lst);
        }
        [Route("ThemBlog")]
        [HttpGet]
        public IActionResult ThemBlog()
        {
            var lastMaKS = db.Phongs.OrderByDescending(p => p.MaPhong).FirstOrDefault()?.MaPhong ?? 0;
            var nextMaKS = lastMaKS + 1;
            ViewBag.nextMaKS = nextMaKS;
            return View();
        }
        [Route("ThemBlog")]
        [HttpPost]
        public IActionResult ThemBlog(BlogVM model, IFormFile Anh)
        {
            if (ModelState.IsValid)
            {
                var fileName = Path.GetFileName(Anh.FileName);
                var filePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "img", "Images","blog", fileName);

                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    Anh.CopyTo(stream);
                }
                var blog = new Blog
                {
                    Idadmin = 2,
                    TieuDe = model.TieuDe,
                    ThongTin = model.ThongTin,
                    Anh = fileName,
                    NgayDang = DateTime.Now
                };
                db.Add(blog);
                db.SaveChanges();
                TempData["Message"] = "Thêm mới blog thành công!";
                return RedirectToAction("Blog");
            }
            return View(model);
        }
        [HttpGet]
        [Route("SuaBlog")]
        public IActionResult SuaBlog(int id)
        {
            var blog = (from bl in db.Blogs
                        where bl.Id == id
                        select new BlogVM
                        {
                            IDBlog = bl.Id,
                            TieuDe = bl.TieuDe,
                            ThongTin = bl.ThongTin
                        }).FirstOrDefault();
            return View(blog);
        }
        [HttpPost]
        [Route("SuaBlog")]
        public IActionResult SuaBlog(BlogVM model, IFormFile? Anh)
        {
            if(ModelState.IsValid)
            {
                var blog = db.Blogs.FirstOrDefault(p => p.Id == model.IDBlog);
                if (blog != null)
                {
                    if (Anh != null && Anh.Length > 0)
                    {
                        var filename = Path.GetFileName(Anh.FileName);
                        var filePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "img", "Images", "blog", filename);
                        using (var stream = new FileStream(filePath, FileMode.Create))
                        {
                            Anh.CopyTo(stream);
                        }
                        blog.Anh = filename;
                    }
                    blog.TieuDe = model.TieuDe;
                    blog.ThongTin = model.ThongTin;
                    db.Update(blog);

                    db.SaveChanges();
                    TempData["Message"] = "Cập nhật blog thành công!";
                    return RedirectToAction("Blog");
                }
            }
            return View(model);
        }
        [HttpGet]
        [Route("xoaBlog")]
        public IActionResult XoaBlog(int id)
        {
            var blog = db.Blogs.Find(id);
            if (blog == null)
            {
                TempData["Message"] = "BLog không tồn tại";
                return RedirectToAction("Blog", "BlogAdmin");
            }
            db.Blogs.Remove(blog);
            db.SaveChanges();
            TempData["Message"] = "Đã xóa blog thành công";
            return RedirectToAction("Blog", "BlogAdmin");
        }
		#endregion
	}
}
