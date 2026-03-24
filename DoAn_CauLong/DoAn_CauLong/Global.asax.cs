using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using System.Timers;
using DoAn_CauLong.Services;

namespace DoAn_CauLong
{
    public class MvcApplication : System.Web.HttpApplication
    {
        private static Timer _miningTimer;
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            SetupBackgroundMiningJob();
        }
        private void SetupBackgroundMiningJob()
        {
            // Thiết lập thời gian chạy định kỳ
            double interval = 1000;

            _miningTimer = new Timer(interval);

            // Hàm này sẽ tự động được gọi mỗi khi hết thời gian (interval)
            _miningTimer.Elapsed += (sender, e) =>
            {
                try
                {
                    var service = new MiningService();
                    // Chạy thuật toán ngầm
                    service.ChayThuậtToanKhaiPha(windowSize: 3, topK: 10);

                    System.Diagnostics.Debug.WriteLine($"[{DateTime.Now}] Đã tự động cập nhật lại luật Gợi ý sản phẩm.");
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("Lỗi khi Auto Mining: " + ex.Message);
                }
            };

            _miningTimer.AutoReset = true; // Lặp đi lặp lại
            _miningTimer.Enabled = true;   // Kích hoạt
        }
    }
}
