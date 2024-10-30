using System;
using System.Collections.Generic;

namespace QLKhachSan.Models
{
    public partial class TinhThanh
    {
        public TinhThanh()
        {
            KhachSans = new HashSet<KhachSan>();
        }

        public int MaTinh { get; set; }
        public string? TenTinh { get; set; }
        public string? Anh { get; set; }

        public virtual ICollection<KhachSan> KhachSans { get; set; }
    }
}
