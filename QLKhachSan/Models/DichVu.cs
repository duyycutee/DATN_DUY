using System;
using System.Collections.Generic;

namespace QLKhachSan.Models
{
    public partial class DichVu
    {
        public DichVu()
        {
            SuDungDichVus = new HashSet<SuDungDichVu>();
        }

        public string MaDv { get; set; } = null!;
        public string? TenDv { get; set; }
        public double? Gia { get; set; }
        public string? Anh { get; set; }
        public string? ThongTin { get; set; }

        public virtual ICollection<SuDungDichVu> SuDungDichVus { get; set; }
    }
}
