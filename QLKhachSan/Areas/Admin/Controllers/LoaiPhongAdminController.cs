using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using QLKhachSan.Models;
using QLKhachSan.ViewModels;
using QLKhachSan.ViewModels.Admin;
using X.PagedList;

namespace QLKhachSan.Areas.Admin.Controllers
{
    [Area("admin")]
    [Authorize(Roles = "Admin")]
    public class LoaiPhongAdminController : Controller
    {
        QLKhachSanTTTNContext db = new QLKhachSanTTTNContext();
        #region Loại phòng
        [Route("loaiphong")]
        [HttpGet]
        public IActionResult LoaiPhong(int maks, int? page)
        {
            int pageSize = 8;
            int pageNumber = page == null || page < 0 ? 1 : page.Value;
            var loaipphong = (from lp in db.LoaiPhongs
                              join ks in db.KhachSans on lp.MaKs equals ks.MaKs
                              where ks.MaKs == maks
                              select new LoaiPhongVM
                              {
                                  malp = lp.MaLp,
                                  tenks = ks.TenKhachSan,
                                  tenlp = lp.TenLp,
                                  anh = lp.Anh,
                                  songuoitoida = lp.SoNguoiToiDa,
                                  gia = lp.Gia,
                                  thongtin = lp.ThongTin,
                                  kichthuoc = lp.KichThuoc
                              }).OrderBy(x => x.malp);
            PagedList<LoaiPhongVM> lst = new PagedList<LoaiPhongVM>(loaipphong, pageNumber, pageSize);
            var khachsan = (from ks in db.KhachSans
                            join kh in db.KhachHangs on ks.IdnguoiTao equals kh.MaKh
                            select new { ks.MaKs, ks.TenKhachSan }).ToList();
            ViewBag.ks = khachsan;
            ViewBag.maks = maks;
            return View(lst);
        }

        [Route("themlp")]
        [HttpGet]
        public IActionResult ThemLP()
        {
            var lastMaLP = db.LoaiPhongs.OrderByDescending(p => p.MaLp).FirstOrDefault()?.MaLp ?? 0;
            var nextMaLP = lastMaLP + 1;
            ViewBag.nextMaLP = nextMaLP;
            ViewBag.MaKs = new SelectList(db.KhachSans.ToList(), "MaKs", "TenKhachSan");
            var thietbi = (from tb in db.ThietBis
                           select tb.TenTb).ToList();
            ViewBag.thietbi = thietbi;
            return View();
        }
        [Route("themlp")]
        [HttpPost]
        public IActionResult ThemLP(LoaiPhongVM model, IFormFile Anh, string[] thietbi)
        {
            if (ModelState.IsValid)
            {
                var fileName = Path.GetFileName(Anh.FileName);
                // Lưu tệp vào thư mục trên máy chủ
                var filePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "img", "Images", "phong", fileName);

                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    Anh.CopyTo(stream);
                }
                var loaiphong = new LoaiPhong
                {
                    MaKs = model.maks,
                    TenLp = model.tenlp,
                    Anh = fileName,
                    Gia = model.gia,
                    ThongTin = model.thongtin,
                    SoNguoiToiDa = model.songuoitoida,
                    KichThuoc = model.kichthuoc
                };
                db.Add(loaiphong);
                db.SaveChanges();
                if (thietbi != null && thietbi.Length > 0)
                {
                    var malp = (from lp in db.LoaiPhongs
                                where lp.TenLp == model.tenlp
                                select lp.MaLp).FirstOrDefault();
                    foreach (var thietBi in thietbi)
                    {
                        var matb = (from tb in db.ThietBis
                                    where tb.TenTb == thietBi
                                    select tb.MaTb).FirstOrDefault();
                        var suDungThietBi = new SuDungThietBi
                        {
                            MaTb = matb,
                            MaLp = malp
                        };
                        db.Add(suDungThietBi);
                    }
                    db.SaveChanges();
                }
                TempData["Message"] = "Thêm mới loại phòng thành công!";
                return RedirectToAction("LoaiPhong");
            }
            return View(model);
        }

        [Route("sualp")]
        [HttpGet]
        public IActionResult SuaLP(int id)
        {
            var loaiphong = (from lp in db.LoaiPhongs
                             join ks in db.KhachSans on lp.MaKs equals ks.MaKs
                             join sdtb in db.SuDungThietBis on lp.MaLp equals sdtb.MaLp
                             join tb in db.ThietBis on sdtb.MaTb equals tb.MaTb
                             where lp.MaLp == id
                             select new LoaiPhongVM()
                             {
                                 malp = lp.MaLp,
                                 tenlp = lp.TenLp,
                                 tenks = ks.TenKhachSan,
                                 songuoitoida = lp.SoNguoiToiDa,
                                 gia = lp.Gia,
                                 kichthuoc = lp.KichThuoc,
                                 thongtin = lp.ThongTin,
                                 anh = lp.Anh
                             }).FirstOrDefault();
            ViewBag.MaKs = new SelectList(db.KhachSans.ToList(), "TenKhachSan", "TenKhachSan");
            var tenthietbi = (from sdtb in db.SuDungThietBis
                              join tb in db.ThietBis on sdtb.MaTb equals tb.MaTb
                              where sdtb.MaLp == id
                              select tb.TenTb).ToList();
            var thietbi = (from tb in db.ThietBis
                           select tb.TenTb).ToList();
            ViewBag.tenthietbi = tenthietbi;
            ViewBag.thietbi = thietbi;
            return View(loaiphong);
        }

        [Route("sualp")]
        [HttpPost]
        public IActionResult SuaLP(LoaiPhongVM model, IFormFile? Anh, string[] thietbi)
        {
            var lp = db.LoaiPhongs.FirstOrDefault(p => p.MaLp == model.malp);
            if (lp != null)
            {
                if (Anh != null && Anh.Length > 0)
                {
                    var filename = Path.GetFileName(Anh.FileName);
                    var filePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "img", "Images", "phong", filename);
                    using (var stream = new FileStream(filePath, FileMode.Create))
                    {
                        Anh.CopyTo(stream);
                    }
                    lp.Anh = filename;
                }
                lp.TenLp = model.tenlp;
                lp.SoNguoiToiDa = model.songuoitoida;
                lp.Gia = model.gia;
                lp.KichThuoc = model.kichthuoc;
                lp.ThongTin = model.thongtin;

                db.Update(lp);
                db.SaveChanges();
                var oldTBs = db.SuDungThietBis.Where(x => x.MaLp == model.malp).ToList();
                foreach (var tb in oldTBs)
                {
                    db.Remove(tb);
                }
                foreach (var thietBi in thietbi)
                {
                    var matb = (from tb in db.ThietBis
                                where tb.TenTb == thietBi
                                select tb.MaTb).FirstOrDefault();
                    var suDungThietBi = new SuDungThietBi
                    {
                        MaTb = matb,
                        MaLp = model.malp,
                    };
                    db.Add(suDungThietBi);
                }
                db.SaveChanges();
                TempData["Message"] = "Cập nhật loại phòng thành công";
                return RedirectToAction("LoaiPhong");
            }
            return View(model);
        }
        [Route("xoalp")]
        [HttpGet]
        public IActionResult XoaLP(int? id)
        {
            var phong = db.Phongs.Where(x => x.MaLp == id).ToList();
            if (phong.Count() > 0)
            {
                TempData["Message"] = "Không thể xóa loại phòng này";
                return RedirectToAction("LoaiPhong", "LoaiPhongAdmin");
            }
            db.Remove(db.LoaiPhongs.Find(id));
            db.SaveChanges();
            TempData["Message"] = "Loại phòng đã được xóa";
            return Redirect("LoaiPhong");
        }
        [Route("timkiemloaiphong")]
        public IActionResult TimKiemLoaiPhong(string searchTerm, int? page)
        {
            int pageSize = 8;
            int pageNumber = page ?? 1;

            var loaiPhongQuery = from lp in db.LoaiPhongs
                                 join ks in db.KhachSans on lp.MaKs equals ks.MaKs
                                 where lp.MaKs == ks.MaKs
                                 select new LoaiPhongVM
                                 {
                                     malp = lp.MaLp,
                                     tenks = ks.TenKhachSan,
                                     tenlp = lp.TenLp,
                                     anh = lp.Anh,
                                     songuoitoida = lp.SoNguoiToiDa,
                                     gia = lp.Gia,
                                     thongtin = lp.ThongTin,
                                     kichthuoc = lp.KichThuoc
                                 };

            if (!string.IsNullOrEmpty(searchTerm))
            {
                loaiPhongQuery = loaiPhongQuery.Where(lp => lp.tenlp.Contains(searchTerm)
                                                           || lp.tenks.Contains(searchTerm));
				ViewBag.SearchTerm = searchTerm;
			}

            var loaiPhongList = loaiPhongQuery.OrderBy(x => x.malp).ToPagedList(pageNumber, pageSize);
			var khachsan = (from ks in db.KhachSans
							join kh in db.KhachHangs on ks.IdnguoiTao equals kh.MaKh
							select new { ks.MaKs, ks.TenKhachSan }).ToList();
			ViewBag.ks = khachsan;
			return View(loaiPhongList);
        }
        #endregion
    }
}
