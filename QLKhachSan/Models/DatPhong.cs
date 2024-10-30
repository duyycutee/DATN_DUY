using System;
using System.Collections.Generic;

namespace QLKhachSan.Models
{
    public partial class DatPhong
    {
        public int MaPhong { get; set; }
        public int SoHoaDon { get; set; }
        public DateTime? NgayDen { get; set; }
        public DateTime? NgayDi { get; set; }
        public DateTime? NgayHuy { get; set; }
        public int? SoNguoi { get; set; }
        public int? IsDelete { get; set; }

        public virtual Phong MaPhongNavigation { get; set; } = null!;
        public virtual HoaDon SoHoaDonNavigation { get; set; } = null!;
    }
}
