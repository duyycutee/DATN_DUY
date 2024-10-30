namespace QLKhachSan.ViewModels
{
    public class BookingVM
    {
        public bool GiongKhachHang { get; set; }
        public string? HoTen { get; set; }
        public string? Email { get; set; }
        public string? Confirmemail { get; set; }
        public string? DienThoai { get; set; }
        public List<int> maphong {  get; set; }
        public string? tenphong {  get; set; }
        public DateTime ngayden { get; set; }
        public DateTime ngaydi {  get; set; }
        public double thanhtien {  get; set; }
        public int? songuoitoida {  get; set; }
    }
}
