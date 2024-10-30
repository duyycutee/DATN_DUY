using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using QLKhachSan.Models;
using QLKhachSan.ViewModels;
using X.PagedList;

namespace QLKhachSan.Areas.Admin.Controllers
{
	[Area("admin")]
	[Authorize(Roles = "Admin")]
	public class ThietBiAdminController : Controller
	{
		QLKhachSanTTTNContext db = new QLKhachSanTTTNContext();
		[Route("thietbi")]
		public IActionResult ThietBi(int? page,int maks)
        {
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
							select new { ks.MaKs, ks.TenKhachSan }).ToList();
			ViewBag.pageSize = pageSize;
			ViewBag.MaKS = maks;
			ViewBag.ks = khachsan;
			return View(lst);
		}
    }
}
