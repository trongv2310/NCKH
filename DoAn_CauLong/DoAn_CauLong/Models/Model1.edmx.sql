
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 03/25/2019 13:27:15
-- Generated from EDMX file: D:\HocTap\NCKH\NCKH\DoAn_CauLong\DoAn_CauLong\Models\Model1.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [QLDN_CAULONG];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK__ChiTietDo__MaChi__6FE99F9F]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ChiTietDonHang] DROP CONSTRAINT [FK__ChiTietDo__MaChi__6FE99F9F];
GO
IF OBJECT_ID(N'[dbo].[FK__ChiTietDo__MaDon__6EF57B66]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ChiTietDonHang] DROP CONSTRAINT [FK__ChiTietDo__MaDon__6EF57B66];
GO
IF OBJECT_ID(N'[dbo].[FK__ChiTietSa__MaMau__59063A47]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ChiTietSanPham] DROP CONSTRAINT [FK__ChiTietSa__MaMau__59063A47];
GO
IF OBJECT_ID(N'[dbo].[FK__ChiTietSa__MaSan__5812160E]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ChiTietSanPham] DROP CONSTRAINT [FK__ChiTietSa__MaSan__5812160E];
GO
IF OBJECT_ID(N'[dbo].[FK__ChiTietSa__MaSiz__59FA5E80]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ChiTietSanPham] DROP CONSTRAINT [FK__ChiTietSa__MaSiz__59FA5E80];
GO
IF OBJECT_ID(N'[dbo].[FK__DonHang__MaKhach__693CA210]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[DonHang] DROP CONSTRAINT [FK__DonHang__MaKhach__693CA210];
GO
IF OBJECT_ID(N'[dbo].[FK__GioHang__MaChiTi__7B5B524B]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[GioHang] DROP CONSTRAINT [FK__GioHang__MaChiTi__7B5B524B];
GO
IF OBJECT_ID(N'[dbo].[FK__GioHang__MaKhach__7A672E12]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[GioHang] DROP CONSTRAINT [FK__GioHang__MaKhach__7A672E12];
GO
IF OBJECT_ID(N'[dbo].[FK__KhachHang__MaTai__619B8048]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[KhachHang] DROP CONSTRAINT [FK__KhachHang__MaTai__619B8048];
GO
IF OBJECT_ID(N'[dbo].[FK__LichSuTha__MaChi__09A971A2]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[LichSuThayDoiGia] DROP CONSTRAINT [FK__LichSuTha__MaChi__09A971A2];
GO
IF OBJECT_ID(N'[dbo].[FK__LogLoiGia__MaChi__0E6E26BF]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[LogLoiGiaoTac] DROP CONSTRAINT [FK__LogLoiGia__MaChi__0E6E26BF];
GO
IF OBJECT_ID(N'[dbo].[FK__PhanHoi__MaKhach__74AE54BC]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[PhanHoi] DROP CONSTRAINT [FK__PhanHoi__MaKhach__74AE54BC];
GO
IF OBJECT_ID(N'[dbo].[FK__PhanHoi__MaSanPh__75A278F5]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[PhanHoi] DROP CONSTRAINT [FK__PhanHoi__MaSanPh__75A278F5];
GO
IF OBJECT_ID(N'[dbo].[FK__SanPham__MaHang__52593CB8]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[SanPham] DROP CONSTRAINT [FK__SanPham__MaHang__52593CB8];
GO
IF OBJECT_ID(N'[dbo].[FK__SanPham__MaKhuye__5165187F]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[SanPham] DROP CONSTRAINT [FK__SanPham__MaKhuye__5165187F];
GO
IF OBJECT_ID(N'[dbo].[FK__SanPham__MaLoai__4F7CD00D]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[SanPham] DROP CONSTRAINT [FK__SanPham__MaLoai__4F7CD00D];
GO
IF OBJECT_ID(N'[dbo].[FK__SanPham__MaNhaCu__5070F446]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[SanPham] DROP CONSTRAINT [FK__SanPham__MaNhaCu__5070F446];
GO
IF OBJECT_ID(N'[dbo].[FK__TaiKhoan__MaQuye__3B75D760]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[TaiKhoan] DROP CONSTRAINT [FK__TaiKhoan__MaQuye__3B75D760];
GO
IF OBJECT_ID(N'[dbo].[FK__ThongSoVo__MaChi__5CD6CB2B]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ThongSoVot] DROP CONSTRAINT [FK__ThongSoVo__MaChi__5CD6CB2B];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[ChiTietDonHang]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ChiTietDonHang];
GO
IF OBJECT_ID(N'[dbo].[ChiTietSanPham]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ChiTietSanPham];
GO
IF OBJECT_ID(N'[dbo].[DonHang]', 'U') IS NOT NULL
    DROP TABLE [dbo].[DonHang];
GO
IF OBJECT_ID(N'[dbo].[GoiYSanPham]', 'U') IS NOT NULL
    DROP TABLE [dbo].[GoiYSanPham];
GO
IF OBJECT_ID(N'[dbo].[GioHang]', 'U') IS NOT NULL
    DROP TABLE [dbo].[GioHang];
GO
IF OBJECT_ID(N'[dbo].[Hang]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Hang];
GO
IF OBJECT_ID(N'[dbo].[KhachHang]', 'U') IS NOT NULL
    DROP TABLE [dbo].[KhachHang];
GO
IF OBJECT_ID(N'[dbo].[KhuyenMai]', 'U') IS NOT NULL
    DROP TABLE [dbo].[KhuyenMai];
GO
IF OBJECT_ID(N'[dbo].[LichSuThayDoiGia]', 'U') IS NOT NULL
    DROP TABLE [dbo].[LichSuThayDoiGia];
GO
IF OBJECT_ID(N'[dbo].[LoaiSanPham]', 'U') IS NOT NULL
    DROP TABLE [dbo].[LoaiSanPham];
GO
IF OBJECT_ID(N'[dbo].[LogLoiGiaoTac]', 'U') IS NOT NULL
    DROP TABLE [dbo].[LogLoiGiaoTac];
GO
IF OBJECT_ID(N'[dbo].[MauSac]', 'U') IS NOT NULL
    DROP TABLE [dbo].[MauSac];
GO
IF OBJECT_ID(N'[dbo].[NhaCungCap]', 'U') IS NOT NULL
    DROP TABLE [dbo].[NhaCungCap];
GO
IF OBJECT_ID(N'[dbo].[PhanHoi]', 'U') IS NOT NULL
    DROP TABLE [dbo].[PhanHoi];
GO
IF OBJECT_ID(N'[dbo].[PhanQuyen]', 'U') IS NOT NULL
    DROP TABLE [dbo].[PhanQuyen];
GO
IF OBJECT_ID(N'[dbo].[SanPham]', 'U') IS NOT NULL
    DROP TABLE [dbo].[SanPham];
GO
IF OBJECT_ID(N'[dbo].[Size]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Size];
GO
IF OBJECT_ID(N'[dbo].[TaiKhoan]', 'U') IS NOT NULL
    DROP TABLE [dbo].[TaiKhoan];
GO
IF OBJECT_ID(N'[dbo].[ThongSoVot]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ThongSoVot];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'ChiTietDonHangs'
CREATE TABLE [dbo].[ChiTietDonHangs] (
    [MaChiTiet] int IDENTITY(1,1) NOT NULL,
    [MaDonHang] int  NULL,
    [MaChiTietSanPham] int  NULL,
    [SoLuong] int  NULL,
    [DonGia] decimal(15,2)  NULL,
    [ThanhTien] decimal(15,2)  NULL
);
GO

-- Creating table 'ChiTietSanPhams'
CREATE TABLE [dbo].[ChiTietSanPhams] (
    [MaChiTiet] int IDENTITY(1,1) NOT NULL,
    [MaSanPham] int  NULL,
    [MaMau] int  NULL,
    [MaSize] int  NULL,
    [GiaBan] decimal(15,2)  NULL,
    [SoLuongTon] int  NULL,
    [SKU] varchar(50)  NOT NULL,
    [HinhAnh] varchar(255)  NULL
);
GO

-- Creating table 'DonHangs'
CREATE TABLE [dbo].[DonHangs] (
    [MaDonHang] int IDENTITY(1,1) NOT NULL,
    [NgayDat] datetime  NULL,
    [TrangThai] nvarchar(50)  NULL,
    [TongTien] decimal(15,2)  NULL,
    [TongTienSauGiam] decimal(15,2)  NULL,
    [MaKhachHang] int  NULL,
    [TienGiam] decimal(15,2)  NULL,
    [DiaChiGiaoHang] nvarchar(255)  NULL,
    [SoDienThoaiNhanHang] varchar(15)  NULL,
    [GhiChu] nvarchar(500)  NULL
);
GO

-- Creating table 'GioHangs'
CREATE TABLE [dbo].[GioHangs] (
    [MaGioHang] int IDENTITY(1,1) NOT NULL,
    [MaKhachHang] int  NULL,
    [MaChiTietSanPham] int  NULL,
    [SoLuong] int  NULL,
    [NgayThem] datetime  NULL
);
GO

-- Creating table 'Hangs'
CREATE TABLE [dbo].[Hangs] (
    [MaHang] int IDENTITY(1,1) NOT NULL,
    [TenHang] nvarchar(100)  NOT NULL,
    [QuocGia] nvarchar(50)  NULL
);
GO

-- Creating table 'KhachHangs'
CREATE TABLE [dbo].[KhachHangs] (
    [MaKhachHang] int IDENTITY(1,1) NOT NULL,
    [HoTen] nvarchar(100)  NOT NULL,
    [Email] varchar(100)  NULL,
    [SoDienThoai] varchar(15)  NULL,
    [DiaChi] nvarchar(255)  NULL,
    [MaTaiKhoan] int  NULL,
    [NgayTao] datetime  NULL
);
GO

-- Creating table 'KhuyenMais'
CREATE TABLE [dbo].[KhuyenMais] (
    [MaKhuyenMai] int IDENTITY(1,1) NOT NULL,
    [TenChuongTrinh] nvarchar(100)  NOT NULL,
    [MoTa] nvarchar(255)  NULL,
    [NgayBatDau] datetime  NULL,
    [NgayKetThuc] datetime  NULL,
    [PhanTramGiam] decimal(5,2)  NULL,
    [GiamToiDa] decimal(15,2)  NULL,
    [SoLuongSuDung] int  NULL
);
GO

-- Creating table 'LoaiSanPhams'
CREATE TABLE [dbo].[LoaiSanPhams] (
    [MaLoai] int IDENTITY(1,1) NOT NULL,
    [TenLoai] nvarchar(100)  NOT NULL,
    [MoTa] nvarchar(255)  NULL
);
GO

-- Creating table 'MauSacs'
CREATE TABLE [dbo].[MauSacs] (
    [MaMau] int IDENTITY(1,1) NOT NULL,
    [TenMau] nvarchar(50)  NOT NULL
);
GO

-- Creating table 'NhaCungCaps'
CREATE TABLE [dbo].[NhaCungCaps] (
    [MaNhaCungCap] int IDENTITY(1,1) NOT NULL,
    [TenNhaCungCap] nvarchar(100)  NOT NULL,
    [DiaChi] nvarchar(255)  NULL,
    [SoDienThoai] varchar(15)  NULL,
    [Email] varchar(100)  NULL
);
GO

-- Creating table 'PhanHois'
CREATE TABLE [dbo].[PhanHois] (
    [MaPhanHoi] int IDENTITY(1,1) NOT NULL,
    [NoiDung] nvarchar(255)  NULL,
    [NgayPhanHoi] datetime  NULL,
    [DanhGia] int  NULL,
    [MaKhachHang] int  NULL,
    [MaSanPham] int  NULL
);
GO

-- Creating table 'PhanQuyens'
CREATE TABLE [dbo].[PhanQuyens] (
    [MaQuyen] int IDENTITY(1,1) NOT NULL,
    [TenQuyen] nvarchar(50)  NOT NULL
);
GO

-- Creating table 'SanPhams'
CREATE TABLE [dbo].[SanPhams] (
    [MaSanPham] int IDENTITY(1,1) NOT NULL,
    [TenSanPham] nvarchar(100)  NOT NULL,
    [MoTa] nvarchar(max)  NULL,
    [GiaGoc] decimal(15,2)  NULL,
    [HinhAnhDaiDien] varchar(255)  NULL,
    [MaLoai] int  NULL,
    [MaNhaCungCap] int  NULL,
    [MaHang] int  NULL,
    [MaKhuyenMai] int  NULL,
    [CoSize] bit  NULL,
    [CoMau] bit  NULL,
    [NgayTao] datetime  NULL
);
GO

-- Creating table 'Sizes'
CREATE TABLE [dbo].[Sizes] (
    [MaSize] int IDENTITY(1,1) NOT NULL,
    [TenSize] varchar(20)  NOT NULL,
    [LoaiSize] nvarchar(30)  NOT NULL
);
GO

-- Creating table 'TaiKhoans'
CREATE TABLE [dbo].[TaiKhoans] (
    [MaTaiKhoan] int IDENTITY(1,1) NOT NULL,
    [TenDangNhap] varchar(50)  NOT NULL,
    [MatKhau] varchar(255)  NOT NULL,
    [Email] varchar(100)  NULL,
    [MaQuyen] int  NULL,
    [NgayTao] datetime  NULL
);
GO

-- Creating table 'ThongSoVots'
CREATE TABLE [dbo].[ThongSoVots] (
    [MaThongSo] int IDENTITY(1,1) NOT NULL,
    [MaChiTiet] int  NULL,
    [DoCanBang] nvarchar(50)  NULL,
    [TrongLuong] varchar(20)  NULL,
    [DoCung] nvarchar(50)  NULL,
    [ChieuDai] nvarchar(20)  NULL,
    [SucCang] nvarchar(20)  NULL
);
GO

-- Creating table 'LichSuThayDoiGias'
CREATE TABLE [dbo].[LichSuThayDoiGias] (
    [MaLichSu] int IDENTITY(1,1) NOT NULL,
    [MaChiTiet] int  NOT NULL,
    [GiaCu] decimal(15,2)  NOT NULL,
    [GiaMoi] decimal(15,2)  NOT NULL,
    [SoLuongCu] int  NOT NULL,
    [SoLuongMoi] int  NOT NULL,
    [ThoiGianThayDoi] datetime  NULL,
    [NguoiThayDoi] nvarchar(100)  NULL
);
GO

-- Creating table 'LogLoiGiaoTacs'
CREATE TABLE [dbo].[LogLoiGiaoTacs] (
    [MaLog] int IDENTITY(1,1) NOT NULL,
    [Loi] nvarchar(1000)  NULL,
    [ThoiGian] datetime  NULL,
    [NguoiThucHien] nvarchar(100)  NULL,
    [MaChiTiet1] int  NULL
);
GO

-- Creating table 'GoiYSanPhams'
CREATE TABLE [dbo].[GoiYSanPhams] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Itemset] varchar(255)  NOT NULL,
    [Utility] float  NOT NULL,
    [CreatedAt] datetime  NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [MaChiTiet] in table 'ChiTietDonHangs'
ALTER TABLE [dbo].[ChiTietDonHangs]
ADD CONSTRAINT [PK_ChiTietDonHangs]
    PRIMARY KEY CLUSTERED ([MaChiTiet] ASC);
GO

-- Creating primary key on [MaChiTiet] in table 'ChiTietSanPhams'
ALTER TABLE [dbo].[ChiTietSanPhams]
ADD CONSTRAINT [PK_ChiTietSanPhams]
    PRIMARY KEY CLUSTERED ([MaChiTiet] ASC);
GO

-- Creating primary key on [MaDonHang] in table 'DonHangs'
ALTER TABLE [dbo].[DonHangs]
ADD CONSTRAINT [PK_DonHangs]
    PRIMARY KEY CLUSTERED ([MaDonHang] ASC);
GO

-- Creating primary key on [MaGioHang] in table 'GioHangs'
ALTER TABLE [dbo].[GioHangs]
ADD CONSTRAINT [PK_GioHangs]
    PRIMARY KEY CLUSTERED ([MaGioHang] ASC);
GO

-- Creating primary key on [MaHang] in table 'Hangs'
ALTER TABLE [dbo].[Hangs]
ADD CONSTRAINT [PK_Hangs]
    PRIMARY KEY CLUSTERED ([MaHang] ASC);
GO

-- Creating primary key on [MaKhachHang] in table 'KhachHangs'
ALTER TABLE [dbo].[KhachHangs]
ADD CONSTRAINT [PK_KhachHangs]
    PRIMARY KEY CLUSTERED ([MaKhachHang] ASC);
GO

-- Creating primary key on [MaKhuyenMai] in table 'KhuyenMais'
ALTER TABLE [dbo].[KhuyenMais]
ADD CONSTRAINT [PK_KhuyenMais]
    PRIMARY KEY CLUSTERED ([MaKhuyenMai] ASC);
GO

-- Creating primary key on [MaLoai] in table 'LoaiSanPhams'
ALTER TABLE [dbo].[LoaiSanPhams]
ADD CONSTRAINT [PK_LoaiSanPhams]
    PRIMARY KEY CLUSTERED ([MaLoai] ASC);
GO

-- Creating primary key on [MaMau] in table 'MauSacs'
ALTER TABLE [dbo].[MauSacs]
ADD CONSTRAINT [PK_MauSacs]
    PRIMARY KEY CLUSTERED ([MaMau] ASC);
GO

-- Creating primary key on [MaNhaCungCap] in table 'NhaCungCaps'
ALTER TABLE [dbo].[NhaCungCaps]
ADD CONSTRAINT [PK_NhaCungCaps]
    PRIMARY KEY CLUSTERED ([MaNhaCungCap] ASC);
GO

-- Creating primary key on [MaPhanHoi] in table 'PhanHois'
ALTER TABLE [dbo].[PhanHois]
ADD CONSTRAINT [PK_PhanHois]
    PRIMARY KEY CLUSTERED ([MaPhanHoi] ASC);
GO

-- Creating primary key on [MaQuyen] in table 'PhanQuyens'
ALTER TABLE [dbo].[PhanQuyens]
ADD CONSTRAINT [PK_PhanQuyens]
    PRIMARY KEY CLUSTERED ([MaQuyen] ASC);
GO

-- Creating primary key on [MaSanPham] in table 'SanPhams'
ALTER TABLE [dbo].[SanPhams]
ADD CONSTRAINT [PK_SanPhams]
    PRIMARY KEY CLUSTERED ([MaSanPham] ASC);
GO

-- Creating primary key on [MaSize] in table 'Sizes'
ALTER TABLE [dbo].[Sizes]
ADD CONSTRAINT [PK_Sizes]
    PRIMARY KEY CLUSTERED ([MaSize] ASC);
GO

-- Creating primary key on [MaTaiKhoan] in table 'TaiKhoans'
ALTER TABLE [dbo].[TaiKhoans]
ADD CONSTRAINT [PK_TaiKhoans]
    PRIMARY KEY CLUSTERED ([MaTaiKhoan] ASC);
GO

-- Creating primary key on [MaThongSo] in table 'ThongSoVots'
ALTER TABLE [dbo].[ThongSoVots]
ADD CONSTRAINT [PK_ThongSoVots]
    PRIMARY KEY CLUSTERED ([MaThongSo] ASC);
GO

-- Creating primary key on [MaLichSu] in table 'LichSuThayDoiGias'
ALTER TABLE [dbo].[LichSuThayDoiGias]
ADD CONSTRAINT [PK_LichSuThayDoiGias]
    PRIMARY KEY CLUSTERED ([MaLichSu] ASC);
GO

-- Creating primary key on [MaLog] in table 'LogLoiGiaoTacs'
ALTER TABLE [dbo].[LogLoiGiaoTacs]
ADD CONSTRAINT [PK_LogLoiGiaoTacs]
    PRIMARY KEY CLUSTERED ([MaLog] ASC);
GO

-- Creating primary key on [Id] in table 'GoiYSanPhams'
ALTER TABLE [dbo].[GoiYSanPhams]
ADD CONSTRAINT [PK_GoiYSanPhams]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [MaChiTietSanPham] in table 'ChiTietDonHangs'
ALTER TABLE [dbo].[ChiTietDonHangs]
ADD CONSTRAINT [FK__ChiTietDo__MaChi__02084FDA]
    FOREIGN KEY ([MaChiTietSanPham])
    REFERENCES [dbo].[ChiTietSanPhams]
        ([MaChiTiet])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__ChiTietDo__MaChi__02084FDA'
CREATE INDEX [IX_FK__ChiTietDo__MaChi__02084FDA]
ON [dbo].[ChiTietDonHangs]
    ([MaChiTietSanPham]);
GO

-- Creating foreign key on [MaDonHang] in table 'ChiTietDonHangs'
ALTER TABLE [dbo].[ChiTietDonHangs]
ADD CONSTRAINT [FK__ChiTietDo__MaDon__01142BA1]
    FOREIGN KEY ([MaDonHang])
    REFERENCES [dbo].[DonHangs]
        ([MaDonHang])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__ChiTietDo__MaDon__01142BA1'
CREATE INDEX [IX_FK__ChiTietDo__MaDon__01142BA1]
ON [dbo].[ChiTietDonHangs]
    ([MaDonHang]);
GO

-- Creating foreign key on [MaMau] in table 'ChiTietSanPhams'
ALTER TABLE [dbo].[ChiTietSanPhams]
ADD CONSTRAINT [FK__ChiTietSa__MaMau__6B24EA82]
    FOREIGN KEY ([MaMau])
    REFERENCES [dbo].[MauSacs]
        ([MaMau])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__ChiTietSa__MaMau__6B24EA82'
CREATE INDEX [IX_FK__ChiTietSa__MaMau__6B24EA82]
ON [dbo].[ChiTietSanPhams]
    ([MaMau]);
GO

-- Creating foreign key on [MaSanPham] in table 'ChiTietSanPhams'
ALTER TABLE [dbo].[ChiTietSanPhams]
ADD CONSTRAINT [FK__ChiTietSa__MaSan__6A30C649]
    FOREIGN KEY ([MaSanPham])
    REFERENCES [dbo].[SanPhams]
        ([MaSanPham])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__ChiTietSa__MaSan__6A30C649'
CREATE INDEX [IX_FK__ChiTietSa__MaSan__6A30C649]
ON [dbo].[ChiTietSanPhams]
    ([MaSanPham]);
GO

-- Creating foreign key on [MaSize] in table 'ChiTietSanPhams'
ALTER TABLE [dbo].[ChiTietSanPhams]
ADD CONSTRAINT [FK__ChiTietSa__MaSiz__6C190EBB]
    FOREIGN KEY ([MaSize])
    REFERENCES [dbo].[Sizes]
        ([MaSize])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__ChiTietSa__MaSiz__6C190EBB'
CREATE INDEX [IX_FK__ChiTietSa__MaSiz__6C190EBB]
ON [dbo].[ChiTietSanPhams]
    ([MaSize]);
GO

-- Creating foreign key on [MaChiTietSanPham] in table 'GioHangs'
ALTER TABLE [dbo].[GioHangs]
ADD CONSTRAINT [FK__GioHang__MaChiTi__0D7A0286]
    FOREIGN KEY ([MaChiTietSanPham])
    REFERENCES [dbo].[ChiTietSanPhams]
        ([MaChiTiet])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__GioHang__MaChiTi__0D7A0286'
CREATE INDEX [IX_FK__GioHang__MaChiTi__0D7A0286]
ON [dbo].[GioHangs]
    ([MaChiTietSanPham]);
GO

-- Creating foreign key on [MaChiTiet] in table 'ThongSoVots'
ALTER TABLE [dbo].[ThongSoVots]
ADD CONSTRAINT [FK__ThongSoVo__MaChi__6EF57B66]
    FOREIGN KEY ([MaChiTiet])
    REFERENCES [dbo].[ChiTietSanPhams]
        ([MaChiTiet])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__ThongSoVo__MaChi__6EF57B66'
CREATE INDEX [IX_FK__ThongSoVo__MaChi__6EF57B66]
ON [dbo].[ThongSoVots]
    ([MaChiTiet]);
GO

-- Creating foreign key on [MaKhachHang] in table 'DonHangs'
ALTER TABLE [dbo].[DonHangs]
ADD CONSTRAINT [FK__DonHang__MaKhach__7B5B524B]
    FOREIGN KEY ([MaKhachHang])
    REFERENCES [dbo].[KhachHangs]
        ([MaKhachHang])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__DonHang__MaKhach__7B5B524B'
CREATE INDEX [IX_FK__DonHang__MaKhach__7B5B524B]
ON [dbo].[DonHangs]
    ([MaKhachHang]);
GO

-- Creating foreign key on [MaKhachHang] in table 'GioHangs'
ALTER TABLE [dbo].[GioHangs]
ADD CONSTRAINT [FK__GioHang__MaKhach__0C85DE4D]
    FOREIGN KEY ([MaKhachHang])
    REFERENCES [dbo].[KhachHangs]
        ([MaKhachHang])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__GioHang__MaKhach__0C85DE4D'
CREATE INDEX [IX_FK__GioHang__MaKhach__0C85DE4D]
ON [dbo].[GioHangs]
    ([MaKhachHang]);
GO

-- Creating foreign key on [MaHang] in table 'SanPhams'
ALTER TABLE [dbo].[SanPhams]
ADD CONSTRAINT [FK__SanPham__MaHang__6477ECF3]
    FOREIGN KEY ([MaHang])
    REFERENCES [dbo].[Hangs]
        ([MaHang])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__SanPham__MaHang__6477ECF3'
CREATE INDEX [IX_FK__SanPham__MaHang__6477ECF3]
ON [dbo].[SanPhams]
    ([MaHang]);
GO

-- Creating foreign key on [MaTaiKhoan] in table 'KhachHangs'
ALTER TABLE [dbo].[KhachHangs]
ADD CONSTRAINT [FK__KhachHang__MaTai__73BA3083]
    FOREIGN KEY ([MaTaiKhoan])
    REFERENCES [dbo].[TaiKhoans]
        ([MaTaiKhoan])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__KhachHang__MaTai__73BA3083'
CREATE INDEX [IX_FK__KhachHang__MaTai__73BA3083]
ON [dbo].[KhachHangs]
    ([MaTaiKhoan]);
GO

-- Creating foreign key on [MaKhachHang] in table 'PhanHois'
ALTER TABLE [dbo].[PhanHois]
ADD CONSTRAINT [FK__PhanHoi__MaKhach__06CD04F7]
    FOREIGN KEY ([MaKhachHang])
    REFERENCES [dbo].[KhachHangs]
        ([MaKhachHang])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__PhanHoi__MaKhach__06CD04F7'
CREATE INDEX [IX_FK__PhanHoi__MaKhach__06CD04F7]
ON [dbo].[PhanHois]
    ([MaKhachHang]);
GO

-- Creating foreign key on [MaKhuyenMai] in table 'SanPhams'
ALTER TABLE [dbo].[SanPhams]
ADD CONSTRAINT [FK__SanPham__MaKhuye__6383C8BA]
    FOREIGN KEY ([MaKhuyenMai])
    REFERENCES [dbo].[KhuyenMais]
        ([MaKhuyenMai])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__SanPham__MaKhuye__6383C8BA'
CREATE INDEX [IX_FK__SanPham__MaKhuye__6383C8BA]
ON [dbo].[SanPhams]
    ([MaKhuyenMai]);
GO

-- Creating foreign key on [MaLoai] in table 'SanPhams'
ALTER TABLE [dbo].[SanPhams]
ADD CONSTRAINT [FK__SanPham__MaLoai__619B8048]
    FOREIGN KEY ([MaLoai])
    REFERENCES [dbo].[LoaiSanPhams]
        ([MaLoai])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__SanPham__MaLoai__619B8048'
CREATE INDEX [IX_FK__SanPham__MaLoai__619B8048]
ON [dbo].[SanPhams]
    ([MaLoai]);
GO

-- Creating foreign key on [MaNhaCungCap] in table 'SanPhams'
ALTER TABLE [dbo].[SanPhams]
ADD CONSTRAINT [FK__SanPham__MaNhaCu__628FA481]
    FOREIGN KEY ([MaNhaCungCap])
    REFERENCES [dbo].[NhaCungCaps]
        ([MaNhaCungCap])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__SanPham__MaNhaCu__628FA481'
CREATE INDEX [IX_FK__SanPham__MaNhaCu__628FA481]
ON [dbo].[SanPhams]
    ([MaNhaCungCap]);
GO

-- Creating foreign key on [MaSanPham] in table 'PhanHois'
ALTER TABLE [dbo].[PhanHois]
ADD CONSTRAINT [FK__PhanHoi__MaSanPh__07C12930]
    FOREIGN KEY ([MaSanPham])
    REFERENCES [dbo].[SanPhams]
        ([MaSanPham])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__PhanHoi__MaSanPh__07C12930'
CREATE INDEX [IX_FK__PhanHoi__MaSanPh__07C12930]
ON [dbo].[PhanHois]
    ([MaSanPham]);
GO

-- Creating foreign key on [MaQuyen] in table 'TaiKhoans'
ALTER TABLE [dbo].[TaiKhoans]
ADD CONSTRAINT [FK__TaiKhoan__MaQuye__4D94879B]
    FOREIGN KEY ([MaQuyen])
    REFERENCES [dbo].[PhanQuyens]
        ([MaQuyen])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__TaiKhoan__MaQuye__4D94879B'
CREATE INDEX [IX_FK__TaiKhoan__MaQuye__4D94879B]
ON [dbo].[TaiKhoans]
    ([MaQuyen]);
GO

-- Creating foreign key on [MaChiTiet] in table 'LichSuThayDoiGias'
ALTER TABLE [dbo].[LichSuThayDoiGias]
ADD CONSTRAINT [FK__LichSuTha__MaChi__06CD04F7]
    FOREIGN KEY ([MaChiTiet])
    REFERENCES [dbo].[ChiTietSanPhams]
        ([MaChiTiet])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__LichSuTha__MaChi__06CD04F7'
CREATE INDEX [IX_FK__LichSuTha__MaChi__06CD04F7]
ON [dbo].[LichSuThayDoiGias]
    ([MaChiTiet]);
GO

-- Creating foreign key on [MaChiTiet1] in table 'LogLoiGiaoTacs'
ALTER TABLE [dbo].[LogLoiGiaoTacs]
ADD CONSTRAINT [FK__LogLoiGia__MaChi__56E8E7AB]
    FOREIGN KEY ([MaChiTiet1])
    REFERENCES [dbo].[ChiTietSanPhams]
        ([MaChiTiet])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__LogLoiGia__MaChi__56E8E7AB'
CREATE INDEX [IX_FK__LogLoiGia__MaChi__56E8E7AB]
ON [dbo].[LogLoiGiaoTacs]
    ([MaChiTiet1]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------