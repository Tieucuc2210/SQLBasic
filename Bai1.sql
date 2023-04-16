--Tạo bảng lưu thông tin khách hàng (mã, họ tên, số điện thoại, địa chỉ, giới tính, ngày sinh)

--Thêm 5 khách hàng
--Hiển thị chỉ họ tên và số điện thoại của tất cả khách hàng
--Cập nhật khách có mã là 2 sang tên Tuấn
--Xoá khách hàng có mã lớn hơn 3 và giới tính là Nam
--(*) Lấy ra khách hàng sinh tháng 1
---(*) Lấy ra khách hàng có họ tên trong danh sách (Anh,Minh,Đức) và giới tính Nam hoặc chỉ cần năm sinh trước 2000
--(**) Lấy ra khách hàng có tuổi lớn hơn 18
--(**) Lấy ra 3 khách hàng mới nhất
--(**) Lấy ra khách hàng có tên chứa chữ T
--(***) Thay đổi bảng sao cho chỉ nhập được ngày sinh bé hơn ngày hiện tại



create database Khach_Hang
use Khach_Hang



create table Thong_tin(
      ma int identity , -- identity ma tu dong tang
	  ho_ten nvarchar(50) not null,
	  sdt char(15) unique not null ,
	  dia_chi nvarchar(50) not null ,
	  gioi_tinh bit not null, 
	  ngay_sinh date not null,
	  primary key(ma)
)



--Thêm 5 khách hàng
insert into Thong_tin( ho_ten , sdt , dia_chi , gioi_tinh , ngay_sinh) 
values ('Nguyen Dinh Thang' , '091355000' , 'My Due - Phu Hoa' , 1 , '2003/10/22'),
('Nguyen Van Anh' , '091355001' , 'My Due2 - Phu Hoa1' , 0 , '1991/01/22'),
('Nguyen Van b' , '091355002' , 'My Due3 - Phu Hoa2' , 0 , '2000/10/22'),
('Nguyen Van Duc' , '091355003' , 'My Due4 - Phu Hoa3' , 0 , '1992/02/22'),
('Nguyen van Minh' , '091355004' , 'My Due5 - Phu Hoa4' , 1 , '1988/01/22')

SELECT * FROM Thong_tin

 --Cập nhật khách có mã là 2 sang tên Tuấn

 
 UPDATE Thong_tin
 set ho_ten = 'Nguyen Van Tuan'
 where ma = 2

 --Xoá khách hàng có mã lớn hơn 3 và giới tính là Nam

 delete from Thong_tin
 where ma > 3 and gioi_tinh = 1

 --(*) Lấy ra khách hàng sinh tháng 1

 select * from Thong_tin
 where MONTH(ngay_sinh) = 1


 ---(*) Lấy ra khách hàng có họ tên trong danh sách (Anh,Minh,Đức) và giới tính Nam hoặc chỉ cần năm sinh trước 2000

 select *  from Thong_tin
 where (ho_ten in('Anh' , 'Minh' , 'Duc') and gioi_tinh =1) or YEAR(ngay_sinh) < 2000


 --(**) Lấy ra khách hàng có tuổi lớn hơn 18

 select * from Thong_tin
 where YEAR(GETDATE()) - year(ngay_sinh) > 24

 --(**) Lấy ra 3 khách hàng mới nhất

 select top 3 * 
 from Thong_tin
 order by ma desc

 --(**) Lấy ra khách hàng có tên chứa chữ T

 select *
 from Thong_tin
 where ho_ten LIKE '%t%'


 --(***) Thay đổi bảng sao cho chỉ nhập được ngày sinh bé hơn ngày hiện tại

 --chiu