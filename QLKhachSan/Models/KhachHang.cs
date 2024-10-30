using System;
using System.Collections.Generic;

namespace QLKhachSan.Models
{
    public partial class KhachHang
    {
        public KhachHang()
        {
            Gopies = new HashSet<GopY>();
            HoaDons = new HashSet<HoaDon>();
            KhachSans = new HashSet<KhachSan>();
        }

        public int MaKh { get; set; }
        public string? TenKh { get; set; }
        public int? GioiTinh { get; set; }
        public string? Email { get; set; }
        public string? Password { get; set; }
        public DateTime? NgaySinh { get; set; }
        public string? DiaChi { get; set; }
        public string? Sdt { get; set; }
        public int? UserId { get; set; }
        public int? HieuLuc { get; set; }

        public virtual ICollection<GopY> Gopies { get; set; }
        public virtual ICollection<HoaDon> HoaDons { get; set; }
        public virtual ICollection<KhachSan> KhachSans { get; set; }
    }
}
