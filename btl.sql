create database QLDT
go
use QLDT
go
create table chucuahang
(
	ten nvarchar(50),
	sdt varchar(15) check(sdt not like '%[^0-9]%'),
	diachi nvarchar(100),
	cccd varchar(13) check(cccd not like '%[^0-9]%'),
	primary key(cccd)
)
go
create table chucuahang_quyen
(
	cccd varchar(13),
	quyen nvarchar(100) check(quyen in(N'Quản lý hóa đơn nhập',N'Quản lý hóa đơn bán',N'Quản lý hàng hóa',N'Quản lý nhân viên',N'Quản lý khách hàng',N'Quản lý hãng sản xuất')),
	primary key(cccd,quyen),
	foreign key(cccd) references chucuahang(cccd)
)
go
create table cuahang
(
	ten nvarchar(50),
	diachi nvarchar(100),
	sdt varchar(15) check(sdt not like '%[^0-9]%'),
	primary key(ten)
)
go
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
go
create table nhanvien_quyen
(
	manv varchar(10),
	quyen nvarchar(100) check(quyen in(N'Lao công',N'Nhân viên bán hàng',N'Nhân viên bảo hành',N'Lễ tân',N'Thu ngân',N'Bảo vệ',N'Nhân viên giao hàng',N'Nhân viên nhập hàng')),
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
	mahdnhap varchar(10) check(mahdnhap like 'hdnhap%'),
	ngaynhap date,
	primary key(mahdnhap)
)
go
create table hangsx
(
	mahangsx varchar(30) check(mahangsx like 'hangsx%'),
	ten nvarchar(50),
	sdt varchar(15) check(sdt not like '%[^0-9]%'),
	diachi nvarchar(100),
	primary key(mahangsx)
)
go
create table hanghoa
(
	mahang varchar(15) check(mahang like 'hanghoa%'),
	tenhang nvarchar(50),
	soluong int check(soluong>=0) not null,
	gianhap money check(gianhap>0) not null,
	giaban money check(giaban>0) not null,
	baohanh int check(baohanh=6 or baohanh=12 or baohanh=18 or baohanh=24),
	primary key(mahang),
	check(giaban>gianhap)
)
go
create table nhaphang
(
	soluong int not null,
	manv varchar(10) not null,
	mahdnhap varchar(10) not null,
	mahangsx varchar(30) not null,
	mahang varchar(15) not null,
	primary key(manv,mahdnhap,mahangsx,mahang),
	foreign key (manv) references nhanvien(manv),
	foreign key (mahdnhap) references hoadonnhap(mahdnhap),
	foreign key (mahangsx) references hangsx(mahangsx),
	foreign key (mahang) references hanghoa(mahang)
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
	cauhinh ntext,
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
	ngaynhan date not null,
	ngaytra date not null,
	noidung ntext not null,
	phibh float check(phibh>=0),
	primary key(makh,mabh),
	foreign key (makh) references khachhang(makh),
	check(ngaytra>ngaynhan)
)
go
create table danhgia
(
	PhanHoi ntext,
	diemdg int check(diemdg>=1 and diemdg<=5),
	madg varchar(15) check(madg like 'dg%'),
	mahdban varchar(10),
	primary key(madg,mahdban),
	foreign key (mahdban) references hoadonban(mahdban)
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
	foreign key (mahang) references hanghoa(mahang),
	foreign key (mahdban) references hoadonban(mahdban),
	foreign key (manv) references nhanvien(manv)
)
