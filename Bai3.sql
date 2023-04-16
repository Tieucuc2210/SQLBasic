--Sếp yêu cầu bạn thiết kế cơ sở dữ liệu quản lý lương nhân viên

--Với điều kiện:

--mã nhân viên không được phép trùng
--lương là số nguyên dương
--tên không được phép ngắn hơn 2 ký tự
--tuổi phải lớn hơn 18
--giới tính mặc định là nữ
--ngày vào làm mặc định là hôm nay
--(*) nghề nghiệp phải nằm trong danh sách ('IT','kế toán','doanh nhân thành đạt')
--tất cả các cột không được để trống
--Công ty có 5 nhân viên
--Tháng này sinh nhật sếp, sếp tăng lương cho nhân viên sinh tháng này thành 100. (*: tăng lương cho mỗi bạn thêm 100)
--Dịch dã khó khăn, cắt giảm nhân sự, cho nghỉ việc bạn nào lương dưới 50. (*: xoá cả bạn vừa thêm 100 nếu lương cũ dưới 50). (**: đuổi cả nhân viên mới vào làm dưới 2 tháng)
--Lấy ra tổng tiền mỗi tháng sếp phải trả cho nhân viên. (*: theo từng nghề)
--Lấy ra trung bình lương nhân viên. (*: theo từng nghề)
--(*) Lấy ra các bạn mới vào làm hôm nay
--(*) Lấy ra 3 bạn nhân viên cũ nhất
--(**) Tách những thông tin trên thành nhiều bảng cho dễ quản lý, lương 1 nhân viên có thể nhập nhiều lần



--list

create database nhan_vien
use nhan_vien


drop table list_nv



create table list_nv(
    ma int identity  ,
	ten nvarchar(50) not null, 
	ns date not null,
	gt bit not null,
	ngayvaolam date  default getdate() not null ,
	nghe_nghiep nvarchar(60) not null,
	luong int not null,
	primary key(ma),
	constraint check_ten check(len(ten) > 2),
	constraint check_luong check(luong >= 0) ,
	constraint check_ns check(year(getdate()) - year(ns) > 18) ,
	constraint check_nghe_nghiep check(nghe_nghiep in ('IT', 'KE TOAN' , 'DOANH NHAN THANH DAT'))
)


--Công ty có 5 nhân viên

insert into list_nv(ten , ns , gt , ngayvaolam , nghe_nghiep , luong)
values ('Nguyen Thang' , '1997-01-01' , 1 , '2023-04-14' ,'IT', 20),
('Nguyen Binh' , '2003-04-01' , 1 , '2023-04-14' ,'KE TOAN', 30),
('Nguyen Trang' , '2002-04-01' , 1 , '2023-02-14' ,'DOANH NHAN THANH DAT', 1000),
('Nguyen Xuan' , '2001-01-01' , 1 , '2023-04-14' ,'IT', 10),
('Nguyen TTHi' , '1988-01-01' , 1 , '2023-02-14' ,'IT',10)


--Tháng này sinh nhật sếp, sếp tăng lương cho nhân viên sinh tháng này thành 100. (*: tăng lương cho mỗi bạn thêm 100)

update list_nv
set luong = 100
where MONTH(ns) = MONTH(getdate())

select * from list_nv


--Dịch dã khó khăn, cắt giảm nhân sự, cho nghỉ việc bạn nào lương dưới 50. (*: xoá cả bạn vừa thêm 100 nếu lương cũ dưới 50). (**: đuổi cả nhân viên mới vào làm dưới 2 tháng)


--cho nghỉ việc bạn nào lương dưới 50
delete from list_nv
where luong < 50

--: xoá cả bạn vừa thêm 100 nếu lương cũ dưới 50
delete from list_nv
where luong < 50 + 100
and month(ns) = MONTH(getdate())


--(**: đuổi cả nhân viên mới vào làm dưới 2 tháng)

delete from list_nv
where datediff(month , ngayvaolam , GETDATE()) < 2
and ngayvaolam < getdate()

----Lấy ra tổng tiền mỗi tháng sếp phải trả cho nhân viên. (*: theo từng nghề)

select sum(luong) as luong_nhan from list_nv

select nghe_nghiep , sum(luong) as ans_tong from list_nv
group by nghe_nghiep


----(*) Lấy ra các bạn mới vào làm hôm nay

select * from list_nv
where datediff(day , ngayvaolam , getdate()) = 0

select cast(getdate() as date)


--lay ra 3 nguoi cu nhat 
select * from list_nv
order by ngayvaolam asc
OFFSET 3 ROWS --- bo qua 3 cot dau tien
FETCH NEXT 1 ROWS ONLY; -- lay cot hien tai la cot thu 4



select ten ,ns , sum(luong) as tong_cong from list_nv
group by ten , ns