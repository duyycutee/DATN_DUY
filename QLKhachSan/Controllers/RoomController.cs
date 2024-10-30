using Microsoft.AspNetCore.Mvc;
using QLKhachSan.Models;
using QLKhachSan.ViewModels;
using QLKhachSan.Helpers;
using Microsoft.AspNetCore.Authorization;
using System.Net.Mail;
using System.Net;
using QLKhachSan.Services;
using Newtonsoft.Json;
using System.Globalization;
using Microsoft.AspNetCore.SignalR;
using QLKhachSan.SignalRChat;
using System;
using X.PagedList;

namespace QLKhachSan.Controllers
{
    public class RoomController : Controller
    {
        private readonly ILogger<RoomController> _logger;
        private readonly QLKhachSanTTTNContext db;
        private readonly IVnPayService _vnPayService;
        private readonly IHubContext<ChatHub> _hubContext;
        public RoomController(ILogger<RoomController> logger, QLKhachSanTTTNContext context, IVnPayService vnPayService, IHubContext<ChatHub> hubContext)
        {
            _logger = logger;
            db = context;
            _vnPayService = vnPayService;
            _hubContext = hubContext;
        }
        public List<BookingVM> Cart => HttpContext.Session.Get<List<BookingVM>>("Cart") ?? new List<BookingVM>();
        #region Đặt phòng
        public IActionResult AddRoomToBooking(BookingVM model)
        {
            var selectedRoomsJson = HttpContext.Session.GetString("SelectedRooms");
            var selectedRooms = new List<BookingVM>();

            // Kiểm tra nếu có danh sách phòng đã chọn trong session
            if (!string.IsNullOrEmpty(selectedRoomsJson))
            {
                selectedRooms = JsonConvert.DeserializeObject<List<BookingVM>>(selectedRoomsJson);
            }
            if(model.ngayden == null || model.ngaydi == null || model.songuoitoida == null)
            {
                return Json(new { success = false, message = "Hãy chọn thông tin đặt phòng" });
            }
            // Thêm phòng mới vào danh sách (dùng List<int> cho mã phòng)
            selectedRooms.Add(new BookingVM
            {
                maphong = new List<int> { model.maphong.First() }, // Thêm một mã phòng
                tenphong= model.tenphong,
                ngayden = model.ngayden,
                ngaydi = model.ngaydi,
                songuoitoida = model.songuoitoida
            });

            // Cập nhật lại session
            HttpContext.Session.SetString("SelectedRooms", JsonConvert.SerializeObject(selectedRooms));

            return Json(new { success = true, message = "Phòng đã được thêm vào danh sách đặt phòng!" });
        }

        //[Authorize]
        public IActionResult Booking()
        {
            var email = HttpContext.Session.GetString("email");
            if (email != null)
            {
                var khachhang = (from kh in db.KhachHangs
                                 where kh.Email == email
                                 select kh).FirstOrDefault();
                ViewBag.email = khachhang.Email;
                ViewBag.diachi = khachhang.DiaChi;
                ViewBag.sdt = khachhang.Sdt;
            }

            // Lấy danh sách phòng từ session
            var selectedRoomsJson = HttpContext.Session.GetString("SelectedRooms");
            if (string.IsNullOrEmpty(selectedRoomsJson))
            {
                ModelState.AddModelError("", "Chưa có phòng nào được chọn.");
                return View();
            }

            var selectedRooms = JsonConvert.DeserializeObject<List<BookingVM>>(selectedRoomsJson);
            double totalAmount = 0;

            foreach (var room in selectedRooms)
            {
                foreach (var maphong in room.maphong)
                {
                    var gia = (from lp in db.LoaiPhongs
                               join p in db.Phongs on lp.MaLp equals p.MaLp
                               where p.MaPhong == maphong
                               select lp.Gia).FirstOrDefault();

                    // Kiểm tra giá phòng
                    if (gia == null)
                    {
                        ModelState.AddModelError("", $"Không tìm thấy giá phòng cho mã phòng {maphong}.");
                        return View(selectedRooms);
                    }

                    // Tính số ngày ở
                    if (room.ngaydi != null && room.ngayden != null)
                    {
                        TimeSpan soNgay = room.ngaydi - room.ngayden;
                        int soNgayTrongKhoang = soNgay.Days + 1;

                        if (soNgayTrongKhoang <= 0)
                        {
                            ModelState.AddModelError("", "Ngày đi phải lớn hơn ngày đến.");
                            return View(selectedRooms);
                        }
                        room.thanhtien = (double)gia * soNgayTrongKhoang;
                        totalAmount += room.thanhtien; // Cộng dồn vào tổng tiền
                    }
                    else
                    {
                        ModelState.AddModelError("", "Ngày đến hoặc ngày đi không hợp lệ.");
                        return View(selectedRooms);
                    }
                }
            }

            // Gán tổng tiền và thông tin phòng đã chọn vào model
            ViewBag.TotalAmount = totalAmount;
            ViewBag.SelectedRooms = selectedRooms;

            

            return View(selectedRooms);
        }
        #endregion

        #region Lưu phòng được đặt vào db
        public void SaveBookingInfoToDatabase(int customerID, BookingVM model, int roomID, string payment)
        {
            var khachhang = db.KhachHangs.SingleOrDefault(kh => kh.MaKh == customerID);
            var khachhang1 = db.KhachHangs.SingleOrDefault(kh => kh.Email == model.Email);

            if (khachhang != null)
            {
                var hoadon = new HoaDon
                {
                    MaKh = customerID,
                    NgayThanhToan = DateTime.Now,
                    TenKh = model.GiongKhachHang ? khachhang.TenKh : model.HoTen,
                    Email = model.GiongKhachHang ? khachhang.Email : model.Email,
                    Sdt = model.GiongKhachHang ? khachhang.Sdt : model.DienThoai,
                    TinhTrang = payment == "Thanh toán VNPay" ? "Đã thanh toán" : "Đã đặt cọc"

                };
                db.Add(hoadon);
                db.SaveChanges();
                var datphong = new DatPhong
                {
                    SoHoaDon = hoadon.SoHoaDon,
                    MaPhong = roomID,
                    NgayDen = model.ngayden,
                    NgayDi = model.ngaydi,
                    SoNguoi = model.songuoitoida,
                    IsDelete = 0
                };
                db.Add(datphong);
                db.SaveChanges();
            }
            else
            {
                var hoadon = new HoaDon
                {
                    MaKh = null,
                    NgayThanhToan = DateTime.Now,
                    TenKh = model.GiongKhachHang ? khachhang.TenKh : model.HoTen,
                    Email = model.GiongKhachHang ? khachhang.Email : model.Email,
                    Sdt = model.GiongKhachHang ? khachhang.Sdt : model.DienThoai,
                    TinhTrang = payment == "Thanh toán VNPay" ? "Đã thanh toán" : "Đã đặt cọc"

                };
                db.Add(hoadon);
                db.SaveChanges();
                var datphong = new DatPhong
                {
                    SoHoaDon = hoadon.SoHoaDon,
                    MaPhong = roomID,
                    NgayDen = model.ngayden,
                    NgayDi = model.ngaydi,
                    SoNguoi = model.songuoitoida,
                    IsDelete = 0
                };
                db.Add(datphong);
                db.SaveChanges();
            }
        }
        #endregion

        #region Gửi email thông tin đã đặt phòng cho khách hàng
        private void SendConfirmationEmail(List<BookingVM> bookingModels, string customerEmail, string paymentMethod)
        {
            string subject;
            string paymentInfo;

            var strSanPham = $@"
<table style='border-collapse: collapse; width: 100%;'>
    <thead>
        <tr style='background-color: #f2f2f2;'>
            <th style='border: 1px solid #ddd; padding: 8px;'>Tên khách sạn</th>
            <th style='border: 1px solid #ddd; padding: 8px;'>Tên phòng</th>
            <th style='border: 1px solid #ddd; padding: 8px;'>Ngày đến</th>
            <th style='border: 1px solid #ddd; padding: 8px;'>Ngày đi</th>
            <th style='border: 1px solid #ddd; padding: 8px;'>Số người</th>
            <th style='border: 1px solid #ddd; padding: 8px;'>Địa chỉ</th>";

            if (paymentMethod == "Đặt cọc phòng(40%)")
            {
                strSanPham += "<th style='border: 1px solid #ddd; padding: 8px;'>Tiền cọc</th><th style='border: 1px solid #ddd; padding: 8px;'>Cần thanh toán</th>";
            }
            else
            {
                strSanPham += "<th style='border: 1px solid #ddd; padding: 8px;'>Tổng tiền</th>";
            }
            strSanPham += @"
        </tr>
    </thead>
    <tbody>";

            foreach (var bookingModel in bookingModels)
            {
                foreach (var maphong in bookingModel.maphong)
                {
                    var tenks = (from ks in db.KhachSans
                                 join lp in db.LoaiPhongs on ks.MaKs equals lp.MaKs
                                 join p in db.Phongs on lp.MaLp equals p.MaLp
                                 where p.MaPhong == maphong
                                 select ks.TenKhachSan).FirstOrDefault();
                    var diachi = (from ks in db.KhachSans
                                  join lp in db.LoaiPhongs on ks.MaKs equals lp.MaKs
                                  join p in db.Phongs on lp.MaLp equals p.MaLp
                                  where p.MaPhong == maphong
                                  select ks.DiaChi).FirstOrDefault();

                    strSanPham += $@"
        <tr>
            <td style='border: 1px solid #ddd; padding: 8px;'>{tenks}</td>
            <td style='border: 1px solid #ddd; padding: 8px;'>{bookingModel.tenphong}</td>
            <td style='border: 1px solid #ddd; padding: 8px;'>{bookingModel.ngayden}</td>
            <td style='border: 1px solid #ddd; padding: 8px;'>{bookingModel.ngaydi}</td>
            <td style='border: 1px solid #ddd; padding: 8px;'>{bookingModel.songuoitoida}</td>
            <td style='border: 1px solid #ddd; padding: 8px;'>{diachi}</td>";

                    if (paymentMethod == "Đặt cọc phòng(40%)")
                    {
                        var deposit = (bookingModel.thanhtien * 40 / 100);
                        var remainingPayment = (bookingModel.thanhtien * 60 / 100);
                        strSanPham += $@"
            <td style='border: 1px solid #ddd; padding: 8px;'>{deposit}</td>
            <td style='border: 1px solid #ddd; padding: 8px;'>{remainingPayment}</td>";
                    }
                    else
                    {
                        strSanPham += $@"
            <td style='border: 1px solid #ddd; padding: 8px;'>{bookingModel.thanhtien}</td>";
                    }
                    strSanPham += "</tr>";
                }
            }

            strSanPham += @"
    </tbody>
</table>";

            var strThongTinKhachHang = $@"
<p>Họ tên khách hàng: <strong>{bookingModels.First().HoTen}</strong></p>
<p>Email: <strong>{bookingModels.First().Email}</strong></p>
<p>Số điện thoại: <strong>{bookingModels.First().DienThoai}</strong></p>";

            var fullContent = $@"
<div style='font-family: Arial, sans-serif;'>
    <h2 style='color: #333;'>Thông tin đặt phòng</h2>
    {strSanPham}
    <h2 style='color: #333;'>Thông tin khách hàng</h2>
    {strThongTinKhachHang}
</div>";

            // Xác định tiêu đề và thông tin thanh toán dựa trên phương thức thanh toán
            if (paymentMethod == "Đặt cọc phòng(40%)")
            {
                subject = "Xác nhận đặt cọc phòng thành công";
                paymentInfo = "Bạn đã đặt cọc phòng thành công.";
            }
            else
            {
                subject = "Phòng bạn được đặt thành công";
                paymentInfo = "Cảm ơn bạn đã đặt phòng.";
            }

            // Gửi email
            var smtpClient = new SmtpClient("smtp.gmail.com")
            {
                Port = 587,
                Credentials = new NetworkCredential("vudinhduy3012003@gmail.com", ""),
                EnableSsl = true,
            };
            var fromAddress = new MailAddress("vudinhduy3012003@gmail.com", "Hotel");
            var toAddress = new MailAddress(customerEmail ?? bookingModels.First().Email);
            var mailMessage = new MailMessage(fromAddress, toAddress)
            {
                Subject = subject,
                Body = $"{fullContent}<p style='font-family: Arial, sans-serif;'>{paymentInfo}</p>",
                IsBodyHtml = true
            };

            smtpClient.Send(mailMessage);
        }


        #endregion

        #region Xác nhận đã đăth phòng thành công
        [HttpPost]
        public IActionResult ConfirmBooking(List<int> maphong, BookingVM model, double totalAmount, string payment = "COD")
        {
            if (ModelState.IsValid)
            {
                var email = model.Email ;
                var hoten = model.HoTen ;
                var sdt = model.DienThoai;
                // Lấy CustomerID từ email
                var customerID = (from kh in db.KhachHangs
                                  where kh.Email == email
                                  select kh.MaKh).FirstOrDefault();

                // Cài đặt thông tin vào session
                HttpContext.Session.SetString("CustomerID", customerID.ToString());
                HttpContext.Session.SetString("PaymentMethod", payment);
                HttpContext.Session.SetString("BookingModel", JsonConvert.SerializeObject(model));
                HttpContext.Session.SetString("Email", email.ToString());
                HttpContext.Session.SetString("HoTen", hoten.ToString());
                HttpContext.Session.SetString("SDT", sdt.ToString());
                // Lấy thông tin khách hàng
                KhachHang khachhang;
                if (model.GiongKhachHang)
                {
                    khachhang = db.KhachHangs.SingleOrDefault(p => p.MaKh == customerID);
                    model.HoTen = khachhang.TenKh;
                    model.DienThoai = khachhang.Sdt;
                    model.Email = khachhang.Email;
                }

                // Xử lý thanh toán
                if (payment == "Thanh toán VNPay")
                {
                    var vnPayModel = new VnPaymentRequestModel
                    {
                        Amount = totalAmount,
                        CreateDate = DateTime.Now,
                        Desscription = $"{model.HoTen} {model.DienThoai}",
                        FullName = model.HoTen,
                        OrderId = new Random().Next(1000, 10000) // Chuyển đổi sang string nếu cần
                    };
                    return Redirect(_vnPayService.CreatePaymentUrl(HttpContext, vnPayModel));
                }
                else if (payment == "Đặt cọc phòng(40%)")
                {
                    var vnPayDepositModel = new VnPaymentRequestModel
                    {
                        Amount = totalAmount * 40 / 100,
                        CreateDate = DateTime.Now,
                        Desscription = $"{model.HoTen} {model.DienThoai} - Đặt cọc",
                        FullName = model.HoTen,
                        OrderId = new Random().Next(1000, 10000) // Chuyển đổi sang string nếu cần
                    };
                    return Redirect(_vnPayService.CreatePaymentUrl(HttpContext, vnPayDepositModel));
                }
                

                // Lưu thông tin đặt phòng vào cơ sở dữ liệu cho tất cả các phòng đã chọn
                foreach (var roomId in maphong)
                {
                    SaveBookingInfoToDatabase(customerID, model, roomId, payment);
                }

                // Chuyển hướng đến trang xác nhận
                return View(model); // Thay thế với tên action cụ thể của bạn
            }

            return View(model);
        }


        [Authorize]
        public IActionResult PaymentFail()
        {
            return View();
        }
        public IActionResult Success()
        {
            return View();
        }
        //[Authorize]
        public IActionResult PaymentCallBack()
        {
            var response = _vnPayService.PaymentExecute(Request.Query);
            if (response == null || response.VnPayResponseCode != "00")
            {
                TempData["Message"] = $"Lỗi thanh toán VNPay: {response?.VnPayResponseCode}";
                return Redirect("/");
            }

            var customerID = int.Parse(HttpContext.Session.GetString("CustomerID"));
            var paymentMethod = HttpContext.Session.GetString("PaymentMethod");
            var email = HttpContext.Session.GetString("Email");
            var hoten = HttpContext.Session.GetString("HoTen");
            var sdt = HttpContext.Session.GetString("SDT");
            // Deserialize danh sách phòng đã chọn từ session
            var selectedRoomsJson = HttpContext.Session.GetString("SelectedRooms");
            var selectedRooms = JsonConvert.DeserializeObject<List<BookingVM>>(selectedRoomsJson);

            // Kiểm tra xem danh sách phòng có hợp lệ không
            if (selectedRooms == null || selectedRooms.Count == 0)
            {
                TempData["Message"] = "Không tìm thấy phòng đã đặt.";
                return Redirect("/");
            }

            bool sentmail = HttpContext.Session.GetBool("SentMail") ?? false;
            if (!sentmail)
            {
                // Ghi thông tin đặt phòng vào cơ sở dữ liệu
                foreach (var room in selectedRooms)
                {
                    var gia = (from lp in db.LoaiPhongs
                               join p in db.Phongs on lp.MaLp equals p.MaLp
                               where p.MaPhong == room.maphong.First()
                               select lp.Gia).FirstOrDefault();
                    TimeSpan soNgay = room.ngaydi - room.ngayden;
                    int soNgayTrongKhoang = soNgay.Days + 1;

                    if (soNgayTrongKhoang <= 0)
                    {
                        ModelState.AddModelError("", "Ngày đi phải lớn hơn ngày đến.");
                        return View(selectedRooms);
                    }
                    room.thanhtien = (double)gia * soNgayTrongKhoang;
                    room.Email = email;
                    room.HoTen = hoten;
                    room.DienThoai = sdt;
                    SaveBookingInfoToDatabase(customerID, room, room.maphong.First(), paymentMethod);
                }

                // Gửi email xác nhận cho tất cả các phòng
                SendConfirmationEmail(selectedRooms, email, paymentMethod);
                HttpContext.Session.SetBool("SentMail", true);
            }
            // Truyền danh sách phòng vào View
            HttpContext.Session.Remove("SelectedRooms");
            return View("ConfirmBooking", selectedRooms);
        }
        #endregion
    }
}
