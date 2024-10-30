using System;
using System.Collections.Generic;

namespace QLKhachSan.Models
{
    public partial class User
    {
        public User()
        {
            KhachHangs = new HashSet<KhachHang>();
            NhanViens = new HashSet<NhanVien>();
        }

        public int UserId { get; set; }
        public int? IdLoaiUser { get; set; }

        public virtual LoaiUser? IdLoaiUserNavigation { get; set; }
        public virtual ICollection<KhachHang> KhachHangs { get; set; }
        public virtual ICollection<NhanVien> NhanViens { get; set; }
    }
}
