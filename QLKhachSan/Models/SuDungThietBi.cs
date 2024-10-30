using System;
using System.Collections.Generic;

namespace QLKhachSan.Models
{
    public partial class SuDungThietBi
    {
        public int Id { get; set; }
        public int MaTb { get; set; }
        public int MaLp { get; set; }

        public virtual LoaiPhong MaLpNavigation { get; set; } = null!;
        public virtual ThietBi MaTbNavigation { get; set; } = null!;
    }
}
