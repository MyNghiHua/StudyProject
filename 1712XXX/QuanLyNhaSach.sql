create database QLNhaSach
go

use QLNhaSach
go

/*---------------------------------------------- THIẾT KẾ CƠ SỞ DỮ LIỆU ------------------------------------------- */

/* Bảng TAI_KHOAN */
create table TAI_KHOAN
(
	MaTaiKhoan int not null identity(1,1),
	Email varchar(50) not null,
	MatKhau varchar(50) not null,
	LoaiTaiKhoan nvarchar(50) not null		--Nhân viên hoặc Khách hàng
	primary key (MaTaiKhoan)
)

/* Bảng KHACH_HANG */
create table KHACH_HANG
(
	MaKH int not null identity(100,1),
	TenKH nvarchar(50) not null,
	NgaySinh datetime,
	TaiKhoan_KH int not null,		-- là duy nhất để phân biệt
	GioiTinh nvarchar(3)			-- nam hoặc nữ
	primary key (MaKH)
)

/* Bảng NHAN_VIEN */
create table NHAN_VIEN
(
	MaNV int not null identity(100,1),
	TenNV nvarchar(50) not null,
	TaiKhoan_NV int not null,		-- là duy nhất để phân biệt
	SDT_NV char(10) not null
	primary key (MaNV)
)

/* Bảng THE_LOAI */
create table THE_LOAI
(
	MaLoai int not null identity(100,1),
	TenLoai nvarchar(50) not null,
	MaDM INT not null					--cho biết thể loại thuộc ở danh mục nào
	primary key (MaLoai)
)

/* Bảng DANH_MUC_SACH */
create table DANH_MUC_SACH
(
	MaDM int not null identity(100,1),
	TenDM nvarchar(50) not null
	primary key (MaDM)
)

/* Bảng TAC_GIA */
create table TAC_GIA
(
	MaTacGia int not null identity(100,1),
	TenTacGia nvarchar(50) not null,
	GioiThieu nvarchar(100)			--có thể giới thiệu 1 vài thông tin về tác giả
	primary key (MaTacGia)
)

/* Bảng SACH */
create table SACH
(
	MaSach int not null identity(100,1),
	TenSach nvarchar(50) not null,
	TacGia INT not null,
	NguoiDich nvarchar(50),
	MoTaSach nvarchar(200),
	MaDM int not null,								--cho biết thuộc ở danh mục nào
	MaLoai int not null,							--cho biết thuộc ở thể loại nào
	NXB nvarchar(50) not null,
	NhaPhatHanh nvarchar(50) not null,
	NgayPhatHanh datetime not null,
	KhoiLuong float,
	SoTrang int,
	GiaTien money not null,
	SoLuongTon int not null							--số lượng sách đang còn trong kho ở hiện tại
	primary key (MaSach)
)

/* Bảng DANH_GIA_SAN_PHAM */
create table DANH_GIA_SAN_PHAM
(
	MaSach_DanhGia int not null,					--cho biết cuốn sách đang được đánh giá
	MaKH_DanhGia int not null,						--cho biết khách hàng nào đánh giá
	NgayDanhGia datetime not null,					--cho biết ngày khách hàng đánh giá sản phẩm
	TieuDe nvarchar(50),							--tiêu đề có thể góp ý kiến (comment)
	DanhGia int not null,							--đánh giá sao từ 1 đến 5 (1 - nhỏ nhất, 5 - lớn nhất)
	NoiDung nvarchar(100)							--nội dung khách hàng góp ý (comment) cho sản phẩm
	primary key (MaSach_DanhGia,MaKH_DanhGia)
)

/* Bảng DON_HANG */
create table DON_HANG
(
	SoDonHang int not null identity(1000,1),
	MaKH_DatHang int not null,						--cho biết đơn hàng của khách nào
	NgayDatHang datetime not null,					--cho biết ngày khách hàng đặt đơn hàng
	NgayGiaoHang datetime not null,					--Phai sau thoi gian don hang it nhat 5 gio
	SDT_KH char(10) not null,
	SoNha varchar(20) not null,
	Duong nvarchar(100) not null,
	PhuongXa nvarchar(100) not null,
	QuanHuyen nvarchar(100) not null,
	TinhThanh nvarchar(100) not null,
	NVPhuTrach int not null,						--cho biết nhân viên sẽ phụ trách giao đơn hàng này
	TongTien_DonHang money not null,				-- tổng tiền của các CTDH
	SoTaiKhoan char(14),	 						--cho biết số tài khoản của khách hàng để giao dịch (khi hình thức thanh toán là bằng thẻ)
	HinhThucThanhToan int not null,					-- (0 - trực tiếp, 1 - qua thẻ)
	PhiVanChuyen money not null,					-- nếu đơn hàng >= 250k trở lên thì miễn phí, nếu < 250k thì tính phí = 30.000 cho 1 lần giao
	TrangThai int not null		-- (0 – Đã xác nhận, 1 – Đã thanh toán, 2 – Đang chuyển hàng, 3 – Giao dịch thành công, 4 - Giao dịch thất bại, Hủy đơn hàng)
	primary key (SoDonHang)
)

/* Bảng CHI_TIET_DON_HANG */
create table CHI_TIET_DON_HANG
(
	SoDH int not null,
	MaSach_CTDH int not null,				--cho biết sản phẩm khách hàng đang chọn
	SoLuong int not null,					--số lượng của sản phẩm đó là bao nhiêu
	DonGia money not null					--so luong * gia cua 1 sach
	primary key (SoDH,MaSach_CTDH)
)

/* Bảng GIO_HANG 
create table GIO_HANG
(
	MaGioHang char(5) not null,
	MaKH char(5),

	NgayTaoGioHang datetime,
	MaSach_GioHang char(5),
	SoLuong int
	primary key (MaGioHang)
) 
*/

/* Bảng PHIEU_GIAO_HANG */
create table PHIEU_GIAO_HANG
(
	SoPhieuGiaoHang int not null identity(1000,1),
	SoDH_DuocGiao int not null,								--cho biết số đơn hàng đang được giao
	TenKHNhan nvarchar(50) not null,						--cho biết tên khách hàng nhận hàng
	TongTien_PGH money not null,							--cho biết tổng sổ tiền của phiếu giao hàng (= tổng tiền từ các CTPGH)
	GhiChu nvarchar(100)									--có thể ghi chú vài thông tin nếu cần
	primary key (SoPhieuGiaoHang)
)

/* Bảng CHI_TIET_PHIEU_GIAO_HANG */
create table CHI_TIET_PHIEU_GIAO_HANG
(
	SoPGH int not null,
	MaSach_CTPGH int not null,					--cho biết chi tiết 1 sản phẩm khách hàng đã chọn và đang được giao
	SoLuongGiao int not null,					--số lượng giao	của sản phẩm đó
	DonGia money not null						--đơn giá của 1 chi tiết sản phẩm đó
	primary key (SoPGH,MaSach_CTPGH)
)

/*---------------------------------------------- CÀI ĐẶT KHÓA NGOẠI ------------------------------------------- */
go
alter table KHACH_HANG add constraint FK_KhachHang_TaiKhoan foreign key(TaiKhoan_KH) REFERENCES TAI_KHOAN(MaTaiKhoan)

alter table NHAN_VIEN add constraint FK_NhanVien_TaiKhoan foreign key(TaiKhoan_NV) REFERENCES TAI_KHOAN(MaTaiKhoan)

alter table THE_LOAI add constraint FK_TheLoai_DanhMucSach foreign key(MaDM) REFERENCES DANH_MUC_SACH(MaDM)

alter table SACH add constraint FK_Sach_DanhMucSach foreign key(MaDM) REFERENCES DANH_MUC_SACH(MaDM)
alter table SACH add constraint FK_Sach_TheLoai foreign key(MaLoai) REFERENCES THE_LOAI(MaLoai)
alter table SACH add constraint FK_Sach_TacGia foreign key(TacGia) REFERENCES TAC_GIA(MaTacGia)

alter table DANH_GIA_SAN_PHAM add constraint FK_DGSP_Sach foreign key(MaSach_DanhGia) REFERENCES SACH(MaSach)
alter table DANH_GIA_SAN_PHAM add constraint FK_DGSP_KhachHang foreign key(MaKH_DanhGia) REFERENCES KHACH_HANG(MaKH)

alter table DON_HANG add constraint FK_DonHang_KhachHang foreign key(MaKH_DatHang) REFERENCES KHACH_HANG(MaKH)
alter table DON_HANG add constraint FK_DonHang_NhanVien foreign key(NVPhuTrach) REFERENCES NHAN_VIEN(MaNV)

alter table CHI_TIET_DON_HANG add constraint FK_CTDH_DonHang foreign key(SoDH) REFERENCES DON_HANG(SoDonHang)
alter table CHI_TIET_DON_HANG add constraint FK_CTDH_Sach foreign key(MaSach_CTDH) REFERENCES SACH(MaSach)

--alter table GIO_HANG add constraint FK_GioHang_KhachHang foreign key(MaKH) REFERENCES KHACH_HANG(MaKH)
--alter table GIO_HANG add constraint FK_GioHang_Sach foreign key(MaSach_GioHang) REFERENCES SACH(MaSach)

alter table PHIEU_GIAO_HANG add constraint FK_PhieuGiaoHang_DonHang foreign key(SoDH_DuocGiao) REFERENCES DON_HANG(SoDonHang)

alter table CHI_TIET_PHIEU_GIAO_HANG add constraint FK_CTPGH_PhieuGiaoHang foreign key(SoPGH) REFERENCES PHIEU_GIAO_HANG(SoPhieuGiaoHang)
alter table CHI_TIET_PHIEU_GIAO_HANG add constraint FK_CTPGH_Sach foreign key(MaSach_CTPGH) REFERENCES SACH(MaSach)

/*************************************** NHẬP DỮ LIỆU ****************************************/
/*insert into THE_LOAI values ('ML001','Romance')
insert into THE_LOAI values ('ML002','History')
insert into THE_LOAI values ('ML003','Humor & Satire')
insert into THE_LOAI values ('ML004','Action & Adventure')
insert into THE_LOAI values ('ML005','Classics') */

insert into DANH_MUC_SACH values (N'Sách Bán Chạy')
insert into DANH_MUC_SACH values (N'Sách Mới Phát Hành')
insert into DANH_MUC_SACH values (N'Sách Ngoại Văn')
insert into DANH_MUC_SACH values (N'Sách Kinh Tế')
insert into DANH_MUC_SACH values (N'Sách Văn Học Trong Nước') 
insert into DANH_MUC_SACH values (N'Sách Văn Học Nước Ngoài') 
insert into DANH_MUC_SACH values (N'Sách Thiếu Nhi') 
insert into DANH_MUC_SACH values (N'Sách Tin Học – Ngoại Ngữ') 
insert into DANH_MUC_SACH values (N'Sách Chuyên Ngành') 
insert into DANH_MUC_SACH values (N'Sách Phát Triển Bản Thân') 

/* --- INSERT TAI_KHOAN ---*/
insert into TAI_KHOAN values ('bppkhanh@gmail.com','admin1',N'Nhân Viên')
insert into TAI_KHOAN values ('hmnghi@gmail.com','admin2',N'Nhân Viên')
insert into TAI_KHOAN values ('pdhuy@gmail.com','admin3',N'Nhân Viên')
insert into TAI_KHOAN values ('dtdung@gmail.com','client1',N'Khách Hàng')
insert into TAI_KHOAN values ('ltpnam@gmail.com','client2',N'Khách Hàng')
insert into TAI_KHOAN values ('ptdung@gmail.com','client3',N'Khách Hàng')
insert into TAI_KHOAN values ('nvan@gmail.com','client4',N'Khách Hàng')
insert into TAI_KHOAN values ('nvhiep@gmail.com','client5',N'Khách Hàng')
insert into TAI_KHOAN values ('nttien@gmail.com','client6',N'Khách Hàng')
insert into TAI_KHOAN values ('dqnhu@gmail.com','client7',N'Khách Hàng')

/* --- INSERT KHACH_HANG ---*/
insert into KHACH_HANG values (N'Đỗ Tiến Dũng','1995-09-05','4',N'Nam')
insert into KHACH_HANG values (N'Lê Trần Phương Nam','1997-01-31','5',N'Nam')
insert into KHACH_HANG values (N'Phạm Thị Dung','1998-02-27','6',N'Nữ')
insert into KHACH_HANG values (N'Nguyễn Văn An','1997-01-31','7',N'Nữ')
insert into KHACH_HANG values (N'Nguyễn Văn Hiệp','1995-05-05','8',N'Nam')
insert into KHACH_HANG values (N'Ngô Thị Tiên','1993-04-20','9',N'Nữ')
insert into KHACH_HANG values (N'Đặng Quỳnh Như','1997-10-31','10',N'Nữ')

/* --- INSERT NHAN_VIEN ---*/
insert into NHAN_VIEN values (N'Bùi Phạm Phương Khanh','1','090806767')
insert into NHAN_VIEN values (N'Hứa Mỹ Nghi','2','0353226434')
insert into NHAN_VIEN values (N'Phạm Đình Huy','3','0909155266')

/* --- INSERT THE_LOAI --- */
insert into THE_LOAI values (N'Truyện tranh','106')
insert into THE_LOAI values (N'Khoa học tự nhiên','106')
insert into THE_LOAI values (N'Khoa học xã hội','106')
insert into THE_LOAI values (,N'Ngoại ngữ','106')
insert into THE_LOAI values (N'Tiếng Anh','107')
insert into THE_LOAI values (N'Từ điển','107')
insert into THE_LOAI values (N'Tin học cơ bản','107')
insert into THE_LOAI values (N'Đồ họa','107')
insert into THE_LOAI values (N'Internet & Mạng','107')
insert into THE_LOAI values (N'Âm nhạc','108')
insert into THE_LOAI values (N'Chính trị, triết học','108')
insert into THE_LOAI values (N'Pháp luật','108')
insert into THE_LOAI values (N'Y học','108')
insert into THE_LOAI values (N'Thể thao','108')
insert into THE_LOAI values (N'Học làm người','109')
insert into THE_LOAI values (N'Nhà khoa học','109')
insert into THE_LOAI values (N'Triết gia, chính trị gia, nhà quân sự','109')
insert into THE_LOAI values (N'Danh nhân văn hóa','109')

/* --- INSERT TAC_GIA --- */
insert into TAC_GIA values (N'Ôn Thụy An','')
insert into TAC_GIA values (N'Phương Bạch Vũ','')
insert into TAC_GIA values (N'Donato Carrisi','')
insert into TAC_GIA values (N'Cornell Woolrich','')
insert into TAC_GIA values (N'Quentin Gréban','')
insert into TAC_GIA values (N'Sarah Andersen','')
insert into TAC_GIA values (N'Lee Cosgrove','')
insert into TAC_GIA values (N'Đăng Khôi','')
insert into TAC_GIA values (N'Liesbet Slegers','')
insert into TAC_GIA values (N'Thu Dương','')
insert into TAC_GIA values (,N'Linh Chi','')
insert into TAC_GIA values (N'Hackers Language Research Institue, Inc.','')
insert into TAC_GIA values (N'Khang Việt','')
insert into TAC_GIA values (N'Thái Thanh Sơn','')
insert into TAC_GIA values (N'Nguyễn Công Minh','')
insert into TAC_GIA values (N'Phạm Quang Huy','')
insert into TAC_GIA values (N'Steven Levy','')
insert into TAC_GIA values (N'Kevin Mitnick','')
insert into TAC_GIA values (N'F. Carulli','')
insert into TAC_GIA values (N'Trương Tuyết Mai','')
insert into TAC_GIA values (N'Max Tegmark','')
insert into TAC_GIA values (N'Peter Worley','')
insert into TAC_GIA values (N'Nguyễn Hữu Phước','')
insert into TAC_GIA values (N'DK','')
insert into TAC_GIA values (N'Kim Long','')
insert into TAC_GIA values (N'Nhiều tác giả','')
insert into TAC_GIA values (N'Walter Isaacson','')
insert into TAC_GIA values (N'Khánh Linh','')

/* --- INSERT SACH --- */
insert into SACH values (N'Hạn Chót Lúc Bình Minh','132',N'Lê Đình Chi','','105','119',N'NBX Văn Học',N'Phúc Minh','2019-06-10 00:00:00.000','462.00','368','98000','100')
insert into SACH values (N'Khi Mình Lớn Lên!','133',N'Cẩm Xuân','','106','120',N'NXB Tổng Hợp TPHCM',N'Trí Việt','2019-08-23 00:00:00.000','132.00','28','22000','150')
insert into SACH values (N'Khó Khăn Như Chăn Mèo','134',N'Hà Thu','','106','120',N'NXB Hội Nhà Văn',N'Nhã Nam','2019-07-17 00:00:00.000','220.00','112','55000','250')
insert into SACH values (N'Bách Khoa Thư Đầu Đời Về Khủng Long','135',N'Bảo Bình','','106','121',N'NXB Thế Giới',N'Nhã Nam','2019-06-18 00:00:00.000','682.00','30','71000','150')
insert into SACH values (N'Thế Giới Khủng Long','136',N'','','106','121',N'NXB Văn Học',N'Văn Chương','2018-09-01 00:00:00.000','352.00','64','57000','200')
insert into SACH values (N'Cuốn Sách Lớn Rực Rỡ Về Lính Cứu Hỏa','137',N'Bảo Bình','','106','122',N'NXB Hội Nhà Văn',N'Nhã Nam','2019-07-08 00:00:00.000','198.00','28','38000','100')
insert into SACH values (N'Bách Khoa Thư Đầu Đời Về Thế Giới','135',N'Bảo Bình','','106','122',N'NXB Thế Giới',N'Nhã Nam','2019-06-18 00:00:00.000','682.00','30','71000','150')
insert into SACH values (N'1000 Từ Tiếng Anh Theo Chủ Đề','138',N'','','106','123',N'NXB Mỹ Thuật',N'Tân Việt','2018-10-01 00:00:00.000','880.00','64','96000','200')
insert into SACH values (N'First 100 Trucks And Things That Go','139',N'','','106','123',N'NXB Thanh Niên',N'Đinh Tị','2017-08-01 00:00:00.000','902.00','14','120000','100')
insert into SACH values (N'Grammar Gateway Intermediate','140',N'Hồ Thị Thanh Trà','','107','124',N'NXB Thế Giới',N'Alpha books','2019-09-26 00:00:00.000','506.00','336','151000','200')
insert into SACH values (N'Hackers IELTS Listening','140',N'Nguyễn Thanh Tùng','','107','124',N'NXB Thế Giới',N'Alpha books','2019-09-03 00:00:00.000','462.00','300','143000','150')
insert into SACH values (N'Từ Điển Đồng Nghĩa Phản Nghĩa','141',N'Khang Việt','','107','125',N'NXB Từ Điển Bách Khoa',N'Khang Việt','2011-06-30 00:00:00.000','440.00','800','50000','150')
insert into SACH values (N'Từ Điển Anh - Việt (Khoảng 360.000 Từ)','141',N'Khang Việt','','107','125',N'NXB Thanh Niên',N'Khang Việt','2017-06-30 00:00:00.000','682.00','1128','84000','150')
insert into SACH values (N'Tin Học Cơ Bản Ứng Dụng Trong Đời Sống','142',N'','','107','126',N'',N'','2014-12-31 00:00:00.000','440.00','336','76500','100')
insert into SACH values (N'Microsoft Project 2007 - 2010 Cho Người Mới Sử Dụng','143',N'','','107','126',N'NXB Hồng Đức',N'Nhân Văn','2010-03-31 00:00:00.000','500.00','384','52000','100')
insert into SACH values (N'Tự Học Photoshop CC Toàn Tập','144',N'','','107','127',N'NXB Thanh Niên',N'STK','2017-09-30 00:00:00.000','506.00','384','86000','150')
insert into SACH values (N'Giáo Trình Thiết Kế Cơ Khí Với Solidworks','144',N'','','107','127',N'NXB Thanh Niên',N'STK','2019-06-30 00:00:00.000','550.00','416','112000','150')
insert into SACH values (N'Hacker Lược Sử','145',N'Phan Anh Vũ','','107','128',N'NXB Công Thương',N'Alpha books','2018-12-01 00:00:00.000','990.00','640','239000','100')
insert into SACH values (N'Nghệ Thuật Ẩn Mình','146',N'Thu Giang','','107','128',N'NXB Công Thương',N'Alpha books','2018-12-01 00:00:00.000','484.00','344','183000','100')
insert into SACH values (N'Phương Pháp Học Guitare','147',N'Trịnh Minh Thanh','','108','129',N'NXB Dân Trí',N'Huy Hoàng','2019-08-01 00:00:00.000','440.00','160','83000','100')
insert into SACH values (N'Tình Yêu Của Tôi','148',N'','','108','129',N'NXB Hội Nhà Văn',N'Trương Tuyết Mai','2014-03-01 00:00:00.000','1320.00','456','333000','100')
insert into SACH values (N'Life 3.0','149',N'Thảo Trần, Hiếu Trần','','108','130',N'NXB Thế Giới',N'Alpha books','2019-08-14 00:00:00.000','704.00','460','143000','100')
insert into SACH values (N'Cửa Hiệu Triết Học','150',N'Mai Sơn','','108','130',N'NXB Tổng Hợp TPHCM',N'Trí Việt','2019-10-09 00:00:00.000','682.00','448','158000','200')
insert into SACH values (N'Cẩm Nang Pháp Luật Cá Nhân & Gia Đình','151',N'','','108','131',N'NXB Tổng Hợp TPHCM',N'Nguyễn Hữu Phước','2018-06-01 00:00:00.000','946.00','632','224000','200')
insert into SACH values (N'Các Câu Hỏi Thường Gặp Trong Pháp Luật Lao Động','151',N'','','108','131',N'NXB Tổng Hợp TPHCM',N'Nguyễn Hữu Phước','2018-09-30 00:00:00.000','704.00','480','160000','250')
insert into SACH values (N'Cẩm Nang Sơ Cấp Cứu Thường Thức','152',N'Tổ chức Giáo dục Y khoa Wellbeing','','108','132',N'NXB Dân Trí',N'Alpha books','2019-09-26 00:00:00.000','616.00','288','239000','250')
insert into SACH values (N'How The Body Works - Hiểu Hết Về Cơ Thể','152',N'Phạm Hằng Nguyên','','108','132',N'NXB Thế Giới',N'Nhã Nam','2019-07-26 00:00:00.000','1100.00','256','240000','')
insert into SACH values (N'Karate - Kỹ Thuật Công Phá','153',N'','','108','133',N'NXB Mũi Cà Mau',N'Nhà sách Hoa Sen','2005-10-10 00:00:00.000','198.00','216','16000','50')
insert into SACH values (N'Sổ Tay Võ Thuật - Kỹ Thuật Đánh Đòn Chân','153',N'','','108','133',N'NXB Phương Đông',N'Nhà sách Hoa Sen','2007-07-01 00:00:00.000','220.00','252','24000','50')
insert into SACH values (N'Ánh Lửa Tình Bạn','154',N'','','109','134',N'NXB Tổng Hợp TPHCM',N'Trí Việt','2017-03-01 00:00:00.000','176.00','152','35000','100')
insert into SACH values (N'Buổi Sáng Diệu Kỳ Dành Cho Sinh Viên','154',N'Huệ Linh','','109','134',N'NXB Lao Động',N'Alpha books','2019-10-07 00:00:00.000','418.00','384','95000','100')
insert into SACH values (N'Stephen Hawking - Một Trí Tuệ Không Giới Hạn','154',N'Nguyễn Hữu Nhã','','109','135',N'NXB Tri Thức',N'Alpha books','2019-08-26 00:00:00.000','374.00','96','151000','150')
insert into SACH values (N'Einstein - Cuộc Đời Và Vũ Trụ','155',N'Vũ Minh Tân','','109','135',N'NXB Thế Giới',N'Alpha books','2018-07-01 00:00:00.000','1100.00','720','231000','')
insert into SACH values (N'Huyền Thoại Che - Bản Lĩnh, Tính Cách, Tình Yêu Và Sự Bất Tử','154',N'','','109','136',N'NXB Tổng Hợp TPHCM',N'Trí Việt','2014-12-18 00:00:00.000','374.00','236','65000','150')
insert into SACH values (N'Nhân Vật Số Một - Vladimir Putin','154',N'','','109','136',N'NXB Tổng Hợp TPHCM',N'Trí Việt','2015-03-01 00:00:00.000','352.00','328','48000','100')
insert into SACH values (N'Kể Chuyện Bác Hồ','156',N'','','109','137',N'NXB Lao Động',N'Tân Việt','2018-08-01 00:00:00.000','220.00','212','40000','150')
insert into SACH values (N'Hồ Chí Minh - Tên Người Sống Mãi','156',N'','','109','137',N'NXB Lao Động',N'Tân Việt','2017-12-31 00:00:00.000','242.00','260','50000','200')

/* --- INSERT DON_HANG --- */
insert into DON_HANG values ('1000','100','2019-10-10 00:00:00.000','2019-10-15 00:00:00.000','0909776899','130',N'Hoàng Hoa Thám',N'13',N'Tân Bình',N'TP.Hồ Chí Minh','1','98000','4','0','0','3')
insert into DON_HANG values ('1001','101','2019-09-09 00:00:00.000','2019-09-15 00:00:00.000','0289346213','50',N'Mạc Đĩnh Chi',N'Đa Kao',N'1',N'TP.Hồ Chí Minh','1','142000','5','0','0','1')
insert into DON_HANG values ('1002','102','2019-09-25 00:00:00.000','2019-09-30 00:00:00.000','0354881024','40',N'Cao Thắng',N'5',N'3',N'TP.Hồ Chí Minh','1','258000','6','1','30000','3')
insert into DON_HANG values ('1003','103','2019-10-20 00:00:00.000','2019-10-26 00:00:00.000','0908212811','306',N'Nguyễn Thị Minh Khai',N'5',N'3',N'TP.Hồ Chí Minh','2','790000','7','1','30000','2')
insert into DON_HANG values ('1004','104','2019-10-31 00:00:00.000','2019-10-31 00:00:00.000','0987771220','25',N'Lý Thường Kiệt',N'',N'12',N'TP.Hồ Chí Minh','2','151000','8','1','0','3',)
insert into DON_HANG values ('1005','105','2019-08-30 00:00:00.000','2019-08-07 00:00:00.000','0973310089','271',N'Ba Tháng Hai',N'10',N'10',N'TP.Hồ Chí Minh','3','224000','9','0','0','1',)
insert into DON_HANG values ('1006','106','2019-10-05 00:00:00.000','2019-10-13 00:00:00.000','0281866099','25',N'Quang Trung',N'10',N'Gò Vấp',N'TP.Hồ Chí Minh','3','55000','10','0','0','2',)

/* --- INSERT CHI_TIET_DON_HANG --- */
insert into CHI_TIET_DON_HANG values ('1000','137','1','98000')
insert into CHI_TIET_DON_HANG values ('1001','140','2','71000')
insert into CHI_TIET_DON_HANG values ('1002','152','3','86000')
insert into CHI_TIET_DON_HANG values ('1003','159','5','158000')
insert into CHI_TIET_DON_HANG values ('1004','146','1','151000')
insert into CHI_TIET_DON_HANG values ('1005','160','1','224000')
insert into CHI_TIET_DON_HANG values ('1006','139','1','55000')

/* --- INSERT PHIEU_GIAO_HANG --- */
insert into PHIEU_GIAO_HANG values ('1000','1000',N'Đỗ Tiến Dũng','98000','')
insert into PHIEU_GIAO_HANG values ('1001','1001',N'Lê Trần Phương Nam','142000','')
insert into PHIEU_GIAO_HANG values ('1002','1002',N'Phạm Thị Dung','258000','')
insert into PHIEU_GIAO_HANG values ('1003','1003',N'Nguyễn Văn An','790000','')
insert into PHIEU_GIAO_HANG values ('1004','1004',N'Nguyễn Văn Hiệp','151000','')
insert into PHIEU_GIAO_HANG values ('1005','1005',N'Ngô Thị Tiên','224000','')
insert into PHIEU_GIAO_HANG values ('1006','1006',N'Đặng Quỳnh Như','55000','')

/* --- INSERT CHI_TIET_PHIEU_GIAO_HANG --- */
insert into CHI_TIET_PHIEU_GIAO_HANG values ('1000','137','1','98000')
insert into CHI_TIET_PHIEU_GIAO_HANG values ('1001','140','2','142000')
insert into CHI_TIET_PHIEU_GIAO_HANG values ('1002','152','3','258000')
insert into CHI_TIET_PHIEU_GIAO_HANG values ('1003','159','5','790000')
insert into CHI_TIET_PHIEU_GIAO_HANG values ('1004','146','1','151000')
insert into CHI_TIET_PHIEU_GIAO_HANG values ('1005','160','1','224000')
insert into CHI_TIET_PHIEU_GIAO_HANG values ('1006','139','1','55000')

/* --- INSERT DANH_GIA_SAN_PHAM --- */
insert into DANH_GIA_SAN_PHAM values ('137','1000','2019-11-01 00:00:00.000',N'','3',N'')
insert into DANH_GIA_SAN_PHAM values ('139','1006','2019-10-25 00:00:00.000',N'','4',N'')
insert into DANH_GIA_SAN_PHAM values ('140','1001','2019-10-17 00:00:00.000',N'','4',N'')
insert into DANH_GIA_SAN_PHAM values ('146','1004','2019-11-05 00:00:00.000',N'','5',N'')
insert into DANH_GIA_SAN_PHAM values ('152','1002','2019-11-10 00:00:00.000',N'','3',N'')
insert into DANH_GIA_SAN_PHAM values ('159','1003','2019-08-20 00:00:00.000',N'','4',N'')
insert into DANH_GIA_SAN_PHAM values ('160','1005','2019-10-20 00:00:00.000',N'','5',N'')
