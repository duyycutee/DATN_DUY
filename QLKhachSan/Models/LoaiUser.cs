using System;
using System.Collections.Generic;

namespace QLKhachSan.Models
{
    public partial class LoaiUser
    {
        public LoaiUser()
        {
            Users = new HashSet<User>();
        }

        public int IdLoaiUser { get; set; }
        public string? TenLoai { get; set; }

        public virtual ICollection<User> Users { get; set; }
    }
}
