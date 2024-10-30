using System;
using System.Collections.Generic;

namespace QLKhachSan.Models
{
    public partial class QuenMatKhau
    {
        public int Id { get; set; }
        public string? Token { get; set; }
        public string? Email { get; set; }
        public DateTime? NgayTao { get; set; }
    }
}
