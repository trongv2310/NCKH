using Reqnroll;
using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using FluentAssertions;
using System;

[Binding]
public class DangNhapSteps
{
    private IWebDriver _driver;

    [Given(@"tôi đã truy cập vào trang đăng nhập")]
    public void GivenToiDaTruyCapTrangDangNhap()
    {
        _driver = new ChromeDriver();
        _driver.Navigate().GoToUrl("https://localhost:44336/TaiKhoan/DangNhap"); // Kiểm tra port khi chạy web
    }

    [When(@"tôi nhập tên đăng nhập là ""(.*)"" và mật khẩu là ""(.*)""")]
    public void WhenToiNhapThongTin(string username, string password)
    {
        _driver.FindElement(By.Name("TenDangNhap")).SendKeys(username);
        _driver.FindElement(By.Name("MatKhau")).SendKeys(password);
    }

    [When(@"tôi nhấn vào nút ""Đăng nhập""")]
    public void WhenToiNhanNutDangNhap()
    {
        _driver.FindElement(By.CssSelector("button[type='submit']")).Click();       
    }

    [Then(@"tôi sẽ thấy tên ""(.*)"" hiển thị trên thanh điều hướng")]
    public void ThenToiSeThayTenHienThi(string expectedName)
    {
        var navText = _driver.FindElement(By.ClassName("navbar")).Text;
        navText.Should().Contain(expectedName);
        System.Threading.Thread.Sleep(5000);
        _driver.Quit();
    }
}