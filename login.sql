/* Kịch bản 1: 
A: Người quản lý 
Tạo login A 
Tạo userA
Gán mọi quyền cho userA trên bảng COMPUTER,HoaDonBan,HoaDOnNhap,ChiTietHDB,ChiTietHDN trong CSDL
Đăng nhập A để kiểm tra */
exec sp_addlogin LoginA,123,QLBanMayTinh
exec sp_adduser LoginA,UserA

grant all on COMPUTER to UserA with grant option
grant all on HoaDonBan to UserA with grant option
grant all on HoaDonNhap to UserA with grant option
grant all on ChiTietHDB to UserA with grant option
grant all on ChiTietHDN to UserA with grant option

/* Kịch bản 2: 
B: nhân viên bán hàng 
Tạo login B 
Tạo userB
Gán quyền select, update, insert, delete cho userB trên bảng HoaDonBan,ChiTietHDB,KhachHang trong CSDL
Đăng nhập B để kiểm tra */
exec sp_addlogin LoginB,123,QLBanMayTinh
exec sp_adduser LoginB,UserB

grant select, update, insert, delete on HoaDonBan to UserB with grant option
grant select, update, insert, delete on ChiTietHDB to UserB with grant option
grant select, update, insert, delete on KhachHang to UserB with grant option

/* Kịch bản 3: 
C: nhân viên kho
Tạo login C 
Tạo userC
Gán quyền select, update, insert, delete cho userB trên bảng HoaDonNhap,ChiTietHDN,NhaCungCap trong CSDL
Đăng nhập C để kiểm tra */
exec sp_addlogin LoginC,123,QLBanMayTinh
exec sp_adduser LoginC,UserC

grant select, update, insert, delete on HoaDonNhap to UserC with grant option
grant select, update, insert, delete on ChiTietHDN to UserC with grant option
grant select, update, insert, delete on NhaCungCap to UserC with grant option
