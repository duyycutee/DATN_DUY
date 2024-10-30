using System;
using System.Collections.Generic;

namespace QLKhachSan.Models
{
    public partial class ThietBi
    {
        public ThietBi()
        {
            SuDungThietBis = new HashSet<SuDungThietBi>();
        }

        public int MaTb { get; set; }
        public string? TenTb { get; set; }

        public virtual ICollection<SuDungThietBi> SuDungThietBis { get; set; }
    }
}
