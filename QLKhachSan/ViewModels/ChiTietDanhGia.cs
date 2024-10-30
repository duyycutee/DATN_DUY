using X.PagedList;

namespace QLKhachSan.ViewModels
{
    public class ChiTietDanhGia
    {
        public IPagedList<ChiTietPhongVM> ChiTietPhong { get; set; }
        public IPagedList<DanhGiaKS> DanhGia { get; set; }
        public IEnumerable<DiemTrungBinhGopYVM> DiemTrungBinh { get; set; }
    }
}
