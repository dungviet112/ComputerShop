/* Câu 1: Thêm trường Thành tiền vào bảng HoaDonBan và tạo trigger điền dữ liệu cho trường này 
biết: Thành tiền = SoLuong x DonGia */
alter table HoaDonBan
add ThanhTien money
create trigger UpdateThanhTien on ChiTietHDB
for insert, update as begin 
declare @mahdb nvarchar(5), @sl int, @don_gia float
select @mahdb=MaHDB, @sl = SoLuong, @don_gia = GiaBan from inserted 
update HoaDonBan set ThanhTien = @sl * @don_gia
where MaHDB=@mahdb
end

update ChiTietHDB set SoLuong=2 where MaHDB='HDB4'
select * from HoaDonBan where MaHDB='HDB4'

/* Câu 2: Viết một trigger xóa tự động bản ghi về máy khi xóa dữ liệu máy đó trong ChiTietHDN */
create trigger XoaMay on ChiTietHDN
instead of delete 
as begin
	delete COMPUTER where MaMay = (select MaMay from deleted)
	delete ChiTietHDN where MaMay = (select MaMay from deleted)
end

delete ChiTietHDN where MaMay='MM2'
select * from ChiTietHDN
select * from COMPUTER

/* Câu 3: Viết Trigger cập nhật phần ghi chú là “Mới về ngày ...” cho máy có mã nhập vào trong bảng COMPUTER. */
alter trigger UpdateGhiChu on COMPUTER
instead of insert
as
begin
	declare @mamay nvarchar(5)
	select @mamay=MaMay from inserted
	update COMPUTER set GhiChu=N'Mới về ngày ' + cast(getdate() as char(10)) 
	where MaMay=@mamay
end

insert COMPUTER(MaMay,TenMay,MaLoai,MaChip,MaOCung,MaMH,MaChuot,MaBP,MaRam,MaLoa,MaHangSX,ThoiGianBH) 
	values ('MM6','Aorus X','PC','C1','OC1','MH1','M2','BP2','R1','L1','HSX4','24')
select * from COMPUTER

/* Câu 4: Thêm trường TriGiaHD (trị giá hóa đơn) vào bảng Hóa đơn bán. Tạo trigger cập nhật dữ liệu 
cho trường này mỗi khi thêm, sửa, xóa một chi tiết hóa đơn. */
alter table HoaDonBan
add TriGiaHD money
create trigger CapNhatTriGiaHD on ChiTietHDB
for insert, update, delete as
begin
	declare @mahdb nvarchar(5), @sl1 int, @sl2 int, @giaban1 money, @giaban2 money
	if exists (select * from inserted)
		select @mahdb = MaHDb, @sl1 = SoLuong, @giaban1 = GiaBan from inserted
	if exists (select * from deleted)
		select @mahdb = MaHDb, @sl2 = SoLuong, @giaban2 = GiaBan from deleted
	update HoaDonBan set TriGiaHD = isnull(TriGiaHD,0)+isnull(@sl1,0)*isnull(@giaban1,0)-isnull(@sl2,0)*isnull(@giaban2,0) where MaHDB = @mahdb
end

delete from ChiTietHDB where MaHDB = 'HDB1'
insert into ChiTietHDB(MaHDB,MaMay,SoLuong,GiaBan) values ('HDB1','MM5',4,40000000)
insert into ChiTietHDB(MaHDB,MaMay,SoLuong,GiaBan) values ('HDB1','MM6',2,55000000)
delete from ChiTietHDB where MaHDB = 'HDB1' and MaMay = 'MM1'
update ChiTietHDB set SoLuong = 3 where MaHDB = 'HDB1' and MaMay = 'MM1'
select * from ChiTietHDB where MaHDB = 'HDB1'
select * from HoaDonBan where MaHDB = 'HDB1'

/* Câu 5: Viết Trigger cập nhật phần ghi chú là “Số lượng có hạn” cho máy có số lượng nhập <= 2 trong ChiTietHDN. */
create trigger GhiChu_CoHan on ChiTietHDN
for insert, update
as
begin
	declare @mamay nvarchar(5), @sl int
	select @mamay=MaMay, @sl=SoLuong from inserted
	update COMPUTER set GhiChu=N'Số lượng có hạn'
	where MaMay=@mamay and @sl <= 2
end

update ChiTietHDN set SoLuong=2 where MaMay='MM1'
select * from COMPUTER

/* Câu 6: Thêm trường Tuoi vào bảng NhanVien và tạo trigger điền dữ liệu cho trường này */
alter table NhanVien
add Tuoi int
create trigger UpdateTuoi on NhanVien
for insert, update as begin 
	declare @ngaysinh date, @manv nvarchar(5)
	select @manv=MaNV, @ngaysinh=NgaySinh from inserted 
	update NhanVien set Tuoi = DATEDIFF(year,NgaySinh,getdate())
	where MaNV=@manv and NgaySinh=@ngaysinh
end
update NhanVien set GioiTinh=N'Nữ' where MaNV='NV4'
select * from NhanVien where MaNV='NV4'
