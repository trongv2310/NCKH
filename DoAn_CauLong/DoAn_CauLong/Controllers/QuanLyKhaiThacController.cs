using DoAn_CauLong.Filters;
using DoAn_CauLong.Models;
using DoAn_CauLong.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace DoAn_CauLong.Controllers
{
    [CheckAdmin]
    public class QuanLyKhaiThacController : Controller
    {
        // 1. Trả về trang giao diện
        public ActionResult BoSanPhamBanChay()
        {
            return View();
        }

        // 2. Nhận K, chạy thuật toán VertTopKDS và trả về kết quả
        [HttpPost]
        public JsonResult PhantichTopK(int kValue)
        {
            try
            {
                // Khởi tạo service chứa thuật toán
                MiningService miningService = new MiningService();

                // Chạy thuật toán với topK = kValue. 
                // Ở đây mình để windowSize = 3 (3 tháng gần nhất theo logic mặc định của bạn)
                miningService.ChayThuậtToanKhaiPha(windowSize: 3, topK: kValue);

                using (var db = new QLDN_CAULONGEntities())
                {
                    // Lấy ra Top K tập có Utility (lợi nhuận) cao nhất từ Database sau khi thuật toán chạy xong
                    var results = db.GoiYSanPhams
                .OrderByDescending(g => g.Utility)
                .ToList() // Ép lấy toàn bộ lên RAM trước
                .GroupBy(g => g.Itemset) // FIX: Nhóm các tập trùng lặp lại (nếu có do chạy luồng song song)
                .Select(g => g.First())  // Chỉ lấy 1 đại diện duy nhất cho mỗi tập
                .Take(kValue)            // Cuối cùng mới cắt đúng số lượng K
                .ToList();

                    var responseData = new List<object>();

                    foreach (var item in results)
                    {
                        // Dịch mã sản phẩm (ví dụ: "1,5,10") sang Tên sản phẩm
                        List<int> productIds = item.Itemset.Split(',')
                                                           .Select(int.Parse)
                                                           .ToList();

                        var sanPhams = db.SanPhams
                                         .Where(sp => productIds.Contains(sp.MaSanPham))
                                         .Select(sp => sp.TenSanPham)
                                         .ToList();

                        responseData.Add(new
                        {
                            TenTapSanPham = string.Join(" + ", sanPhams), // Hiển thị dạng: Vợt Yonex + Giày Lining
                            LoiNhuan = item.Utility
                        });
                    }

                    return Json(new { success = true, data = responseData });
                }
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = "Lỗi khi chạy thuật toán: " + ex.Message });
            }
        }
    }
}