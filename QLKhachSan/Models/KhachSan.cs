using System;
using System.Collections.Generic;

namespace QLKhachSan.Models
{
    public partial class KhachSan
    {
        public KhachSan()
        {
            Gopies = new HashSet<GopY>();
            LoaiPhongs = new HashSet<LoaiPhong>();
        }

        public int MaKs { get; set; }
        public int? MaTinh { get; set; }
        public int? IdnguoiTao { get; set; }
        public string? TenKhachSan { get; set; }
        public string? DiaChi { get; set; }
        public string? MoTa { get; set; }
        public string? Anh { get; set; }
        public int? DanhGia { get; set; }
        public int? Duyet { get; set; }

        public virtual KhachHang? IdnguoiTaoNavigation { get; set; }
        public virtual TinhThanh? MaTinhNavigation { get; set; }
        public virtual ICollection<GopY> Gopies { get; set; }
        public virtual ICollection<LoaiPhong> LoaiPhongs { get; set; }
    }
}
