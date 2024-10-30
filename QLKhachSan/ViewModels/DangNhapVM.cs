using System.ComponentModel.DataAnnotations;

namespace QLKhachSan.ViewModels
{
    public class DangNhapVM
    {
        [Required(ErrorMessage = "Email là trường bắt buộc.")]
        [EmailAddress(ErrorMessage = "Email không hợp lệ.")]
        public string? email { get; set; }

        [Required(ErrorMessage = "Mật khẩu là trường bắt buộc.")]
        [DataType(DataType.Password)]
        public string? password { get; set; }
    }
}
