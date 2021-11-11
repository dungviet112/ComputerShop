/* Câu 1: Hàm có đầu vào là MaNV đầu ra là thông tin chi tiết nhân viên*/
CREATE FUNCTION ThongTin_NV (@manv nvarchar(5))
	RETURNS TABLE
	AS
	RETURN 
		select *
		from NhanVien 
		where MaNV= @manv

select * from ThongTin_NV('NV2')

/* Câu 2: Tạo hàm có đầu vào là mã hóa đơn, đầu ra là thông tin toàn bộ hóa đơn như chi tiết hóa đơn, thành tiền */
create function ThongTinHD(@mahdb nvarchar(10))
returns table 
as return
     select MaHDB,MaMay,SoLuong,GiaBan,(SoLuong*GiaBan) as ThanhTien
     from ChiTietHDB
     where MaHDB=@mahdb

select * from ThongTinHD ('HDB1')

/* Câu 3: Tạo hàm có đầu vào là tỉnh, đầu ra là số nhân viên của tỉnh đó */
alter function QueQuan_NV (@tinh nvarchar(50))
	RETURNS TABLE
	AS
	RETURN 
		select DiaChi, COUNT(MaNV) as SoNhanVien
		from NhanVien
		where DiaChi = @tinh 
		group by DiaChi

select * from QueQuan_NV('Thanh Hoá')


/* Câu 4: Tạo hàm có đầu vào là MaKhach và MaMay, đầu ra là thời gian BH còn lại */
alter function TGBH (@makh nvarchar(50), @mamay nvarchar(50))
	RETURNS TABLE
	AS
	RETURN 
		select MaKhach, ChiTietHDB.MaMay,
		(case when (DATEDIFF(year,NgayBan,getdate())*12 + DATEDIFF(month,NgayBan,getdate())) <= ThoiGianBH 
		then ThoiGianBH - (DATEDIFF(year,NgayBan,getdate())*12 + DATEDIFF(month,NgayBan,getdate())) else 0 end )as ThoiGianBHConLai
		from HoaDonBan join ChiTietHDB on HoaDonBan.MaHDB=ChiTietHDB.MaHDB
		join COMPUTER on ChiTietHDB.MaMay=COMPUTER.MaMay
		where MaKhach=@makh and ChiTietHDB.MaMay=@mamay

select * from TGBH('KH1','MM1')

/* Câu 5: Tạo hàm có đầu vào là Nhà cung cấp, đầu ra là những máy được nhập từ NCC đó */
create function MayTu_NCC (@mancc nvarchar(50))
	RETURNS TABLE
	AS
	RETURN 
		select HoaDonNhap.MaNCC, TenNCC, ChiTietHDN.MaMay, TenMay
		from NhaCungCap join HoaDonNhap on NhaCungCap.MaNCC=HoaDonNhap.MaNCC
		join ChiTietHDN on HoaDonNhap.MaHDN=ChiTietHDN.MaHDN
		join COMPUTER on ChiTietHDN.MaMay=COMPUTER.MaMay
		where HoaDonNhap.MaNCC=@mancc 
		group by HoaDonNhap.MaNCC, TenNCC, ChiTietHDN.MaMay, TenMay
select * from MayTu_NCC('NCC1')

/* Câu 6: Tạo hàm có đầu vào là Mã Chip, đầu ra là thông tin những máy sử dụng Chip đó  */
create function MaySD_Chip (@machip nvarchar(50))
	RETURNS TABLE
	AS
	RETURN 
		select *
		from COMPUTER
		where MaChip=@machip

select * from MaySD_Chip('C1')