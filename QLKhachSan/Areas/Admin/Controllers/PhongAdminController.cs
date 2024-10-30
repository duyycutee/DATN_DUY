using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using QLKhachSan.Models;
using QLKhachSan.ViewModels.Admin;
using X.PagedList;

namespace QLKhachSan.Areas.Admin.Controllers
{
	[Area("admin")]
    [Authorize(Roles = "Admin")]
    public class PhongAdminController : Controller
    {
        QLKhachSanTTTNContext db = new QLKhachSanTTTNContext();
        [Route("phong")]
		#region Phòng
		public IActionResult Phong(int maks, string searchTerm, int? page)
		{
			int pageSize = 8;
			int pageNumber = page ?? 1;
			var phongQuery = from p in db.Phongs
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
							 };

			if (!string.IsNullOrEmpty(searchTerm))
			{
				phongQuery = phongQuery.Where(p => p.TenPhong.Contains(searchTerm)
												 || p.TenLP.Contains(searchTerm)
												 || p.TenKS.Contains(searchTerm));
			}

			var phongList = phongQuery.OrderBy(x => x.MaPhong).ToPagedList(pageNumber, pageSize);

			var datPhongs = db.DatPhongs.ToList();
			var datPhongDictionary = new Dictionary<int, List<DateTime>>();

			foreach (var datPhong in datPhongs)
			{
				var ngayDen = datPhong.NgayDen.Value.AddDays(-1);
				var soNgayTrongKhoang = (int)(datPhong.NgayDi - datPhong.NgayDen).Value.TotalDays + 1;
				var result = new List<DateTime>();

				for (var i = 0; i < soNgayTrongKhoang; i++)
				{
					result.Add(ngayDen.AddDays(i + 1));
				}

				if (!datPhongDictionary.ContainsKey(datPhong.MaPhong))
				{
					datPhongDictionary.Add(datPhong.MaPhong, result);
				}
				else
				{
					datPhongDictionary[datPhong.MaPhong].AddRange(result);
				}
			}

			var khachsan = (from ks in db.KhachSans
							join kh in db.KhachHangs on ks.IdnguoiTao equals kh.MaKh
							select new { ks.MaKs, ks.TenKhachSan }).ToList();

			ViewBag.ks = khachsan;
			ViewBag.MaKS = maks;
			ViewBag.SearchTerm = searchTerm;
			ViewBag.DatPhongDictionary = datPhongDictionary;

			return View(phongList);
		}

		[Route("themphong")]
        [HttpGet]
        public IActionResult ThemPhong(int? maks)
        {
            var lastMaPhong = db.Phongs.OrderByDescending(p => p.MaPhong).FirstOrDefault()?.MaPhong ?? 0;
            var nextMaPhong = lastMaPhong + 1;
            ViewBag.NextMaPhong = nextMaPhong;
            var khachsan = from ks in db.KhachSans
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
        [Route("themphong")]
        [HttpPost]
        public IActionResult ThemPhong(PhongVM model, IFormFile Anh, List<IFormFile> AnhDetail)
        {
            if (ModelState.IsValid)
            {
                bool isPhongAdded = false;
                int newPhongId = 0;
                // Lấy tên tệp
                var fileName = Path.GetFileName(Anh.FileName);
                // Lưu tệp vào thư mục trên máy chủ
                var filePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "img", "Images","phong", fileName);

                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    Anh.CopyTo(stream);
                }
                foreach (var file in AnhDetail)
                {
                    if (file != null && file.Length > 0)
                    {
                        var fileName1 = Path.GetFileName(file.FileName);
                        var filePath1 = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "img", "Images","phong", fileName1);

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
                return RedirectToAction("Phong");
            }
            return View(model);
        }
        [HttpGet]
        [Route("getKS")]
        public IActionResult GetLoaiPhongByKhachSan(int maks)
        {
            var loaiPhongs = db.LoaiPhongs.Where(lp => lp.MaKs == maks).ToList();
            return Json(loaiPhongs);
        }
        [Route("suaphong")]
        [HttpGet]
        public IActionResult SuaPhong(int id)
        {
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
        [Route("suaphong")]
        [HttpPost]
        public IActionResult SuaPhong(PhongVM model, IFormFile Anh, List<IFormFile> AnhDetail)
        {
            var phongToUpdate = db.Phongs.FirstOrDefault(p => p.MaPhong == model.MaPhong);
            bool isUpdateAnh = false;
            if (phongToUpdate != null)
            {
                if (Anh != null && Anh.Length > 0)
                {
                    var filename = Path.GetFileName(Anh.FileName);
                    var filePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "img", "Images","phong", filename);
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
                        var filePath1 = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "img", "Images","phong", fileName1);

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
            else
            {
                TempData["ErrorMessage"] = "Không tìm thấy phòng để cập nhật.";
                return RedirectToAction("SuaPhong");
            }
        }
        [Route("xoaphong")]
        [HttpGet]
        public IActionResult XoaPhong(int id)
        {
            var datphong = (from dp in db.DatPhongs
                            where dp.NgayDi > DateTime.Now
                            select dp).Count();
            if(datphong > 0)
            {
				TempData["Message"] = "Phòng không thể xóa";
				return RedirectToAction("Phong");
			}
            var phong = db.Phongs.Find(id);
            if (phong == null)
            {
                TempData["Message"] = "Phòng không tồn tại";
                return RedirectToAction("Phong", "PhongAdmin");
            }
            db.Phongs.Remove(phong);
            db.SaveChanges();
            TempData["Message"] = "Đã xóa phòng thành công";
            return RedirectToAction("Phong");
        }
		[Route("timkiemphong")]
		public IActionResult TimKiemPhong(string searchTerm, int? page)
		{
			int pageSize = 8;
			int pageNumber = page ?? 1;
            ViewBag.SearchTerm = searchTerm;
            var phongQuery = from p in db.Phongs
							 join lp in db.LoaiPhongs on p.MaLp equals lp.MaLp
							 join ks in db.KhachSans on lp.MaKs equals ks.MaKs
							 select new PhongVM
							 {
								 MaPhong = p.MaPhong,
								 TenPhong = p.TenPhong,
								 Anh = p.Anh,
								 MoTa = p.MoTa,
								 TenLP = lp.TenLp,
								 TenKS = ks.TenKhachSan
							 };

			if (!string.IsNullOrEmpty(searchTerm))
			{
				phongQuery = phongQuery.Where(p => p.TenPhong.Contains(searchTerm)
												 || p.TenLP.Contains(searchTerm)
												 || p.TenKS.Contains(searchTerm));
			}

			var phongList = phongQuery.OrderBy(x => x.MaPhong).ToPagedList(pageNumber, pageSize);

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

			ViewBag.DatPhongDictionary = datPhongDictionary;
            var khachsan = (from ks in db.KhachSans
                            join kh in db.KhachHangs on ks.IdnguoiTao equals kh.MaKh
                            select new { ks.MaKs, ks.TenKhachSan }).ToList();

            ViewBag.ks = khachsan;
            return View(phongList);
		}
        #endregion

    }
}
