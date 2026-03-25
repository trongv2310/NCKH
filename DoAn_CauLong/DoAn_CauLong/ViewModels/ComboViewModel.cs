using System.Collections.Generic;
using DoAn_CauLong.Models;

namespace DoAn_CauLong.ViewModels
{
    public class ComboViewModel
    {
        public string Itemset { get; set; } // Chuỗi ID các sản phẩm trong Combo (VD: "1,5")
        public List<SanPham> SanPhams { get; set; }
        public decimal TongGiaGoc { get; set; }
        public decimal GiaKhuyenMai { get; set; }
    }
}