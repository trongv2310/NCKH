using System;
using System.Collections.Generic;
using System.Linq;
using DoAn_CauLong.Models;
using DoAn_CauLong.DataMining;

namespace DoAn_CauLong.Services
{
    public class MiningService
    {
        public void ChayThuậtToanKhaiPha(int windowSize = 3, int topK = 10)
        {
            try
            {
                using (var db = new QLDN_CAULONGEntities())
                {
                    var miner = new VertTopKDS(k: topK, winSize: windowSize);
                    DateTime now = DateTime.Now;

                    // Giả lập chia dữ liệu thành các Batch theo tháng (3 tháng gần nhất = 3 batch)
                    for (int i = windowSize; i >= 1; i--)
                    {
                        DateTime startTime = now.AddMonths(-i);
                        DateTime endTime = now.AddMonths(-(i - 1));
                        string batchId = $"Batch_{startTime:yyyyMM}";

                        var batchData = new List<TransactionDto>();

                        // Lấy các đơn hàng hoàn thành
                        var donHangs = db.DonHangs
                            .Where(x => x.TrangThai == "Đã hoàn thành" && x.NgayDat >= startTime && x.NgayDat < endTime)
                            .ToList();

                        foreach (var dh in donHangs)
                        {
                            // Nhóm các ChiTietDonHang theo MaSanPham (Bỏ qua size, màu sắc)
                            var itemsGrouped = db.ChiTietDonHangs
                                .Where(c => c.MaDonHang == dh.MaDonHang && c.ChiTietSanPham.MaSanPham.HasValue)
                                .GroupBy(c => c.ChiTietSanPham.MaSanPham.Value)
                                .Select(g => new
                                {
                                    MaSP = g.Key,
                                    SoLuong = g.Sum(x => x.SoLuong ?? 0),
                                    TongUtility = g.Sum(x => (double)((x.SoLuong ?? 0) * (x.DonGia ?? 0)))
                                }).ToList();

                            // Chỉ xét các đơn mua từ 2 sản phẩm khác loại trở lên
                            if (itemsGrouped.Count < 2) continue;

                            var trans = new TransactionDto { Tid = dh.MaDonHang };

                            foreach (var item in itemsGrouped)
                            {
                                trans.Items[item.MaSP] = item.SoLuong;
                                trans.Utils[item.MaSP] = item.TongUtility;
                                trans.Tu += item.TongUtility;
                            }

                            batchData.Add(trans);
                        }

                        // Đưa dữ liệu vào thuật toán
                        miner.ProcessBatch(batchId, batchData);
                    }

                    // Lưu kết quả vào DB
                    var results = miner.GetResults();
                    if (results.Any())
                    {
                        // FIX LỖI TRÙNG LẶP: Dùng RemoveRange của EF thay vì lệnh TRUNCATE dễ bị lỗi khóa bảng
                        var oldData = db.GoiYSanPhams.ToList();
                        if (oldData.Any())
                        {
                            db.GoiYSanPhams.RemoveRange(oldData);
                            db.SaveChanges(); // Xóa sạch bảng cũ
                        }

                        // Không cần hàm Where(Itemset.Count > 1) nữa vì VertTopKDS đã lọc giúp ta rồi
                        foreach (var r in results)
                        {
                            db.GoiYSanPhams.Add(new GoiYSanPham
                            {
                                Itemset = string.Join(",", r.Itemset),
                                Utility = r.Utility,
                                CreatedAt = DateTime.Now
                            });
                        }
                        db.SaveChanges();
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Lỗi Mining: " + ex.Message);
            }
        }
    }
}