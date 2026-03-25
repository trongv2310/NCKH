using DoAn_CauLong.Models;
using System;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web.Mvc;
using DoAn_CauLong.Filters; 

namespace DoAn_CauLong.Controllers
{
    public class GioHangController : Controller
    {
        QLDN_CAULONGEntities data = new QLDN_CAULONGEntities();

        // Action này được gọi bằng AJAX từ _Layout.cshtml
       
        public ActionResult GetCartCount()
        {
            int count = (Session["GioHangCount"] != null) ? (int)Session["GioHangCount"] : 0;
            return Content(count.ToString());
        }

        
        [CheckLogin]
        public ActionResult RemoveFromCart(int chiTietId)
        {
            // 1. Lấy MaKhachHang
            int maTaiKhoan = (int)Session["MaTaiKhoan"];
            var khachHang = data.KhachHangs.FirstOrDefault(kh => kh.MaTaiKhoan == maTaiKhoan);

            if (khachHang != null)
            {
                int maKhachHang = khachHang.MaKhachHang;
                var cartItem = data.GioHangs.FirstOrDefault(g =>
                    g.MaKhachHang == maKhachHang && g.MaChiTietSanPham == chiTietId);

                if (cartItem != null)
                {
                    data.GioHangs.Remove(cartItem);
                    data.SaveChanges();

                    // 3. Cập nhật lại Session
                    int totalItems = data.GioHangs
                                       .Where(g => g.MaKhachHang == maKhachHang)
                                       .Sum(g => (int?)g.SoLuong) ?? 0;
                    Session["GioHangCount"] = totalItems;
                }
            }

            return RedirectToAction("ViewCart", "Home");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                data.Dispose();
            }
            base.Dispose(disposing);
        }

        [HttpPost]
        public JsonResult AddComboToCart(string itemset)
        {
            try
            {
                if (Session["MaTaiKhoan"] == null && Session["MaKH"] == null)
                {
                    return Json(new
                    {
                        success = false,
                        requireLogin = true,
                        loginUrl = Url.Action("DangNhap", "TaiKhoan", new { returnUrl = Url.Action("Index", "Home") }),
                        message = "Vui lòng đăng nhập để mua Combo!"
                    });
                }

                if (string.IsNullOrWhiteSpace(itemset))
                {
                    return Json(new { success = false, message = "Combo không hợp lệ." });
                }

                int maKH = -1;
                if (Session["MaKH"] != null)
                {
                    maKH = (int)Session["MaKH"];
                }
                else if (Session["MaTaiKhoan"] != null)
                {
                    int maTaiKhoan = (int)Session["MaTaiKhoan"];
                    var khachHang = data.KhachHangs.FirstOrDefault(k => k.MaTaiKhoan == maTaiKhoan);
                    if (khachHang != null)
                    {
                        maKH = khachHang.MaKhachHang;
                        Session["MaKH"] = maKH;
                    }
                }

                if (maKH <= 0)
                {
                    return Json(new { success = false, message = "Không tìm thấy thông tin khách hàng." });
                }

                var normalizedItemset = itemset.Replace("[", " ").Replace("]", " ");
                var productIds = Regex.Split(normalizedItemset, @"[\s,;|]+")
                                      .Where(x => !string.IsNullOrWhiteSpace(x))
                                      .Select(x =>
                                      {
                                          int value;
                                          return int.TryParse(x, out value) ? (int?)value : null;
                                      })
                                      .Where(x => x.HasValue)
                                      .Select(x => x.Value)
                                      .Distinct()
                                      .ToList();

                if (!productIds.Any())
                {
                    return Json(new { success = false, message = "Không đọc được sản phẩm trong combo." });
                }

                using (var db = new QLDN_CAULONGEntities())
                {
                    int addedCount = 0;

                    foreach (var maSP in productIds)
                    {
                        // Tìm biến thể (ChiTietSanPham) mặc định của sản phẩm này (còn hàng)
                        var chiTiet = db.ChiTietSanPhams
                                        .Where(ct => ct.MaSanPham == maSP && ct.SoLuongTon > 0)
                                        .OrderBy(ct => ct.MaChiTiet)
                                        .FirstOrDefault();

                        // Fallback: hỗ trợ trường hợp itemset lưu MaChiTiet thay vì MaSanPham
                        if (chiTiet == null)
                        {
                            chiTiet = db.ChiTietSanPhams
                                       .Where(ct => ct.MaChiTiet == maSP && ct.SoLuongTon > 0)
                                       .OrderBy(ct => ct.MaChiTiet)
                                       .FirstOrDefault();
                        }

                        if (chiTiet != null)
                        {
                            // Kiểm tra xem sản phẩm đã có trong giỏ chưa
                            var cartItem = db.GioHangs.FirstOrDefault(g => g.MaKhachHang == maKH && g.MaChiTietSanPham == chiTiet.MaChiTiet);

                            if (cartItem != null)
                            {
                                cartItem.SoLuong = (cartItem.SoLuong ?? 0) + 1;
                                cartItem.NgayThem = DateTime.Now;
                                // Cập nhật giá thành giá combo (nếu DB GioHang của bạn có lưu cột DonGia)
                                // cartItem.DonGia = giaCombo; 
                            }
                            else
                            {
                                var newItem = new GioHang
                                {
                                    MaKhachHang = maKH,
                                    MaChiTietSanPham = chiTiet.MaChiTiet,
                                    SoLuong = 1,
                                    NgayThem = DateTime.Now,
                                    // Thêm cột DonGia = giaCombo nếu model GioHang có lưu giá
                                };
                                db.GioHangs.Add(newItem);
                            }

                            addedCount++;
                        }
                    }

                    if (addedCount == 0)
                    {
                        return Json(new { success = false, message = "Các sản phẩm trong combo hiện đã hết hàng." });
                    }

                    // Lưu biến Session để áp dụng cờ "Đã dùng Combo 10%" cho trang Thanh Toán
                    Session["ComboDiscountApplied"] = true;

                    db.SaveChanges();

                    Session["GioHangCount"] = db.GioHangs
                        .Where(g => g.MaKhachHang == maKH)
                        .Sum(g => (int?)g.SoLuong) ?? 0;

                    return Json(new { success = true, message = "Đã thêm combo vào giỏ hàng!" });
                }
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = "Có lỗi xảy ra: " + ex.Message });
            }
        }
    }
}