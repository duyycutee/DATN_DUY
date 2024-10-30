using System;
using System.Collections.Generic;

namespace QLKhachSan.Models
{
    public partial class NhanVien
    {
        public NhanVien()
        {
            Blogs = new HashSet<Blog>();
            HoaDons = new HashSet<HoaDon>();
        }

        public int MaNv { get; set; }
        public string? Email { get; set; }
        public string? Password { get; set; }
        public int? Type { get; set; }

        public virtual ICollection<Blog> Blogs { get; set; }
        public virtual ICollection<HoaDon> HoaDons { get; set; }
    }
}
