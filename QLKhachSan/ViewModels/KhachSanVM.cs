using System.ComponentModel.DataAnnotations;
namespace QLKhachSan.ViewModels
{
    public class KhachSanVM
    {
        public int MaKS {  get; set; }
        public int? MaTinh {  get; set; }
        public string? TenTinh {  set; get; }
        public string? TenHuyen { get; set; }
        public string? TenXa { get; set; }
        public string? TenKS {  get; set; }
        public string? Anh {  get; set; }
        public string? DiaChi {  get; set; }
        public string? Mota {  get; set; }
        public int? Duyet {  get; set; }
        public int? DanhGia { get; set; }
    }
}
