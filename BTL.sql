create database QLDT
go
use QLDT
go
create table chucuahang
(
	ten nvarchar(50),
	sdt varchar(15),
	diachi nvarchar(100),
	cccd varchar(13),
	primary key(cccd)
)
go
create table chucuahang_quyen
(
	cccd varchar(13),
	quyen nvarchar(100),
	primary key(cccd,quyen),
	foreign key(cccd) references chucuahang(cccd)
)
go
create table cuahang
(
	ten nvarchar(50),
	diachi nvarchar(100),
	sdt varchar(15),
	primary key(ten)
)
go
create table nhanvien
(
	manv varchar(10),
	ten nvarchar(50),
	dob date,
	diachi nvarchar(100),
	sdt varchar(15),
	gioitinh bit,
	primary key(manv)
)
go
create table nhanvien_quyen
(
	manv varchar(10),
	quyen nvarchar(100),
	primary key(manv,quyen),
	foreign key(manv) references nhanvien(manv)
)
go
create table lam
(
	manv varchar(10) not null,
	ten nvarchar(50) not null,
	cccd varchar(13) not null,
	primary key(manv,ten,cccd),
	foreign key (manv) references nhanvien(manv),
	foreign key (ten) references cuahang(ten),
	foreign key (cccd) references chucuahang(cccd)
)
go
create table hoadonnhap
(
	mahdnhap varchar(10),
	ngaynhap date,
	primary key(mahdnhap)
)
go
create table hangsx
(
	mahangsx varchar(30),
	ten nvarchar(50),
	sdt varchar(15),
	diachi nvarchar(100),
	primary key(mahangsx)
)
go
create table hanghoa
(
	mahang varchar(15),
	tenhang nvarchar(50),
	soluong int,
	gianhap float,
	giaban float,
	baohanh int,
	primary key(mahang)
)
go
create table nhaphang
(
	soluong int not null,
	manv varchar(10) not null,
	mahdnhap varchar(10) not null,
	mahangsx varchar(30) not null,
	primary key(manv,mahdnhap,mahangsx),
	foreign key (manv) references nhanvien(manv),
	foreign key (mahdnhap) references hoadonnhap(mahdnhap),
	foreign key (mahangsx) references hangsx(mahangsx)
)
go
create table khachhang
(
	makh varchar(10),
	ten nvarchar(50),
	dob date,
	diachi nvarchar(100),
	sdt varchar(15),
	gioitinh bit,
	primary key(makh)
)
go
create table hoadonban
(
	mahdban varchar(10),
	ngayban date,
	diadiemnhan nvarchar(100),
	primary key(mahdban)
)
go
create table phukien
(
	mahhpk varchar(15) primary key,
	foreign key (mahhpk) references hanghoa(mahang)
)
go
create table phukien_loai
(
	mahhpk varchar(15),
	loai nvarchar(100),
	primary key(mahhpk,loai),
	foreign key(mahhpk) references phukien(mahhpk)
)
go
create table dienthoai
(
	mahhdt varchar(15) primary key,
	cauhinh nvarchar(50),
	foreign key (mahhdt) references hanghoa(mahang)
)
go
create table dienthoai_mausac
(
	mahhdt varchar(15),
	mausac nvarchar(50),
	primary key(mahhdt,mausac),
	foreign key(mahhdt) references dienthoai(mahhdt)
)
go
create table spbaohanh
(
	makh varchar(10),
	mabh varchar(15),
	tensp nvarchar(50),
	ngaynhan date,
	ngaytra date,
	noidung ntext not null,
	phibh float,
	primary key(makh,mabh),
	foreign key (makh) references khachhang(makh)
)
go
create table danhgia
(
	noidung ntext,
	diemdg int,
	madg varchar(15),
	mahdban varchar(10),
	primary key(madg,mahdban),
	foreign key (mahdban) references hoadonban(mahdban)
)
go
