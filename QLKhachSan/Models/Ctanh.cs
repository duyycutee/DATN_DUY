using System;
using System.Collections.Generic;

namespace QLKhachSan.Models
{
    public partial class Ctanh
    {
        public string TenAnh { get; set; } = null!;
        public int? MaPhong { get; set; }

        public virtual Phong? MaPhongNavigation { get; set; }
    }
}
