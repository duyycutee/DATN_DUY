using System.ComponentModel.DataAnnotations;
namespace QLKhachSan.ViewModels.Admin
{
	public class PhongVM
	{
		public int MaPhong {  get; set; }
        [Required(ErrorMessage = "Vui lòng chọn khách sạn.")]
        public int? MaKS { get; set; }

        public string? TenKS { get; set; }
        [Required(ErrorMessage = "Vui lòng chọn tên loại phòng.")]
        public int? MaLP { get; set; }
        public string? TenLP { get; set; }
        [Required(ErrorMessage = "Vui lòng nhập tên phòng.")]
        public string? TenPhong { get; set; }
        public string? Anh { get; set; }
        public string? AnhDetail { get; set; }
        [Required(ErrorMessage = "Vui lòng nhập mô tả.")]
        public string? MoTa { get; set; }
	}
}
