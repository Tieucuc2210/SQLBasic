﻿--Ban lãnh đạo thành phố yêu cầu bạn tạo bảng lưu các con vật trong sở thú

--Với điều kiện tự bạn quy ước (hãy áp dụng check và default)

--Sở thú hiện có 7 con
--Thống kê có bao nhiêu con 4 chân
--Thống kê số con tương ứng với số chân
--Thống kê số con theo môi trường sống
--Thống kê tuổi thọ trung bình theo môi trường sống
--Lấy ra 3 con có tuổi thọ thọ cao nhất
--(*) Tách những thông tin trên thành 2 bảng cho dễ quản lý (1 môi trường sống gồm nhiều con)

create database animar
use animar


create table moi_truong_song(
ma int identity,
ten nvarchar(50) not null unique,
primary key(ma)
)
insert into moi_truong_song(ten)
values (N'trong nhà123'),(N'ngoài trời2323')

delete from moi_truong_song

select * from moi_truong_song

create table dong_vat(
ma int identity,
ten nvarchar(50) not null unique,
so_chan int default 0 not null,
tuoi_tho int not null,
ma_moi_truong_song int not null,
constraint CK_ten check(len(ten) > 2),
constraint CK_so_chan check(so_chan >= 0 and so_chan < 100 and so_chan % 2 = 0),
constraint CK_tuoi_tho check(tuoi_tho > 0),
foreign key (ma_moi_truong_song) references moi_truong_song(ma),
primary key(ma)
)

insert into dong_vat(ten,so_chan,tuoi_tho,ma_moi_truong_song)
values (N'cún',4,20,3),(N'mèo',4,9,3),(N'cá cược',default,10,4)

select 
dong_vat.ma,
dong_vat.ten,
dong_vat.so_chan,
dong_vat.tuoi_tho,
moi_truong_song.ten as ten_moi_truong_song
from dong_vat
join moi_truong_song 
on moi_truong_song.ma = dong_vat.ma_moi_truong_song