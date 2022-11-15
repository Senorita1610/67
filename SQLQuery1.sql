create database QLDT
use QLDT
create table chucuahang
(
	ten nvarchar(50),
	sdt varchar(15) check(sdt not like '%[^0-9]%'),
	diachi nvarchar(100),
	cccd varchar(13) check(cccd not like '%[^0-9]%'),
	primary key(cccd)
)
insert into chucuahang 
values (N'Tuấn','085314667',N'Hà Nội','038202212344'),
(N'Vũ','035614667',N'TP.Hồ Chí Minh','038202212214'),
(N'Nhung','035612667',N'TP.Hồ Chí Minh','038215212214')
select * from chucuahang


create table cuahang
(
	ten nvarchar(50),
	diachi nvarchar(100),
	sdt varchar(15) check(sdt not like '%[^0-9]%'),
	primary key(ten)
)
insert into cuahang 
values (N'Hoàng Hà mobile4',N'Hà Nội','0385288459')

select * from cuahang

create table nhanvien
(
	manv varchar(10) check(manv like 'nv%'),
	ten nvarchar(50),
	dob date,
	diachi nvarchar(100),
	sdt varchar(15) check(sdt not like '%[^0-9]%'),
	gioitinh bit check(gioitinh=1 or gioitinh=0),
	primary key(manv)
)
insert into nhanvien 
values (N'nv1',N'Lê Thị Hoa','2000-01-20',N'Hà Nội','0315988459',0),
(N'nv2',N'Lê Thị Giang','2001-02-23',N'Hà Nội','0315924559',0),
(N'nv3',N'Nguyễn Văn Tú','2002-11-20',N'TP.Hồ Chí Minh','0375188459',1),
(N'nv4',N'Phạm Việt An','2000-01-10',N'TP.Hồ Chí Minh','0515988459',1),
(N'nv5',N'Vũ Văn Đạt','2000-02-10',N'TP.Hồ Chí Minh','0515974459',1),
(N'nv6',N'Nguyễn Văn Khánh','2000-09-02',N'Hà Nội','0515988129',1)
select * from nhanvien

create table nhanvien_quyen
(
	manv varchar(10) not null,
	quyen nvarchar(100) check(quyen in(N'Lao công',N'Nhân viên bán hàng',N'Nhân viên bảo hành',N'Lễ tân',N'Thu ngân',N'Bảo vệ',N'Nhân viên giao hàng',N'Nhân viên nhập hàng')),
	primary key(manv,quyen),
	foreign key(manv) references nhanvien(manv)
)
insert into nhanvien_quyen 
values (N'nv1',N'Nhân viên bán hàng'),(N'nv2',N'Nhân viên bán hàng'),(N'nv3',N'Nhân viên nhập hàng'),(N'nv4',N'Nhân viên bán hàng'),(N'nv5',N'Nhân viên bán hàng'),(N'nv6',N'Nhân viên nhập hàng')


select * from nhanvien_quyen
create table lam
(
	manv varchar(10) not null,
	ten_cua_hang nvarchar(50) not null,
	cccd varchar(13) not null,
	primary key(manv,ten_cua_hang,cccd),
	foreign key (manv) references nhanvien(manv),
	foreign key (ten_cua_hang) references cuahang(ten),
	foreign key (cccd) references chucuahang(cccd)
)




create table hoadonnhap
(
	mahdnhap varchar(10) check(mahdnhap like 'hdnhap%'),
	ngaynhap date,
	primary key(mahdnhap)
)
go
create table hangsx
(
	mahangsx varchar(30) check(mahangsx like 'hangsx%'),
	ten_hang_san_xuat nvarchar(50),
	sdt varchar(15) check(sdt not like '%[^0-9]%'),
	diachi_hang nvarchar(100),
	primary key(mahangsx)
)
go
create table hanghoa
(
	mahanghoa varchar(15) check(mahanghoa like 'hanghoa%'),
	mahangsx varchar(30) not null,
	tenhang nvarchar(50),
	soluong int check(soluong>=0) not null,
	gianhap money check(gianhap>0) not null,
	giaban money check(giaban>0) not null,
	baohanh int check(baohanh=6 or baohanh=12 or baohanh=18 or baohanh=24),
	primary key(mahanghoa),
	foreign key (mahangsx) references hangsx(mahangsx),
	check(giaban>gianhap)
)
go
create table nhaphang
(
	soluong int not null,
	manv varchar(10) not null,
	mahdnhap varchar(10) not null,
	mahangsx varchar(30) not null,
	mahanghoa varchar(15) not null,
	primary key(manv,mahdnhap,mahangsx,mahanghoa),
	foreign key (manv) references nhanvien(manv),
	foreign key (mahdnhap) references hoadonnhap(mahdnhap),
	foreign key (mahangsx) references hangsx(mahangsx),
	foreign key (mahanghoa) references hanghoa(mahanghoa),
	check(soluong>0)
)
go
create table khachhang
(
	makh varchar(10) check(makh like 'kh%'),
	ten nvarchar(50),
	dob date,
	diachi nvarchar(100),
	sdt varchar(15) check(sdt not like '%[^0-9]%'),
	gioitinh bit,
	primary key(makh)
)
go
create table hoadonban
(
	mahdban varchar(10) check(mahdban like 'hdban%'),
	ngayban date,
	trangthai nvarchar(20) check(trangthai in(N'Bị hủy',N'Đang giao',N'Giao thành công')),
	diadiemnhan nvarchar(100),
	makh varchar(10) not null,
	primary key(mahdban),
	foreign key (makh) references khachhang(makh),
)
go
create table phukien
(
	mahhpk varchar(15) primary key,
	loai nvarchar(50) not null unique,
	foreign key (mahhpk) references hanghoa(mahanghoa)
)
go

create table dienthoai
(
	mahhdt varchar(15) primary key,
	cauhinh ntext,
	mau nvarchar(50) default N'trắng',
	foreign key (mahhdt) references hanghoa(mahanghoa)
)
go

create table spbaohanh
(
	makh varchar(10),
	mabh varchar(15),
	tensp nvarchar(50),
	ngaynhan date not null,
	ngaytra date not null,
	noidung ntext not null,
	phibh float check(phibh>=0),
	primary key(makh,mabh),
	foreign key (makh) references khachhang(makh),
	check(ngaytra>ngaynhan)
)
go
create table danh_gia_hoa_don
(
	PhanHoi ntext,
	diemdanhgia int check(diemdanhgia>=1 and diemdanhgia<=5),
	solandanhgia int not null,
	mahdban varchar(10),
	primary key(solandanhgia,mahdban),
	foreign key (mahdban) references hoadonban(mahdban),
	check(solandanhgia>0)
)
go
create table banhang
(
	SoLuong int check(SoLuong>0),
	makh varchar(10) not null,
	mahang varchar(15) not null,
	mahdban varchar(10) not null,
	manv varchar(10) not null,
	primary key(makh,mahang,mahdban,manv),
	foreign key (makh) references khachhang(makh),
	foreign key (mahang) references hanghoa(mahanghoa),
	foreign key (mahdban) references hoadonban(mahdban),
	foreign key (manv) references nhanvien(manv)
)
create table danhgiakhsp
(
	sosao int not null,
	binhluan ntext,
	makh varchar(10) not null,
	mahanghoa varchar(15) not null,
	primary key(makh,mahanghoa),
	foreign key (makh) references khachhang(makh),
	foreign key (mahanghoa) references hanghoa(mahanghoa),
	check(sosao>=1)
)