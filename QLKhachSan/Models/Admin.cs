using System;
using System.Collections.Generic;

namespace QLKhachSan.Models
{
    public partial class Admin
    {
        public Admin()
        {
            Blogs = new HashSet<Blog>();
        }

        public int Id { get; set; }
        public string? Email { get; set; }
        public string? Password { get; set; }

        public virtual ICollection<Blog> Blogs { get; set; }
    }
}
