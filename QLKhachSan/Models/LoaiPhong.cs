using System;
using System.Collections.Generic;

namespace QLKhachSan.Models
{
    public partial class LoaiPhong
    {
        public LoaiPhong()
        {
            Phongs = new HashSet<Phong>();
            SuDungThietBis = new HashSet<SuDungThietBi>();
        }

        public int MaLp { get; set; }
        public int? MaKs { get; set; }
        public string? TenLp { get; set; }
        public int? SoNguoiToiDa { get; set; }
        public double? Gia { get; set; }
        public string? Anh { get; set; }
        public string? ThongTin { get; set; }
        public string? KichThuoc { get; set; }

        public virtual KhachSan? MaKsNavigation { get; set; }
        public virtual ICollection<Phong> Phongs { get; set; }
        public virtual ICollection<SuDungThietBi> SuDungThietBis { get; set; }
    }
}
