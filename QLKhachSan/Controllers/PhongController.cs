using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using QLKhachSan.Models;
using QLKhachSan.SignalRChat;
using QLKhachSan.ViewModels;

namespace QLKhachSan.Controllers
{
    public class PhongController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly QLKhachSanTTTNContext db;
        private readonly IHubContext<ChatHub> _hubContext;
        public PhongController(ILogger<HomeController> logger, QLKhachSanTTTNContext context, IHubContext<ChatHub> hubContext)
        {
            _logger = logger;
            db = context;
            _hubContext = hubContext;
        }
        #region Chi tiết phòng
        public IActionResult ChiTietPhong(int id)
        {
            var result = (from Phong in db.Phongs
                          join dp in db.DatPhongs on Phong.MaPhong equals dp.MaPhong into phongDatPhong
                          from dp in phongDatPhong.DefaultIfEmpty()
                          join LoaiPhong in db.LoaiPhongs on Phong.MaLp equals LoaiPhong.MaLp
                          join ks in db.KhachSans on LoaiPhong.MaKs equals ks.MaKs
                          where Phong.MaPhong == id
                          select new ChiTietPhongVM
                          {
                              MaPhong = Phong.MaPhong,
                              TenPhong = Phong.TenPhong,
                              AnhPhong = Phong.Anh,
                              MoTaPhong = Phong.MoTa,
                              DiaChi = ks.DiaChi,
                              SoNguoiToiDa = LoaiPhong.SoNguoiToiDa,
                              ngayden = dp.NgayDen,
                              ngaydi = dp.NgayDi
                          }).FirstOrDefault();
            if (result?.TenPhong != null)
            {
                HttpContext.Session.SetString("tenphong", result.TenPhong);
            }
            else
            {
                HttpContext.Session.SetString("tenphong", "Tên phòng không xác định");
            }
            var anhphong = db.Ctanhs.Where(x => x.MaPhong == id).ToList();
            ViewBag.anhphong = anhphong;
            var songuoitoida = db.LoaiPhongs
                               .Where(lp => db.Phongs.Any(p => p.MaPhong == id && p.MaLp == lp.MaLp))
                               .Select(lp => lp.SoNguoiToiDa)
                               .Max();
            ViewBag.songuoitoida = songuoitoida;
            var malp = (from p in db.Phongs
                        where p.MaPhong == id
                        select p.MaLp).FirstOrDefault();
            var thietbi = (from lp in db.LoaiPhongs
                           join sdtb in db.SuDungThietBis on lp.MaLp equals sdtb.MaLp
                           join tb in db.ThietBis on sdtb.MaTb equals tb.MaTb
                           where lp.MaLp == malp
                           select tb.TenTb).ToList();
            ViewBag.thietbi = thietbi;
			var datPhongs = db.DatPhongs.Where(dp => dp.MaPhong == id && dp.IsDelete == 0).ToList();
			var ngayDatPhong = new List<DateTime>();

            // Duyệt qua từng đặt phòng để lấy danh sách các ngày đã đặt
            foreach (var datPhong in datPhongs)
            {
                // Kiểm tra xem NgayDen và NgayDi có giá trị hay không
                if (datPhong.NgayDen.HasValue && datPhong.NgayDi.HasValue)
                {
                    var ngayDen = datPhong.NgayDen.Value;
                    var soNgayTrongKhoang = (int)(datPhong.NgayDi.Value - datPhong.NgayDen.Value).TotalDays + 1;

                    for (var i = 0; i < soNgayTrongKhoang; i++)
                    {
                        // Thêm các ngày vào danh sách
                        ngayDatPhong.Add(ngayDen.AddDays(i));
                    }
                }
            }
            // Truyền danh sách các ngày đã đặt vào ViewBag
            ViewBag.NgayDaDat = ngayDatPhong;
			_hubContext.Clients.All.SendAsync("ReceiveReview", ngayDatPhong);
            return View(result);
        }
        #endregion

        #region Check phòng trống
        [HttpPost]
        public IActionResult CheckPhongTrong(PhongTrongVM model)
        {
            var result = (from p in db.Phongs
                          join lp in db.LoaiPhongs on p.MaLp equals lp.MaLp
                          join ks in db.KhachSans on lp.MaKs equals ks.MaKs
                          join t in db.TinhThanhs on ks.MaTinh equals t.MaTinh
                          where !(from dp in db.DatPhongs
                                  where
                                         (model.ngayden >= dp.NgayDen && model.ngayden <= dp.NgayDi) ||
                                         (model.ngaydi >= dp.NgayDen && model.ngaydi <= dp.NgayDi) ||
                                         (dp.NgayDen >= model.ngayden && dp.NgayDen <= model.ngaydi) ||
                                         (dp.NgayDi >= model.ngayden && dp.NgayDi <= model.ngaydi)
                                  select dp.MaPhong).Contains(p.MaPhong) && (model.songuoitoida == null || model.songuoitoida <= lp.SoNguoiToiDa) &&
                                          (model.TenLoaiPhong == null || model.TenLoaiPhong == lp.TenLp) && (model.tentinh == null || model.tentinh == t.TenTinh)
                          select new KhachSanVM
                          {
                              MaTinh = ks.MaTinh,
                              MaKS = ks.MaKs,
                              TenKS = ks.TenKhachSan,
                              Anh = ks.Anh,
                              DiaChi = ks.DiaChi,
                              DanhGia = ks.DanhGia,
                              Mota = ks.MoTa
                          }).Distinct();
            var matinh = (from t in db.TinhThanhs
                          where t.TenTinh == model.tentinh
                          select t.MaTinh).FirstOrDefault();
            ViewBag.matinh = matinh;
            var songuoitoida = db.LoaiPhongs
            .Select(lp => lp.SoNguoiToiDa)
            .Max();
            ViewBag.songuoitoida = songuoitoida;
            return View(result);
        }
        #endregion

        #region Lọc phòng
        [HttpPost]
        public IActionResult UpdateSelection(int maks, List<string> selectedRooms, List<string> selectedPrices, List<string> selectedThietBi)
        {
            // Nếu không có loại phòng hoặc giá nào được chọn, lấy tất cả phòng
            if ((selectedRooms == null || selectedRooms.Count == 0) && (selectedPrices == null || selectedPrices.Count == 0) && (selectedThietBi == null || selectedThietBi.Count == 0))
            {
                var allRooms = from p in db.Phongs
                               join lp in db.LoaiPhongs on p.MaLp equals lp.MaLp
                               where lp.MaKs == maks
                               select new ChiTietPhongVM
                               {
                                   MaPhong = p.MaPhong,
                                   TenPhong = p.TenPhong,
                                   AnhPhong = p.Anh,
                                   Gia = lp.Gia,
                                   SoNguoiToiDa = lp.SoNguoiToiDa,
                               };

                return PartialView("_PartialPhong", allRooms);
            }

            var filteredResult = new List<ChiTietPhongVM>();

            if (selectedPrices == null || selectedPrices.Count == 0)
            {
                var sql = from p in db.Phongs
                          join lp in db.LoaiPhongs on p.MaLp equals lp.MaLp
                          join sdtb in db.SuDungThietBis on lp.MaLp equals sdtb.MaLp
                          join tb in db.ThietBis on sdtb.MaTb equals tb.MaTb
                          where lp.MaKs == maks && (selectedRooms == null || selectedRooms.Count == 0 || selectedRooms.Contains(lp.TenLp))
                             && (selectedThietBi == null || selectedThietBi.Count == 0 || selectedThietBi.Contains(tb.TenTb))
                          select new ChiTietPhongVM
                          {
                              MaPhong = p.MaPhong,
                              TenPhong = p.TenPhong,
                              AnhPhong = p.Anh,
                              Gia = lp.Gia,
                              SoNguoiToiDa = lp.SoNguoiToiDa,
                          };
                filteredResult.AddRange(sql.Distinct());
            }
            else
            {
                var priceRanges = selectedPrices
                .Select(range => range.Split('-'))
                .Select(parts => (MinPrice: double.Parse(parts[0]), MaxPrice: double.Parse(parts[1])))
                .ToList();

                foreach (var range in priceRanges)
                {
                    double minPrice = range.MinPrice;
                    double maxPrice = range.MaxPrice;

                    var result = from p in db.Phongs
                                 join lp in db.LoaiPhongs on p.MaLp equals lp.MaLp
                                 join sdtb in db.SuDungThietBis on lp.MaLp equals sdtb.MaLp
                                 join tb in db.ThietBis on sdtb.MaTb equals tb.MaTb
                                 where lp.MaKs == maks && (selectedRooms == null || selectedRooms.Count == 0 || selectedRooms.Contains(lp.TenLp)) &&
                                       (lp.Gia >= minPrice && lp.Gia <= maxPrice) && (selectedThietBi == null || selectedThietBi.Count == 0 || selectedThietBi.Contains(tb.TenTb))
                                 select new ChiTietPhongVM
                                 {
                                     MaPhong = p.MaPhong,
                                     TenPhong = p.TenPhong,
                                     AnhPhong = p.Anh,
                                     Gia = lp.Gia,
                                     SoNguoiToiDa = lp.SoNguoiToiDa,
                                 };

                    filteredResult.AddRange(result.Distinct());
                }
            }

            return PartialView("_PartialPhong", filteredResult);
        }

        #endregion

        //Chuc nang dat nhieu phong 
        [HttpPost]
        public IActionResult AddRoom(BookingVM bookingModel)
        {
            // Lấy thông tin phòng từ session nếu có
            var selectedRoomsJson = HttpContext.Session.GetString("SelectedRooms");
            var selectedRooms = string.IsNullOrEmpty(selectedRoomsJson)
                ? new List<BookingVM>()
                : JsonConvert.DeserializeObject<List<BookingVM>>(selectedRoomsJson);

            // Thêm phòng mới vào danh sách
            selectedRooms.Add(bookingModel);

            // Lưu lại danh sách phòng vào session
            HttpContext.Session.SetString("SelectedRooms", JsonConvert.SerializeObject(selectedRooms));

            // Chuyển hướng đến trang danh sách phòng để chọn thêm
            return RedirectToAction("RoomSelection");
        }

    }
}
