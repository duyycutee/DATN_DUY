using System;
using System.Collections.Generic;

namespace QLKhachSan.Models
{
    public partial class SuDungDichVu
    {
        public string MaDv { get; set; } = null!;
        public int SoHoaDon { get; set; }
        public int? SoLuong { get; set; }
        public DateTime? NgayMua { get; set; }

        public virtual DichVu MaDvNavigation { get; set; } = null!;
        public virtual HoaDon SoHoaDonNavigation { get; set; } = null!;
    }
}
