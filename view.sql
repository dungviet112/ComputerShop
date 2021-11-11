/*Câu 1: Tính doanh thu năm 2021*/
create view DOANHTHU2021 as
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
select * from DOANHTHU2021

/*Câu 2: Tính tổng tiền cho từng hóa đơn nhập*/
CREATE VIEW TongTienHDN AS
select HoaDonNhap.MaHDN,sum(SoLuong*GiaNhap) as Tongtien 
from HoaDonnhap inner join ChiTietHDN 
on HoaDonNhap.MaHDN=ChiTietHDN.MaHDN
group by HoaDonNhap.MaHDN
select * from TongTienHDN

/*Câu 3: Tính tổng tiền cho từng hóa đơn bán*/
CREATE VIEW TongTienHDB AS
select HoaDonBan.MaHDB,sum(SoLuong*GiaBan) as Tongtien 
from HoaDonBan inner join ChiTietHDB 
on HoaDonBan.MaHDB=ChiTietHDB.MaHDB
group by HoaDonBan.MaHDB
select * from TongTienHDB

/*Câu 4: Tạo view QUATANG gồm có các field sau:
MaHD, MaKH, NgayBan, MaMay, Soluong, Giaban, ThanhTien, Giamgia, Quatang.
Trong đó: Thành tiền là Số lượng nhân giá bán. Giảm giá là 5% của Thành Tiền nếu số lượng >= 3 . Quà tặng
được tính như sau: nếu thành tiền ít hơn 10000000 thì không được voucher nào, từ 10000000 đến < 20000000 được
1 voucher, từ 20000000 đến < 30000000 được 2 voucher, v.v… (ví dụ: nếu thànhtiền = 40000000 thì
Quà tặng là 4 voucher). Sắp xếp theo MaHD theo thứ tự tăng dần.*/
create view QUATANG as
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

select * from QUATANG

/*Câu 5: Tạo view những nhân viên có địa chỉ là Thanh Hoá nhập hàng năm 2021*/
CREATE VIEW NV_ThanhHoa AS
select NhanVien.MaNV, TenNV, DiaChi
from NhanVien join HoaDonNhap 
on NhanVien.MaNV=HoaDonNhap.MaNV
where DiaChi=N'Thanh Hoá' and year(NgayNhap)=2021
select * from NV_ThanhHoa

/*Câu 6: tạo view 2 sản phẩm đực bán ít nhất năm 2021*/
create view TOP2SPBANITNHAT as
select top 2 COMPUTER.MaMay,TenMay,Count(distinct SoLuong) as [So lan ban]
from HoaDonBan join ChiTietHDB on HoaDonBan.MaHDB=ChiTietHDB.MaHDB
join COMPUTER on ChiTietHDB.MaMay=COMPUTER.MaMay
where year(NgayBan)=2021
group by COMPUTER.MaMay,TenMay
order by [So lan ban] asc

select * from TOP2SPBANITNHAT

/*Câu 7: Tính tiền lãi của từng loại máy bán được (Lãi = Giá bán - giá nhập)*/
CREATE VIEW TienLai AS
select COMPUTER.MaMay, (GiaBan-GiaNhap) as TienLai
from COMPUTER join ChiTietHDB on ChiTietHDB.MaMay=COMPUTER.MaMay
join ChiTietHDN on ChiTietHDN.MaMay=COMPUTER.MaMay
group by COMPUTER.MaMay, GiaBan, GiaNhap
select * from TienLai

/*Câu 8: Tạo View nhà cung cấp nhiều máy nhất cho cửa hàng năm 2021 */
create view TopNCC as
select top 1 NhaCungCap.MaNCC, TenNCC,Count(distinct SoLuong) as [So luong may nhap]
from NhaCungCap join HoaDonNhap on NhaCungCap.MaNCC=HoaDonNhap.MaNCC
join ChiTietHDN on ChiTietHDN.MaHDN=HoaDonNhap.MaHDN
where year(NgayNhap)=2021
group by NhaCungCap.MaNCC, TenNCC
order by [So luong may nhap] desc

select * from TopNCC

/*Câu 9: Tạo View những khách hàng mua hàng trong tháng 10 năm 2021*/
CREATE VIEW KH_Thang10_2021 AS
select KhachHang.MaKhach, TenKhach, DiaChi
from KhachHang join HoaDonBan
on KhachHang.MaKhach=HoaDonBan.MaKhach
where month(NgayBan)=10 and year(NgayBan)=2021

select * from KH_Thang10_2021