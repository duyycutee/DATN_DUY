using System;
using System.Collections.Generic;

namespace QLKhachSan.Models
{
    public partial class GopY
    {
        public int Id { get; set; }
        public int? MaKh { get; set; }
        public int? MaKs { get; set; }
        public DateTime? NgayComment { get; set; }
        public string? Comment { get; set; }
        public double? DiemNhanVien { get; set; }
        public double? DiemDoAn { get; set; }
        public double? DiemSachSe { get; set; }
        public double? DiemThoaiMai { get; set; }
        public double? DiemDichVu { get; set; }

        public virtual KhachHang? MaKhNavigation { get; set; }
        public virtual KhachSan? MaKsNavigation { get; set; }
    }
}
