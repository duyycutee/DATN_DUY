using System;
using System.Collections.Generic;

namespace QLKhachSan.Models
{
    public partial class Blog
    {
        public int Id { get; set; }
        public int? Idadmin { get; set; }
        public string? Anh { get; set; }
        public string? TieuDe { get; set; }
        public string? ThongTin { get; set; }
        public DateTime? NgayDang { get; set; }

        public virtual Admin? IdadminNavigation { get; set; }
    }
}
