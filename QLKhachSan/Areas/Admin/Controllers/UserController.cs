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
    public class UserController : Controller
	{
		QLKhachSanTTTNContext db = new QLKhachSanTTTNContext();
		#region Khách hàng
		[Route("khachhang")]
		[HttpGet]
        public IActionResult KhachHang(int? page)
		{
			int pageSize = 8;
			int pageNumber = page == null || page < 0 ? 1 : page.Value;
			var khachhang = (from kh in db.KhachHangs
							select new UserVM
							{
								MaKh = kh.MaKh,
								TenKh = kh.TenKh,
								GioiTinh = kh.GioiTinh,
								DiaChi = kh.DiaChi,
								Email = kh.Email,
								NgaySinh = kh.NgaySinh,
								Sdt = kh.Sdt,
								HieuLuc = kh.HieuLuc,
								UserId = kh.UserId
								
							}).OrderBy(x => x.MaKh);
			PagedList<UserVM> lst = new PagedList<UserVM>(khachhang, pageNumber, pageSize);
			return View(lst);
		}
		[Route("SuaTTKH")]
		[HttpGet]
		public IActionResult SuaKH(int id)
		{
			var khachhang = (from kh in db.KhachHangs
							 where kh.MaKh == id
							 select new UserVM
							 {
								 MaKh = kh.MaKh,
								 TenKh = kh.TenKh,
								 GioiTinh = kh.GioiTinh,
								 DiaChi = kh.DiaChi,
								 Email = kh.Email,
								 NgaySinh = kh.NgaySinh,
								 Sdt = kh.Sdt,
								 HieuLuc = kh.HieuLuc
							 }).FirstOrDefault();
            return View(khachhang);
		}
		[Route("SuaTTKH")]
		[HttpPost]
		public IActionResult SuaKH(UserVM model)
		{
            var kh = db.KhachHangs.FirstOrDefault(p => p.MaKh == model.MaKh);
            if (kh != null)
            {
				kh.TenKh = model.TenKh;
				kh.NgaySinh = model.NgaySinh;
				kh.DiaChi = model.DiaChi;
				kh.Email = model.Email;
				kh.GioiTinh = model.GioiTinh;
				kh.Sdt = model.Sdt;
				kh.HieuLuc = model.HieuLuc;
                db.Update(kh);

                db.SaveChanges();
				TempData["Message"] = "Cập nhật khách hàng thành công!";
                return RedirectToAction("khachhang");
            }
            return View(model);
        }
		[Route("timkiemkhachhang")]
		public IActionResult TimKiemKhachHang(string searchTerm, int? page)
		{
			int pageSize = 8;
			int pageNumber = page ?? 1;

			var khachHangQuery = from kh in db.KhachHangs
								 select new UserVM
								 {
									 MaKh = kh.MaKh,
									 TenKh = kh.TenKh,
									 GioiTinh = kh.GioiTinh,
									 DiaChi = kh.DiaChi,
									 Email = kh.Email,
									 NgaySinh = kh.NgaySinh,
									 Sdt = kh.Sdt,
									 HieuLuc = kh.HieuLuc
								 };

			if (!string.IsNullOrEmpty(searchTerm))
			{
				khachHangQuery = khachHangQuery.Where(kh => kh.TenKh.Contains(searchTerm)
														  || kh.Email.Contains(searchTerm)
														  || kh.Sdt.Contains(searchTerm));
			}

			var khachHangList = khachHangQuery.OrderBy(x => x.MaKh).ToPagedList(pageNumber, pageSize);

			return View("KhachHang", khachHangList);
		}
		#endregion
	}
}
