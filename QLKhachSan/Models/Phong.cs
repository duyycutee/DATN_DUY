using System;
using System.Collections.Generic;

namespace QLKhachSan.Models
{
    public partial class Phong
    {
        public Phong()
        {
            Ctanhs = new HashSet<Ctanh>();
            DatPhongs = new HashSet<DatPhong>();
        }

        public int MaPhong { get; set; }
        public string? TenPhong { get; set; }
        public int? MaLp { get; set; }
        public string? Anh { get; set; }
        public string? MoTa { get; set; }

        public virtual LoaiPhong? MaLpNavigation { get; set; }
        public virtual ICollection<Ctanh> Ctanhs { get; set; }
        public virtual ICollection<DatPhong> DatPhongs { get; set; }
    }
}
