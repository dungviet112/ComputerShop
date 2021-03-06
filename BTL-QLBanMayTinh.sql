USE [QLBanMayTinh]
GO
/****** Object:  User [quanly]    Script Date: 11/8/2021 11:14:34 PM ******/
CREATE USER [quanly] FOR LOGIN [Nhom7] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [UserA]    Script Date: 11/8/2021 11:14:34 PM ******/
CREATE USER [UserA] FOR LOGIN [LoginA] WITH DEFAULT_SCHEMA=[UserA]
GO
/****** Object:  User [UserB]    Script Date: 11/8/2021 11:14:34 PM ******/
CREATE USER [UserB] FOR LOGIN [LoginB] WITH DEFAULT_SCHEMA=[UserB]
GO
/****** Object:  User [UserC]    Script Date: 11/8/2021 11:14:34 PM ******/
CREATE USER [UserC] FOR LOGIN [LoginC] WITH DEFAULT_SCHEMA=[UserC]
GO
/****** Object:  Schema [UserA]    Script Date: 11/8/2021 11:14:34 PM ******/
CREATE SCHEMA [UserA]
GO
/****** Object:  Schema [UserB]    Script Date: 11/8/2021 11:14:34 PM ******/
CREATE SCHEMA [UserB]
GO
/****** Object:  Schema [UserC]    Script Date: 11/8/2021 11:14:34 PM ******/
CREATE SCHEMA [UserC]
GO
/****** Object:  Table [dbo].[ChiTietHDB]    Script Date: 11/8/2021 11:14:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietHDB](
	[MaHDB] [nvarchar](50) NOT NULL,
	[MaMay] [nvarchar](50) NOT NULL,
	[SoLuong] [int] NULL,
	[GiaBan] [float] NULL,
 CONSTRAINT [PK_ChiTietHDB] PRIMARY KEY CLUSTERED 
(
	[MaHDB] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[COMPUTER]    Script Date: 11/8/2021 11:14:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COMPUTER](
	[MaMay] [nvarchar](50) NOT NULL,
	[TenMay] [nvarchar](50) NOT NULL,
	[MaLoai] [nvarchar](50) NOT NULL,
	[MaChip] [nvarchar](50) NOT NULL,
	[MaOCung] [nvarchar](50) NOT NULL,
	[MaMH] [nvarchar](50) NOT NULL,
	[MaChuot] [nvarchar](50) NOT NULL,
	[MaBP] [nvarchar](50) NOT NULL,
	[MaRam] [nvarchar](50) NOT NULL,
	[MaLoa] [nvarchar](50) NOT NULL,
	[MaHangSX] [nvarchar](50) NOT NULL,
	[ThoiGianBH] [nvarchar](50) NOT NULL,
	[GhiChu] [nvarchar](50) NULL,
 CONSTRAINT [PK_COMPUTER] PRIMARY KEY CLUSTERED 
(
	[MaMay] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HoaDonBan]    Script Date: 11/8/2021 11:14:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDonBan](
	[MaHDB] [nvarchar](50) NOT NULL,
	[NgayBan] [date] NULL,
	[MaNV] [nvarchar](50) NULL,
	[MaKhach] [nvarchar](50) NULL,
	[ThanhTien] [money] NULL,
	[TriGiaHD] [money] NULL,
 CONSTRAINT [PK_HoaDonBan] PRIMARY KEY CLUSTERED 
(
	[MaHDB] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[TGBH]    Script Date: 11/8/2021 11:14:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[TGBH] (@makh nvarchar(50), @mamay nvarchar(50))
	RETURNS TABLE
	AS
	RETURN 
		select MaKhach, ChiTietHDB.MaMay,
		(case when (DATEDIFF(year,NgayBan,getdate())*12 + DATEDIFF(month,NgayBan,getdate())) <= ThoiGianBH then ThoiGianBH - (DATEDIFF(year,NgayBan,getdate())*12 + DATEDIFF(month,NgayBan,getdate())) else 0 end )as ThoiGianBHConLai
		from HoaDonBan join ChiTietHDB on HoaDonBan.MaHDB=ChiTietHDB.MaHDB
		join COMPUTER on ChiTietHDB.MaMay=COMPUTER.MaMay
		where MaKhach=@makh and ChiTietHDB.MaMay=@mamay
GO
/****** Object:  Table [dbo].[ChiTietHDN]    Script Date: 11/8/2021 11:14:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietHDN](
	[MaHDN] [nvarchar](50) NOT NULL,
	[MaMay] [nvarchar](50) NOT NULL,
	[SoLuong] [int] NULL,
	[GiaNhap] [float] NULL,
 CONSTRAINT [PK_ChiTietHDN] PRIMARY KEY CLUSTERED 
(
	[MaHDN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HoaDonNhap]    Script Date: 11/8/2021 11:14:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDonNhap](
	[MaHDN] [nvarchar](50) NOT NULL,
	[NgayNhap] [date] NULL,
	[MaNV] [nvarchar](50) NULL,
	[MaNCC] [nvarchar](50) NULL,
 CONSTRAINT [PK_HoaDonNhap] PRIMARY KEY CLUSTERED 
(
	[MaHDN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhaCungCap]    Script Date: 11/8/2021 11:14:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhaCungCap](
	[MaNCC] [nvarchar](50) NOT NULL,
	[TenNCC] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](50) NULL,
	[DienThoai] [int] NULL,
 CONSTRAINT [PK_NhaCungCap] PRIMARY KEY CLUSTERED 
(
	[MaNCC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[MayTu_NCC]    Script Date: 11/8/2021 11:14:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[MayTu_NCC] (@mancc nvarchar(50))
	RETURNS TABLE
	AS
	RETURN 
		select HoaDonNhap.MaNCC, TenNCC, ChiTietHDN.MaMay, TenMay
		from NhaCungCap join HoaDonNhap on NhaCungCap.MaNCC=HoaDonNhap.MaNCC
		join ChiTietHDN on HoaDonNhap.MaHDN=ChiTietHDN.MaHDN
		join COMPUTER on ChiTietHDN.MaMay=COMPUTER.MaMay
		where HoaDonNhap.MaNCC=@mancc 
		group by HoaDonNhap.MaNCC, TenNCC, ChiTietHDN.MaMay, TenMay
GO
/****** Object:  UserDefinedFunction [dbo].[MaySD_Chip]    Script Date: 11/8/2021 11:14:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[MaySD_Chip] (@machip nvarchar(50))
	RETURNS TABLE
	AS
	RETURN 
		select *
		from COMPUTER
		where MaChip=@machip
GO
/****** Object:  View [dbo].[QUATANG]    Script Date: 11/8/2021 11:14:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[QUATANG] as
select top 1000 HoaDonBan.MaHDB,MaKhach,COMPUTER.MaMay,NgayBan,SoLuong,ChiTietHDB.GiaBan,(SoLuong*GiaBan) as ThanhTien,
(case when SoLuong >= 3 then (SoLuong*GiaBan)*0.05 else 0 end )as GiamGia,
(case when (SoLuong*ChiTietHDB.GiaBan)<10000000 then 'Khong tang ve'
when (SoLuong*GiaBan) between 10000000 and 20000000 then 'Tang 1 voucher'
when (SoLuong*GiaBan) between 20000000 and 30000000 then 'Tang 2 voucher'
when (SoLuong*GiaBan) between 30000000 and 40000000 then 'Tang 3 voucher'
when (SoLuong*GiaBan) between 40000000 and 50000000 then 'Tang 4 voucher'
when (SoLuong*GiaBan) between 50000000 and 60000000 then 'Tang 5 voucher'
when (SoLuong*GiaBan) between 60000000 and 70000000 then 'Tang 6 voucher'
when (SoLuong*GiaBan) between 70000000 and 80000000 then 'Tang 7 voucher'
when (SoLuong*GiaBan) between 80000000 and 90000000 then 'Tang 8 voucher'
when (SoLuong*GiaBan) between 90000000 and 100000000 then 'Tang 9 voucher'
when (SoLuong*GiaBan) > 100000000 then 'Tang 10 voucher'
end) as QuaTang
from HoaDonBan join ChiTietHDB on HoaDonban.MaHDB=ChiTietHDB.MaHDB
join COMPUTER on ChiTietHDB.MaMay=COMPUTER.MaMay
group by HoaDonBan.MaHDB,MaKhach,COMPUTER.MaMay,NgayBan,SoLuong,GiaBan
GO
/****** Object:  Table [dbo].[NhanVien]    Script Date: 11/8/2021 11:14:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanVien](
	[MaNV] [nvarchar](50) NOT NULL,
	[TenNV] [nvarchar](50) NULL,
	[NgaySinh] [date] NULL,
	[GioiTinh] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](50) NULL,
	[DienThoai] [int] NULL,
	[ChucVu] [nvarchar](50) NULL,
	[Tuoi] [int] NULL,
 CONSTRAINT [PK_NhanVien] PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[NV_ThanhHoa]    Script Date: 11/8/2021 11:14:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[NV_ThanhHoa] AS
select NhanVien.MaNV, TenNV, DiaChi
from NhanVien join HoaDonNhap 
on NhanVien.MaNV=HoaDonNhap.MaNV
where DiaChi=N'Thanh Hoá' and year(NgayNhap)=2021
GO
/****** Object:  View [dbo].[TOP2SPBANITNHAT]    Script Date: 11/8/2021 11:14:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[TOP2SPBANITNHAT] as
select top 2 COMPUTER.MaMay,TenMay,Count(distinct SoLuong) as [So lan ban]
from HoaDonBan join ChiTietHDB on HoaDonBan.MaHDB=ChiTietHDB.MaHDB
join COMPUTER on ChiTietHDB.MaMay=COMPUTER.MaMay
where year(NgayBan)=2021
group by COMPUTER.MaMay,TenMay
order by [So lan ban] asc
GO
/****** Object:  View [dbo].[TienLai]    Script Date: 11/8/2021 11:14:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[TienLai] AS
select COMPUTER.MaMay, (GiaBan-GiaNhap) as TienLai
from COMPUTER join ChiTietHDB on ChiTietHDB.MaMay=COMPUTER.MaMay
join ChiTietHDN on ChiTietHDN.MaMay=COMPUTER.MaMay
group by COMPUTER.MaMay, GiaBan, GiaNhap
GO
/****** Object:  View [dbo].[TopNCC]    Script Date: 11/8/2021 11:14:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[TopNCC] as
select top 1 NhaCungCap.MaNCC, TenNCC,Count(distinct SoLuong) as [So luong may nhap]
from NhaCungCap join HoaDonNhap on NhaCungCap.MaNCC=HoaDonNhap.MaNCC
join ChiTietHDN on ChiTietHDN.MaHDN=HoaDonNhap.MaHDN
where year(NgayNhap)=2021
group by NhaCungCap.MaNCC, TenNCC
order by [So luong may nhap] desc
GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 11/8/2021 11:14:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachHang](
	[MaKhach] [nvarchar](50) NOT NULL,
	[TenKhach] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](50) NULL,
	[DienThoai] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
 CONSTRAINT [PK_KhachHang] PRIMARY KEY CLUSTERED 
(
	[MaKhach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[KH_Thang10_2021]    Script Date: 11/8/2021 11:14:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[KH_Thang10_2021] AS
select KhachHang.MaKhach, TenKhach, DiaChi
from KhachHang join HoaDonBan
on KhachHang.MaKhach=HoaDonBan.MaKhach
where month(NgayBan)=10 and year(NgayBan)=2021
GO
/****** Object:  View [dbo].[DOANHTHU2021]    Script Date: 11/8/2021 11:14:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[DOANHTHU2021] as
select
isnull(sum(case month(Ngayban) when 1 then (soluong*giaban)end),0) as Thang1,
isnull(sum(case month(Ngayban) when 2 then (soluong*giaban)end),0) as Thang2,
isnull(sum(case month(Ngayban) when 3 then (soluong*giaban)end),0) as Thang3,
isnull(sum(case month(Ngayban) when 4 then (soluong*giaban)end),0) as Thang4,
isnull(sum(case month(Ngayban) when 5 then (soluong*giaban)end),0) as Thang5,
isnull(sum(case month(Ngayban) when 6 then (soluong*giaban)end),0) as Thang6,
isnull(sum(case month(Ngayban) when 7 then (soluong*giaban)end),0) as Thang7,
isnull(sum(case month(Ngayban) when 8 then (soluong*giaban)end),0) as Thang8,
isnull(sum(case month(Ngayban) when 9 then (soluong*giaban)end),0) as Thang9,
isnull(sum(case month(Ngayban) when 10 then (soluong*giaban)end),0) as Thang10,
isnull(sum(case month(Ngayban) when 11 then (soluong*giaban)end),0) as Thang11,
isnull(sum(case month(Ngayban) when 12 then (soluong*giaban)end),0) as Thang12,
isnull(sum(SoLuong*GiaBan),0) as Canam
from HoaDonBan as hd
join ChiTietHDB as ct on ct.mahdb=hd.mahdb
where year(Ngayban)=2021
GO
/****** Object:  View [dbo].[TongTienHDN]    Script Date: 11/8/2021 11:14:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[TongTienHDN] AS
select HoaDonNhap.MaHDN,sum(SoLuong*GiaNhap) as Tongtien 
from HoaDonnhap inner join ChiTietHDN 
on HoaDonNhap.MaHDN=ChiTietHDN.MaHDN
group by HoaDonNhap.MaHDN
GO
/****** Object:  View [dbo].[TongTienHDB]    Script Date: 11/8/2021 11:14:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[TongTienHDB] AS
select HoaDonBan.MaHDB,sum(SoLuong*GiaBan) as Tongtien 
from HoaDonBan inner join ChiTietHDB 
on HoaDonBan.MaHDB=ChiTietHDB.MaHDB
group by HoaDonban.MaHDB
GO
/****** Object:  UserDefinedFunction [dbo].[ThongTin_NV]    Script Date: 11/8/2021 11:14:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ThongTin_NV] (@manv nvarchar(5))
	RETURNS TABLE
	AS
	RETURN 
		select *
		from NhanVien 
		where MaNV= @manv
GO
/****** Object:  UserDefinedFunction [dbo].[QueQuan_NV]    Script Date: 11/8/2021 11:14:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[QueQuan_NV] (@tinh nvarchar(50))
	RETURNS TABLE
	AS
	RETURN 
		select DiaChi, COUNT(MaNV) as SoNhanVien
		from NhanVien
		where DiaChi = @tinh 
		group by DiaChi
GO
/****** Object:  UserDefinedFunction [dbo].[ThongTinHD]    Script Date: 11/8/2021 11:14:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[ThongTinHD](@mahdb nvarchar(10))
returns table 
as return
     select MaHDB,MaMay,SoLuong,GiaBan,(SoLuong*GiaBan) as ThanhTien
     from ChiTietHDB
     where MaHDB=@mahdb
GO
/****** Object:  Table [dbo].[BanPhim]    Script Date: 11/8/2021 11:14:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BanPhim](
	[MaBP] [nvarchar](50) NOT NULL,
	[TenBP] [nvarchar](50) NULL,
 CONSTRAINT [PK_BanPhim] PRIMARY KEY CLUSTERED 
(
	[MaBP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Chip]    Script Date: 11/8/2021 11:14:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chip](
	[MaChip] [nvarchar](50) NOT NULL,
	[TenChip] [nvarchar](50) NULL,
 CONSTRAINT [PK_Chip] PRIMARY KEY CLUSTERED 
(
	[MaChip] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Chuot]    Script Date: 11/8/2021 11:14:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chuot](
	[MaChuot] [nvarchar](50) NOT NULL,
	[TenChuot] [nvarchar](50) NULL,
 CONSTRAINT [PK_Chuot] PRIMARY KEY CLUSTERED 
(
	[MaChuot] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HangSanXuat]    Script Date: 11/8/2021 11:14:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HangSanXuat](
	[MaHangSX] [nvarchar](50) NOT NULL,
	[TenHangSX] [nvarchar](50) NULL,
 CONSTRAINT [PK_HangSanXuat] PRIMARY KEY CLUSTERED 
(
	[MaHangSX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Loa]    Script Date: 11/8/2021 11:14:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Loa](
	[MaLoa] [nvarchar](50) NOT NULL,
	[TenLoa] [nvarchar](50) NULL,
 CONSTRAINT [PK_Loa] PRIMARY KEY CLUSTERED 
(
	[MaLoa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Loai may]    Script Date: 11/8/2021 11:14:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Loai may](
	[MaLoai] [nvarchar](50) NOT NULL,
	[TenLoai] [nvarchar](50) NULL,
 CONSTRAINT [PK_Loai may] PRIMARY KEY CLUSTERED 
(
	[MaLoai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ManHinh]    Script Date: 11/8/2021 11:14:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ManHinh](
	[MaMH] [nvarchar](50) NOT NULL,
	[TenMH] [nvarchar](50) NULL,
	[CoMH] [int] NULL,
 CONSTRAINT [PK_ManHinh] PRIMARY KEY CLUSTERED 
(
	[MaMH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OCung]    Script Date: 11/8/2021 11:14:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OCung](
	[MaOCung] [nvarchar](50) NOT NULL,
	[TenOCung] [nvarchar](50) NULL,
	[DungLuong] [float] NULL,
 CONSTRAINT [PK_OCung] PRIMARY KEY CLUSTERED 
(
	[MaOCung] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RAM]    Script Date: 11/8/2021 11:14:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RAM](
	[MaRam] [nvarchar](50) NOT NULL,
	[TenRam] [nvarchar](50) NULL,
	[TocDo] [float] NULL,
	[DungLuong] [float] NULL,
 CONSTRAINT [PK_RAM] PRIMARY KEY CLUSTERED 
(
	[MaRam] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[BanPhim] ([MaBP], [TenBP]) VALUES (N'BP1', N'Akko')
INSERT [dbo].[BanPhim] ([MaBP], [TenBP]) VALUES (N'BP2', N'Edra')
INSERT [dbo].[BanPhim] ([MaBP], [TenBP]) VALUES (N'BP3', N'Fuhlen')
INSERT [dbo].[BanPhim] ([MaBP], [TenBP]) VALUES (N'BP4', N'Logiteck')
GO
INSERT [dbo].[Chip] ([MaChip], [TenChip]) VALUES (N'C1', N'Rezen1')
INSERT [dbo].[Chip] ([MaChip], [TenChip]) VALUES (N'C2', N'Rezen3')
INSERT [dbo].[Chip] ([MaChip], [TenChip]) VALUES (N'C3', N'Rezen7')
INSERT [dbo].[Chip] ([MaChip], [TenChip]) VALUES (N'C4', N'Rezen5')
INSERT [dbo].[Chip] ([MaChip], [TenChip]) VALUES (N'C5', N'Intel')
GO
INSERT [dbo].[ChiTietHDB] ([MaHDB], [MaMay], [SoLuong], [GiaBan]) VALUES (N'HDB1', N'MM5', 4, 40000000)
INSERT [dbo].[ChiTietHDB] ([MaHDB], [MaMay], [SoLuong], [GiaBan]) VALUES (N'HDB2', N'MM2', 5, 50000000)
INSERT [dbo].[ChiTietHDB] ([MaHDB], [MaMay], [SoLuong], [GiaBan]) VALUES (N'HDB3', N'MM3', 1, 100000000)
INSERT [dbo].[ChiTietHDB] ([MaHDB], [MaMay], [SoLuong], [GiaBan]) VALUES (N'HDB4', N'MM2', 2, 50000000)
INSERT [dbo].[ChiTietHDB] ([MaHDB], [MaMay], [SoLuong], [GiaBan]) VALUES (N'HDB5', N'MM4', 3, 20000000)
GO
INSERT [dbo].[ChiTietHDN] ([MaHDN], [MaMay], [SoLuong], [GiaNhap]) VALUES (N'HDN1', N'MM1', 2, 10000000)
INSERT [dbo].[ChiTietHDN] ([MaHDN], [MaMay], [SoLuong], [GiaNhap]) VALUES (N'HDN2', N'MM2', 5, 30000000)
INSERT [dbo].[ChiTietHDN] ([MaHDN], [MaMay], [SoLuong], [GiaNhap]) VALUES (N'HDN3', N'MM3', 1, 20000000)
INSERT [dbo].[ChiTietHDN] ([MaHDN], [MaMay], [SoLuong], [GiaNhap]) VALUES (N'HDN4', N'MM3', 3, 20000000)
GO
INSERT [dbo].[Chuot] ([MaChuot], [TenChuot]) VALUES (N'M1', N'Logiteck')
INSERT [dbo].[Chuot] ([MaChuot], [TenChuot]) VALUES (N'M2', N'Edra')
INSERT [dbo].[Chuot] ([MaChuot], [TenChuot]) VALUES (N'M3', N'Fuhlen')
INSERT [dbo].[Chuot] ([MaChuot], [TenChuot]) VALUES (N'M4', N'Razer')
INSERT [dbo].[Chuot] ([MaChuot], [TenChuot]) VALUES (N'M5', N'Asus')
GO
INSERT [dbo].[COMPUTER] ([MaMay], [TenMay], [MaLoai], [MaChip], [MaOCung], [MaMH], [MaChuot], [MaBP], [MaRam], [MaLoa], [MaHangSX], [ThoiGianBH], [GhiChu]) VALUES (N'MM1', N'Dell OptiPlex 5080', N'PC', N'C1', N'OC1', N'MH2', N'M2', N'BP2', N'R1', N'L1', N'HSX1', N'24', N'Số lượng có hạn')
INSERT [dbo].[COMPUTER] ([MaMay], [TenMay], [MaLoai], [MaChip], [MaOCung], [MaMH], [MaChuot], [MaBP], [MaRam], [MaLoa], [MaHangSX], [ThoiGianBH], [GhiChu]) VALUES (N'MM2', N'ROG Ultimate', N'PC', N'C2', N'OC2', N'MH1', N'M2', N'BP3', N'R2', N'L3', N'HSX2', N'12', NULL)
INSERT [dbo].[COMPUTER] ([MaMay], [TenMay], [MaLoai], [MaChip], [MaOCung], [MaMH], [MaChuot], [MaBP], [MaRam], [MaLoa], [MaHangSX], [ThoiGianBH], [GhiChu]) VALUES (N'MM3', N'TUF Elite', N'LT', N'C3', N'OC3', N'MH3', N'M3', N'BP4', N'R3', N'L2', N'HSX3', N'24', NULL)
INSERT [dbo].[COMPUTER] ([MaMay], [TenMay], [MaLoai], [MaChip], [MaOCung], [MaMH], [MaChuot], [MaBP], [MaRam], [MaLoa], [MaHangSX], [ThoiGianBH], [GhiChu]) VALUES (N'MM4', N'Acer Nitro 5', N'LT', N'C3', N'OC2', N'MH1', N'M1', N'BP1', N'R3', N'L3', N'HSX2', N'24', NULL)
INSERT [dbo].[COMPUTER] ([MaMay], [TenMay], [MaLoai], [MaChip], [MaOCung], [MaMH], [MaChuot], [MaBP], [MaRam], [MaLoa], [MaHangSX], [ThoiGianBH], [GhiChu]) VALUES (N'MM5', N'HP Legion 5', N'LT', N'C2', N'OC1', N'MH1', N'M3', N'BP2', N'R1', N'L1', N'HSX3', N'24', NULL)
INSERT [dbo].[COMPUTER] ([MaMay], [TenMay], [MaLoai], [MaChip], [MaOCung], [MaMH], [MaChuot], [MaBP], [MaRam], [MaLoa], [MaHangSX], [ThoiGianBH], [GhiChu]) VALUES (N'MM6', N'Aorus X', N'PC', N'C1', N'OC1', N'MH1', N'M2', N'BP2', N'R1', N'L1', N'HSX4', N'24', N'Mới về ngày Nov  8 202')
GO
INSERT [dbo].[HangSanXuat] ([MaHangSX], [TenHangSX]) VALUES (N'HSX1', N'Dell')
INSERT [dbo].[HangSanXuat] ([MaHangSX], [TenHangSX]) VALUES (N'HSX2', N'Asus')
INSERT [dbo].[HangSanXuat] ([MaHangSX], [TenHangSX]) VALUES (N'HSX3', N'Samsung')
INSERT [dbo].[HangSanXuat] ([MaHangSX], [TenHangSX]) VALUES (N'HSX4', N'Corsair')
GO
INSERT [dbo].[HoaDonBan] ([MaHDB], [NgayBan], [MaNV], [MaKhach], [ThanhTien], [TriGiaHD]) VALUES (N'HDB1', CAST(N'2021-10-27' AS Date), N'NV1', N'KH1', 160000000.0000, 100000000.0000)
INSERT [dbo].[HoaDonBan] ([MaHDB], [NgayBan], [MaNV], [MaKhach], [ThanhTien], [TriGiaHD]) VALUES (N'HDB2', CAST(N'2021-09-26' AS Date), N'NV4', N'KH2', NULL, NULL)
INSERT [dbo].[HoaDonBan] ([MaHDB], [NgayBan], [MaNV], [MaKhach], [ThanhTien], [TriGiaHD]) VALUES (N'HDB3', CAST(N'2021-08-25' AS Date), N'NV3', N'KH3', NULL, NULL)
INSERT [dbo].[HoaDonBan] ([MaHDB], [NgayBan], [MaNV], [MaKhach], [ThanhTien], [TriGiaHD]) VALUES (N'HDB4', CAST(N'2020-12-22' AS Date), N'NV5', N'KH2', 100000000.0000, NULL)
INSERT [dbo].[HoaDonBan] ([MaHDB], [NgayBan], [MaNV], [MaKhach], [ThanhTien], [TriGiaHD]) VALUES (N'HDB5', CAST(N'2021-02-20' AS Date), N'NV1', N'KH4', NULL, NULL)
GO
INSERT [dbo].[HoaDonNhap] ([MaHDN], [NgayNhap], [MaNV], [MaNCC]) VALUES (N'HDN1', CAST(N'2021-10-27' AS Date), N'NV2', N'NCC1')
INSERT [dbo].[HoaDonNhap] ([MaHDN], [NgayNhap], [MaNV], [MaNCC]) VALUES (N'HDN2', CAST(N'2021-10-26' AS Date), N'NV6', N'NCC1')
INSERT [dbo].[HoaDonNhap] ([MaHDN], [NgayNhap], [MaNV], [MaNCC]) VALUES (N'HDN3', CAST(N'2021-10-26' AS Date), N'NV7', N'NCC2')
INSERT [dbo].[HoaDonNhap] ([MaHDN], [NgayNhap], [MaNV], [MaNCC]) VALUES (N'HDN4', CAST(N'2021-11-01' AS Date), N'NV7', N'NCC3')
GO
INSERT [dbo].[KhachHang] ([MaKhach], [TenKhach], [DiaChi], [DienThoai], [Email]) VALUES (N'KH1', N'Bùi Sỹ Đức', N'Đông Anh', N'0678910JQK', N'duc@mail.com')
INSERT [dbo].[KhachHang] ([MaKhach], [TenKhach], [DiaChi], [DienThoai], [Email]) VALUES (N'KH2', N'Đõ Thế Khéo', N'Thanh Hoá', N'0965234852', N'kheo@mail.com')
INSERT [dbo].[KhachHang] ([MaKhach], [TenKhach], [DiaChi], [DienThoai], [Email]) VALUES (N'KH3', N'Vũ Huy Đảng', N'Bắc Ninh', N'0367965142', N'dang@mail.com')
INSERT [dbo].[KhachHang] ([MaKhach], [TenKhach], [DiaChi], [DienThoai], [Email]) VALUES (N'KH4', N'Kim Sao Quyết Chí', N'Hà Nội', N'0988668899', N'ksao@mail.com')
GO
INSERT [dbo].[Loa] ([MaLoa], [TenLoa]) VALUES (N'L1', N'Mashall')
INSERT [dbo].[Loa] ([MaLoa], [TenLoa]) VALUES (N'L2', N'Razer')
INSERT [dbo].[Loa] ([MaLoa], [TenLoa]) VALUES (N'L3', N'JBL')
INSERT [dbo].[Loa] ([MaLoa], [TenLoa]) VALUES (N'L4', N'Bose')
GO
INSERT [dbo].[Loai may] ([MaLoai], [TenLoai]) VALUES (N'LT', N'Laptop')
INSERT [dbo].[Loai may] ([MaLoai], [TenLoai]) VALUES (N'PC', N'Mayban')
GO
INSERT [dbo].[ManHinh] ([MaMH], [TenMH], [CoMH]) VALUES (N'MH1', N'Asus', 32)
INSERT [dbo].[ManHinh] ([MaMH], [TenMH], [CoMH]) VALUES (N'MH2', N'SamSung', 21)
INSERT [dbo].[ManHinh] ([MaMH], [TenMH], [CoMH]) VALUES (N'MH3', N'Dell', 27)
INSERT [dbo].[ManHinh] ([MaMH], [TenMH], [CoMH]) VALUES (N'MH4', N'Corsair', 24)
GO
INSERT [dbo].[NhaCungCap] ([MaNCC], [TenNCC], [DiaChi], [DienThoai]) VALUES (N'NCC1', N'Dell VN', N'Đống Đa, Hà Nội', 976425270)
INSERT [dbo].[NhaCungCap] ([MaNCC], [TenNCC], [DiaChi], [DienThoai]) VALUES (N'NCC2', N'Asus Vn', N'Sầm Sơn, Thanh Hóa', 123456789)
INSERT [dbo].[NhaCungCap] ([MaNCC], [TenNCC], [DiaChi], [DienThoai]) VALUES (N'NCC3', N'Corsair', N'Đông Anh, Hà Nội', 102345678)
GO
INSERT [dbo].[NhanVien] ([MaNV], [TenNV], [NgaySinh], [GioiTinh], [DiaChi], [DienThoai], [ChucVu], [Tuoi]) VALUES (N'NV1', N'Hà Văn Tuấn', CAST(N'2001-01-01' AS Date), N'Nam', N'Thanh Hoá', 1234567836, N'Nhân viên bán hàng', 20)
INSERT [dbo].[NhanVien] ([MaNV], [TenNV], [NgaySinh], [GioiTinh], [DiaChi], [DienThoai], [ChucVu], [Tuoi]) VALUES (N'NV2', N'Nguyễn Viết Dũng', CAST(N'2001-03-06' AS Date), N'Nữ', N'Sài Gòn', 1023123456, N'Nhân viên kho', 20)
INSERT [dbo].[NhanVien] ([MaNV], [TenNV], [NgaySinh], [GioiTinh], [DiaChi], [DienThoai], [ChucVu], [Tuoi]) VALUES (N'NV3', N'Đỗ Phúc Đại', CAST(N'2001-02-02' AS Date), N'Nam', N'Thanh Hoá', 1002312312, N'Nhân viên bán hàng', 20)
INSERT [dbo].[NhanVien] ([MaNV], [TenNV], [NgaySinh], [GioiTinh], [DiaChi], [DienThoai], [ChucVu], [Tuoi]) VALUES (N'NV4', N'Nguyễn Đăng Tú', CAST(N'2001-06-06' AS Date), N'Nữ', N'Thanh Hoá', 934561246, N'Nhân viên bán hàng', 20)
INSERT [dbo].[NhanVien] ([MaNV], [TenNV], [NgaySinh], [GioiTinh], [DiaChi], [DienThoai], [ChucVu], [Tuoi]) VALUES (N'NV5', N'Đỗ Duy Khoa', CAST(N'2000-12-06' AS Date), N'Nam', N'Quảng Ninh', 856736855, N'Nhân viên bán hàng', 21)
INSERT [dbo].[NhanVien] ([MaNV], [TenNV], [NgaySinh], [GioiTinh], [DiaChi], [DienThoai], [ChucVu], [Tuoi]) VALUES (N'NV6', N'Nguyễn Mạnh Cường', CAST(N'2001-08-08' AS Date), N'Nam', N'Thanh Hoá', 864123842, N'Nhân viên kho', 20)
INSERT [dbo].[NhanVien] ([MaNV], [TenNV], [NgaySinh], [GioiTinh], [DiaChi], [DienThoai], [ChucVu], [Tuoi]) VALUES (N'NV7', N'Cristiano Ronaldo', CAST(N'1999-01-01' AS Date), N'Nam', N'Đà Nẵng', 966887799, N'Nhân viên kho', 22)
GO
INSERT [dbo].[OCung] ([MaOCung], [TenOCung], [DungLuong]) VALUES (N'OC1', N'Samsung', 512)
INSERT [dbo].[OCung] ([MaOCung], [TenOCung], [DungLuong]) VALUES (N'OC2', N'Sandisk', 1024)
INSERT [dbo].[OCung] ([MaOCung], [TenOCung], [DungLuong]) VALUES (N'OC3', N'Kington', 2048)
INSERT [dbo].[OCung] ([MaOCung], [TenOCung], [DungLuong]) VALUES (N'OC4', N'Asus', 512)
GO
INSERT [dbo].[RAM] ([MaRam], [TenRam], [TocDo], [DungLuong]) VALUES (N'R1', N'Kingston', 3200, NULL)
INSERT [dbo].[RAM] ([MaRam], [TenRam], [TocDo], [DungLuong]) VALUES (N'R2', N'HyperX', 2666, NULL)
INSERT [dbo].[RAM] ([MaRam], [TenRam], [TocDo], [DungLuong]) VALUES (N'R3', N'Fury', 2666, NULL)
INSERT [dbo].[RAM] ([MaRam], [TenRam], [TocDo], [DungLuong]) VALUES (N'R4', N'Corsair', 4888, NULL)
GO
ALTER TABLE [dbo].[ChiTietHDB]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietHDB_HoaDonBan] FOREIGN KEY([MaHDB])
REFERENCES [dbo].[HoaDonBan] ([MaHDB])
GO
ALTER TABLE [dbo].[ChiTietHDB] CHECK CONSTRAINT [FK_ChiTietHDB_HoaDonBan]
GO
ALTER TABLE [dbo].[ChiTietHDN]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietHDN_HoaDonNhap] FOREIGN KEY([MaHDN])
REFERENCES [dbo].[HoaDonNhap] ([MaHDN])
GO
ALTER TABLE [dbo].[ChiTietHDN] CHECK CONSTRAINT [FK_ChiTietHDN_HoaDonNhap]
GO
ALTER TABLE [dbo].[HoaDonBan]  WITH CHECK ADD  CONSTRAINT [FK_HoaDonBan_NhanVien] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[HoaDonBan] CHECK CONSTRAINT [FK_HoaDonBan_NhanVien]
GO
ALTER TABLE [dbo].[HoaDonNhap]  WITH CHECK ADD  CONSTRAINT [FK_HoaDonNhap_NhaCungCap] FOREIGN KEY([MaNCC])
REFERENCES [dbo].[NhaCungCap] ([MaNCC])
GO
ALTER TABLE [dbo].[HoaDonNhap] CHECK CONSTRAINT [FK_HoaDonNhap_NhaCungCap]
GO
/****** Object:  StoredProcedure [dbo].[DoanhThu_Ngay]    Script Date: 11/8/2021 11:14:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[DoanhThu_Ngay] @ngay datetime
as begin
	select COUNT(HoaDonBan.MaHDB) as SoHoaDon,SUM(SoLuong*GiaBan) as DoanhThu 
	from ChiTietHDB join HoaDonBan on ChiTietHDB.MaHDB=HoaDonBan.MaHDB
	where NgayBan=@ngay
end
GO
/****** Object:  StoredProcedure [dbo].[SoHoaDon]    Script Date: 11/8/2021 11:14:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SoHoaDon] @mahdb nvarchar(10)
as begin
select Sum(SoLuong*GiaBan) as TienThanhToan 
from ChiTietHDB
where MaHDB=@mahdb
end
GO
/****** Object:  StoredProcedure [dbo].[TinhTuoi]    Script Date: 11/8/2021 11:14:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[TinhTuoi] @manv nvarchar(3), @t int output
as
begin
select Tuoi = DATEDIFF(year,NgaySinh,getdate()) from NhanVien where @manv = MaNV
end
GO
/****** Object:  StoredProcedure [dbo].[TongHDDT]    Script Date: 11/8/2021 11:14:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[TongHDDT] @nam int, @manv nvarchar(50), @sohdb int output, @doanhthu int output
as
begin
select @sohdb = count(distinct hd.MaHDB), @doanhthu = sum(SoLuong*GiaBan)
from HoaDonBan hd join ChiTietHDB cthd on hd.MaHDB=cthd.MaHDB
join COMPUTER on cthd.MaMay=COMPUTER.MaMay
where @manv = MaNV and @nam = year(NgayBan)
end
GO
/****** Object:  StoredProcedure [dbo].[TongNhap]    Script Date: 11/8/2021 11:14:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[TongNhap] @mamay nvarchar(5)
as
begin
select MaMay, sum(SoLuong) as TongSLNhap,sum(SoLuong*GiaNhap) as TongTienNhap from ChiTietHDN where @mamay = MaMay
group by MaMay
end
GO
/****** Object:  StoredProcedure [dbo].[XoaHD]    Script Date: 11/8/2021 11:14:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[XoaHD]
as
begin
delete from HoaDonBan where MaHDB not in (select distinct MaHDB from ChiTietHDB)
end
GO
