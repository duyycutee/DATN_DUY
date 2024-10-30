using System.ComponentModel.DataAnnotations;

namespace QLKhachSan.ViewModels.Admin
{
    public class UserVM
    {
        public int MaKh {  get; set; }
        public string? TenKh {  get; set; }
        public int? GioiTinh {  get; set; }
        public string? Email {  get; set; }
		public DateTime? NgaySinh {  get; set; }
        public string? DiaChi {  get; set; }
        public string? Sdt {  get; set; }
        public int? HieuLuc { get; set; }
        public int? UserId { get; set; }
    }
}
