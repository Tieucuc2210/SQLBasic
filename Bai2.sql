--Tạo bảng lưu thông tin điểm của sinh viên (mã, họ tên, điểm lần 1, điểm lần 2)

--Với điều kiện:

--điểm không được phép nhỏ hơn 0 và lớn hơn 10
--điểm lần 1 nếu không nhập mặc định sẽ là 5
--(*) điểm lần 2 không được nhập khi mà điểm lần 1 lớn hơn hoặc bằng 5
--(**) tên không được phép ngắn hơn 2 ký tự
--Điền 5 sinh viên kèm điểm
--Lấy ra các bạn điểm lần 1 hoặc lần 2 lớn hơn 5
--Lấy ra các bạn qua môn ngay từ lần 1
--Lấy ra các bạn trượt môn
--(-*) Đếm số bạn qua môn sau khi thi lần 2
--(**) Đếm số bạn cần phải thi lần 2 (tức là thi lần 1 chưa qua nhưng chưa nhập điểm lần 2)


create database Sinh_vien
use Sinh_vien
drop table person

create table person(
     ma int identity,
	 ho_name varchar(50) not null ,
	 diem1 float default 5,  --điểm lần 1 nếu không nhập mặc định sẽ là 5
	 diem2 float ,
	 primary key(ma),
	 --điểm không được phép nhỏ hơn 0 và lớn hơn 10
	 constraint check_gioi_han1 check(diem1 >= 0 and diem1 <= 10 and diem2 >= 0 and diem2 <= 10)
)

--Điền 5 sinh viên kèm điểm
insert into person(ho_name , diem1 , diem2)
values('Thang' , 7 ,7),
('Khuong' , 9 ,4),
('Bao' , 1, null),
('Bao' , 1 ,null),
('Kim' , 3 ,2),
('Anh' , 9 ,9)

select * from person


--(*) điểm lần 2 không được nhập khi mà điểm lần 1 lớn hơn hoặc bằng 5

alter table person
add constraint check_diem_lan2 check((diem1 >= 5 and diem2 is null) or diem1 < 5)


--(**) tên không được phép ngắn hơn 2 ký tự

alter table person
add constraint check_ten check(len(name) < 2) 


--Lấy ra các bạn điểm lần 1 hoặc lần 2 lớn hơn 5

select * from person
where diem1 > 5 or diem2 > 5

--Lấy ra các bạn qua môn ngay từ lần 1

select * from person
where diem1 >= 5

--Lấy ra các bạn trượt môn

select * from person
where diem1 < 5 and diem2 < 5

--(-*) Đếm số bạn qua môn sau khi thi lần 2
select * from person
where diem2 is not null

--(**) Đếm số bạn cần phải thi lần 2 (tức là thi lần 1 chưa qua nhưng chưa nhập điểm lần 2)

select count(diem2) from person
where diem2 is not null


select * from person
select sum(diem1) as tong_diem_lan1 from person
select avg(diem1) as diem_tb from person
select count(diem1) as dem_so_ban from person


--dem co bao nhieu ban trung ten 

select * from person
select distinct ho_name as ho_ten_bi_trung_loc from person
select count(distinct ho_name) as dem_so_luong from person