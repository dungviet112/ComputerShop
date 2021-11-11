/* Câu 1: Tạo thủ tục có đầu vào là số hóa đơn, đầu ra là số tiền cần thanh toán */
create procedure SoHoaDon @mahdb nvarchar(10)
as begin
select Sum(SoLuong*GiaBan) as TienThanhToan 
from ChiTietHDB
where MaHDB=@mahdb
end
exec SoHoaDon 'HDB2'

/* Câu 2: Tạo thủ tục xóa các hóa đơn mà không có chi tiết hóa đơn */
create procedure XoaHD
as
begin
delete from HoaDonBan where MaHDB not in (select distinct MaHDB from ChiTietHDB)
delete from HoaDonNhap where MaHDN not in (select distinct MaHDN from ChiTietHDN)
end

exec XoaHD

/* Câu 3: Tạo thủ tục với đầu vào là ngày, đầu ra là số lượng hóa đơn, doanh thu của ngày đó */
create procedure DoanhThu_Ngay @ngay datetime
as begin
	select COUNT(HoaDonBan.MaHDB) as SoHoaDon, SUM(SoLuong*GiaBan) as DoanhThu 
	from ChiTietHDB join HoaDonBan on ChiTietHDB.MaHDB=HoaDonBan.MaHDB
	where NgayBan=@ngay
end
exec DoanhThu_Ngay '2021-02-20'

/* Câu 4: Cho biết tổng số hóa đơn đã lập và tổng doanh thu đã bán hàng của một nhân viên trong một năm nào đó dựa vào mã nhân viên */
create procedure TongHDDT @nam int, @manv nvarchar(50), @sohdb int output, @doanhthu int output
as
begin
select @sohdb = count(distinct hd.MaHDB), @doanhthu = sum(SoLuong*GiaBan)
from HoaDonBan hd join ChiTietHDB cthd on hd.MaHDB=cthd.MaHDB
join COMPUTER on cthd.MaMay=COMPUTER.MaMay
where @manv = MaNV and @nam = year(NgayBan)
end

declare @t int, @dt int
exec TongHDDT '2021', 'NV4', @t output, @dt output
print @t
print @dt

/* Câu 5: Thêm trường Tuổi vào bảng nhân viên. Tạo thủ tục tính tuổi cho nhân viên và cập nhật vào trường Tuổi. */
alter table NhanVien
add Tuoi int
create procedure TinhTuoi @manv nvarchar(3), @t int output
as
begin
select Tuoi = DATEDIFF(year,NgaySinh,getdate()) from NhanVien where @manv = MaNV
end

declare @h int
exec TinhTuoi 'NV5',@h output

/* Câu 6: Tính tổng số lượng và tổng số tiền đã nhập của từng máy */
create procedure TongNhap @mamay nvarchar(5)
as
begin
select MaMay, sum(SoLuong) as TongSLNhap,sum(SoLuong*GiaNhap) as TongTienNhap from ChiTietHDN where @mamay = MaMay
group by MaMay
end

exec TongNhap 'MM3'
