/*
use master
go
drop database clinic
*/
/*
create database clinic
go
use clinic
go
*/

--function tu tao id 

create function autoid(@NAME Char(2), @QUAN int)
returns VARCHAR(10)
as 
begin
	declare @ID VARCHAR(10)
	SELECT @ID = @NAME + RIGHT(REPLICATE(0,8), 8 - LEN(CAST (@QUAN AS VARCHAR(8)))) +  CAST(@QUAN AS VARCHAR(8))
	RETURN @ID
END
GO

CREATE TABLE Account
(
  id VARCHAR(10) NOT NULL,
  username VARCHAR(50) NOT NULL,
  password VARCHAR(50) NOT NULL,
  meta VARCHAR(MAX) NOT NULL,
  hide BIT NOT NULL DEFAULT 0,
  [order] INT NOT NULL IDENTITY(1,1),
  datebegin DATETIME NOT NULL,
  able BIT NOT NULL DEFAULT 1,
  PRIMARY KEY (id),
  UNIQUE (username)
);

CREATE TABLE Person
(
  meta VARCHAR(MAX) NOT NULL,
  hide BIT NOT NULL DEFAULT 0,
  [order] INT NOT NULL IDENTITY(1,1),
  datebegin DATETIME NOT NULL,
  name NVARCHAR(100) NOT NULL,
  phoneNumber VARCHAR(10) NOT NULL,
  email VARCHAR(100) NOT NULL,
  salary INT NOT NULL check(salary>= 0),
  address NVARCHAR(MAX) NOT NULL,
  gender BIT NOT NULL,
  birthday DATETIME NOT NULL,
  nation NVARCHAR(MAX) NOT NULL,
  role INT NOT NULL,
  img VARCHAR(MAX) NOT NULL,
  id VARCHAR(10) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES Account(id),
  UNIQUE (phoneNumber),
  UNIQUE (email)
);

CREATE TABLE Admin
(
  hide BIT NOT NULL DEFAULT 0,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL IDENTITY(1,1),
  datebegin DATETIME NOT NULL,
  id VARCHAR(10) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES Person(id)
);

CREATE TABLE Receptionist
(
  hide BIT NOT NULL DEFAULT 0,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL IDENTITY(1,1),
  datebegin DATETIME NOT NULL,
  id VARCHAR(10) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES Person(id)
);

CREATE TABLE Assisstant
(
  hide BIT NOT NULL DEFAULT 0,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL IDENTITY(1,1),
  datebegin DATETIME NOT NULL,
  id VARCHAR(10) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES Person(id)
);

CREATE TABLE Patient
(
  isVip INT NOT NULL,
  hide BIT NOT NULL DEFAULT 0,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL IDENTITY(1,1),
  datebegin DATETIME NOT NULL,
  id VARCHAR(10) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES Person(id)
);

CREATE TABLE Bill
(
  id VARCHAR(10) NOT NULL,
  price INT NOT NULL check(price>=0),
  able BIT NOT NULL DEFAULT 1,
  hide BIT NOT NULL DEFAULT 0,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL IDENTITY(1,1),
  datebegin DATETIME NOT NULL,
  isPayed BIT NOT NULL,
  patid VARCHAR(10) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (patID) REFERENCES Patient(id)
);

CREATE TABLE Service
(
  id VARCHAR(10) NOT NULL,
  name NVARCHAR(100) NOT NULL,
  price INT NOT NULL check(price>=0),
  quantity INT NOT NULL,
  note NVARCHAR(MAX) NOT NULL,
  kind NVARCHAR(100) NOT NULL,
  able BIT NOT NULL DEFAULT 1,
  hide BIT NOT NULL DEFAULT 0,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL IDENTITY(1,1),
  datebegin DATETIME NOT NULL,
  calUnit NVARCHAR(50) NOT NULL,
  img VARCHAR(MAX) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE (name)
);

CREATE TABLE Material
(
  id VARCHAR(10) NOT NULL,
  name NVARCHAR(100) NOT NULL,
  quantity INT NOT NULL,
  calUnit VARCHAR(50) NOT NULL,
  able BIT NOT NULL DEFAULT 1,
  hide BIT NOT NULL DEFAULT 0,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL IDENTITY(1,1),
  datebegin DATETIME NOT NULL,
  img VARCHAR(MAX) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE (name)
);

CREATE TABLE FixedMaterial
(
  hide BIT NOT NULL DEFAULT 0,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL IDENTITY(1,1),
  datebegin DATETIME NOT NULL,
  able BIT NOT NULL DEFAULT 1,
  id VARCHAR(10) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES Material(id)
);

CREATE TABLE ConsumableMaterial
(
  expirationDate DATETIME NOT NULL,
  kind NVARCHAR(50) NOT NULL,
  hide BIT NOT NULL DEFAULT 0,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL IDENTITY(1,1),
  datebegin DATETIME NOT NULL,
  able BIT NOT NULL DEFAULT 1,
  id VARCHAR(10) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES Material(id)
);

CREATE TABLE Medicine
(
  price INT NOT NULL check(price>=0),
  hide BIT NOT NULL DEFAULT 0,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL IDENTITY(1,1),
  datebegin DATETIME NOT NULL,
  able BIT NOT NULL DEFAULT 1,
  id VARCHAR(10) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES ConsumableMaterial(id)
);

CREATE TABLE Bill_Service
(
  id VARCHAR(10) NOT NULL,
  hide BIT NOT NULL DEFAULT 0,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL IDENTITY(1,1),
  datebegin DATETIME NOT NULL,
  billID VARCHAR(10) NOT NULL,
  SerID VARCHAR(10) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (billID) REFERENCES Bill(id),
  FOREIGN KEY (SerID) REFERENCES Service(id)
);

CREATE TABLE Faculty
(
  id VARCHAR(10) NOT NULL,
  name NVARCHAR(MAX) NOT NULL,
  able BIT NOT NULL DEFAULT 1,
  hide BIT NOT NULL DEFAULT 0,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL IDENTITY(1,1),
  datebegin DATETIME NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE Calendar
(
  id VARCHAR(10) NOT NULL,
  timeStart DATETIME NOT NULL,
  timeEnd DATETIME NOT NULL,
  able BIT NOT NULL DEFAULT 1,
  hide BIT NOT NULL DEFAULT 0,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL IDENTITY(1,1),
  datebegin DATETIME NOT NULL,
  Personid VARCHAR(10) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (PersonID) REFERENCES Person(id)
);

CREATE TABLE Comment
(
  id VARCHAR(10) NOT NULL,
  msg NVARCHAR(MAX) NOT NULL,
  title NVARCHAR(MAX) NOT NULL,
  img VARCHAR(MAX) NOT NULL,
  hide BIT NOT NULL DEFAULT 0,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL IDENTITY(1,1),
  datebegin DATETIME NOT NULL,
  patid VARCHAR(10) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (patID) REFERENCES Patient(id)
);

CREATE TABLE Advertisement
(
  id VARCHAR(10) NOT NULL,
  msg NVARCHAR(MAX) NOT NULL,
  title NVARCHAR(MAX) NOT NULL,
  img VARCHAR(MAX) NOT NULL,
  hide BIT NOT NULL DEFAULT 0,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL IDENTITY(1,1),
  datebegin DATETIME NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE Clinic
(
  id VARCHAR(10) NOT NULL,
  name NVARCHAR(100) NOT NULL,
  phoneNumber VARCHAR(10) NOT NULL,
  address NVARCHAR(MAX) NOT NULL,
  img VARCHAR(MAX) NOT NULL,
  email VARCHAR(100) NOT NULL,
  facebook VARCHAR(MAX) NOT NULL,
  zalo VARCHAR(MAX) NOT NULL,
  instagram VARCHAR(MAX) NOT NULL,
  youtube VARCHAR(MAX) NOT NULL,
  hide BIT NOT NULL DEFAULT 0,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL IDENTITY(1,1),
  datebegin INT NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE Menu
(
  id VARCHAR(10) NOT NULL,
  name NVARCHAR(100) NOT NULL,
  link NVARCHAR(MAX) NOT NULL,
  hide BIT NOT NULL DEFAULT 0,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL IDENTITY(1,1),
  datebegin INT NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE Dentist
(
  title NVARCHAR(50) NOT NULL,
  hide BIT NOT NULL DEFAULT 0,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL IDENTITY(1,1),
  datebegin DATETIME NOT NULL,
  id VARCHAR(10) NOT NULL,
  falid VARCHAR(10) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES Person(id),
  FOREIGN KEY (falID) REFERENCES Faculty(id)
);

CREATE TABLE Prescription
(
  note NVARCHAR(MAX) NOT NULL,
  id VARCHAR(10) NOT NULL,
  able BIT NOT NULL DEFAULT 1,
  price INT NOT NULL check(price>=0),
  hide BIT NOT NULL DEFAULT 0,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL IDENTITY(1,1),
  datebegin DATETIME NOT NULL,
  denid VARCHAR(10) NOT NULL,
  patid VARCHAR(10) NOT NULL,
  billid VARCHAR(10) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (denID) REFERENCES Dentist(id),
  FOREIGN KEY (patID) REFERENCES Patient(id),
  FOREIGN KEY (billID) REFERENCES Bill(id)
);

CREATE TABLE Prescription_Medicine
(
  id VARCHAR(10) NOT NULL,
  quantityMedicine INT NOT NULL,
  hide BIT NOT NULL DEFAULT 0,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL IDENTITY(1,1),
  datebegin DATETIME NOT NULL,
  preid VARCHAR(10) NOT NULL,
  Medid VARCHAR(10) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (preID) REFERENCES Prescription(id),
  FOREIGN KEY (MedID) REFERENCES Medicine(id)
);

CREATE TABLE Appointment
(
  id VARCHAR(10) NOT NULL,
  symptom NVARCHAR(MAX) NOT NULL,
  state NVARCHAR(50) NOT NULL,
  note NVARCHAR(MAX) NOT NULL,
  hide BIT NOT NULL DEFAULT 0,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL IDENTITY(1,1),
  datebegin DATETIME NOT NULL,
  denid VARCHAR(10) NOT NULL,
  patid VARCHAR(10) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (denID) REFERENCES Dentist(id),
  FOREIGN KEY (patID) REFERENCES Patient(id)
);
GO

--Tao Trigger

--Cap nhat tien cua bill khi them dong trong Bill_Service
CREATE TRIGGER ADD_Bill_Service
ON Bill_Service
AFTER INSERT
AS
BEGIN
	(select b.id,'Total' = SUM(s.price) into T
	from Bill_Service bs
	join bill b
	on b.id = bs.id
	join service s
	on s.id = bs.id
	group by b.id)

	UPDATE Bill 
	SET price = 
	case 
		when bill.id in (select id from T) then (select total  from T where Bill.id = T.id)
		else '0'
	end
	drop table T
END
GO

--Cap nhat tien cua bill khi them dong trong Prescription
CREATE TRIGGER ADD_Prescription
ON Prescription 
AFTER INSERT
AS
BEGIN
	UPDATE Bill 
	SET price = (select price from inserted) 
	WHERE Bill.id = (select billid from inserted) 
END
GO

--Cap nhat tien cua Prescription khi them dong trong Prescription_Medicine
CREATE TRIGGER ADD_Prescription_Medicine
ON Prescription_Medicine 
AFTER INSERT
AS
BEGIN
	UPDATE Prescription 
	SET price = (select price*quantityMedicine from inserted) 
	WHERE Prescription.id = (select preID from inserted) 
END
GO

--STORE PROCEDURE
--Them du lieu
--Account,Person,Manager,Receptionist,Dentist,Assisstant,Patient
create proc procAddAccountAndPerson
	--thuoc tinh cua account
	@username NVARCHAR(50),
	@password NVARCHAR(50),

	--thuoc tinh cua person
	@name NVARCHAR(100),
	@phoneNumber VARCHAR(10),
	@email VARCHAR(100),
	@salary INT,
	@address NVARCHAR(MAX),
	@gender BIT,
	@birthday DATETIME,
	@nation NVARCHAR(MAX),
	@role INT,
	@img VARCHAR(MAX),

	--thuoc tinh cua dentist
	@falID VARCHAR(10),
	@title NVARCHAR(50),

	--Cac the meta
	@MetaAccount VARCHAR(MAX),
	@MetaPerson VARCHAR(MAX),
	@MetaPersonDetail VARCHAR(MAX)
as
begin
	--insert vao account
	declare @Quan INT
	set @Quan = (select count(*) from Account)
	if (TRIM(@MetaAccount) = '')
		begin
			set @MetaAccount = 'tai-khoan-' + CONVERT(varchar(MAX), @Quan+1)
		end
	declare @AccID VARCHAR(10)
	set @AccID = dbo.autoid('AC', @Quan+1)
	insert into Account(id, username, password,meta,datebegin)
	values (@AccID,@username,@password,@MetaAccount,GETDATE())

	--insert vao person
	
	if(TRIM(@MetaPerson) ='')
		begin
			set @MetaPerson = 'nguoi-dung-' + CONVERT(varchar(MAX), @Quan+1) --So luong nguoi dung va tai khoan phai bang nhau
		end
	insert into Person(id, name, phoneNumber,email,salary,address,gender,birthday,nation,role,img,meta,datebegin)
	values (@AccID,@name,@phoneNumber,@email,@salary,@address,@gender,@birthday,@nation,@role,@img,@MetaPerson,GETDATE())
	
	--Chia theo vai tro cua role
	--1 la quan li
	--2 la le tan
	--3 la nha si
	--4 la phu ta
	--5 la benh nhan

	--insert vao quan li
	if(@role = 1)
		begin
			declare @QuanAdmin INT
			set @QuanAdmin = (select count(*) from Admin)
			if(TRIM(@MetaPersonDetail)='') 
				begin
					set @MetaPersonDetail = 'quan-li-' + CONVERT(varchar(MAX), @QuanAdmin+1)
				end
			insert into Admin(id,meta,datebegin)
			values (@AccID,@MetaPersonDetail,GETDATE())
		end
	--insert vao le tan
	else if (@role = 2)
		begin
			declare @QuanRe INT
			set @QuanRe = (select count(*) from Receptionist)
			if(TRIM(@MetaPersonDetail)='') 
				begin
					set @MetaPersonDetail = 'le-tan-' + CONVERT(varchar(MAX), @QuanRe+1)
				end
			insert into Receptionist(id,meta,datebegin)
			values (@AccID,@MetaPersonDetail,GETDATE())
		end
	--insert vao nha si
	else if (@role = 3)
		begin
			declare @QuanDen INT
			set @QuanDen = (select count(*) from Dentist)
			if(TRIM(@MetaPersonDetail)='') 
				begin
					set @MetaPersonDetail = 'nha-si-' + CONVERT(varchar(MAX), @QuanDen+1)
				end
			insert into Dentist(id,title,falid,meta,datebegin)
			values (@AccID,@title,@falID,@MetaPersonDetail,GETDATE())
		end
	--insert vao phu ta
	else if (@role = 4)
		begin
			declare @QuanAs INT
			set @QuanAs = (select count(*) from Assisstant)
			if(TRIM(@MetaPersonDetail)='') 
				begin
					set @MetaPersonDetail = 'phu-ta-' + CONVERT(varchar(MAX), @QuanAs+1)
				end
			insert into Assisstant(id,meta,datebegin)
			values (@AccID,@MetaPersonDetail,GETDATE())
		end
	--insert vao benh nhan
	else if (@role = 5)
		begin
			declare @QuanPat INT
			set @QuanPat = (select count(*) from Patient)
			if(TRIM(@MetaPersonDetail)='') 
				begin
					set @MetaPersonDetail = 'benh-nhan-' + CONVERT(varchar(MAX), @QuanPat+1)
				end
			insert into Patient(id,meta,datebegin,isVip)
			values (@AccID,@MetaPersonDetail,GETDATE(),0)
		end
end 
go

--select * from Account
--select * from Person


--them quan li
exec procAddAccountAndPerson 'admin','123',N'Tạ Triết','0908823743','tatriet16@gmail.com',23000000
,N'23 Lê Hồng Phong, Châu Thành, Trà Vinh',1,'2004-09-21',N'Việt Nam',1,'','','','tai-khoan-thu-nhat', 'nguoi-dung-dau-tien', 'ta-triet'
--select * from Admin

--them le tan
exec procAddAccountAndPerson 'recep1','234',N'Đinh Phát Phát','0908832142','phatphat@gmail.com',23000000
,N'154 Phạm Ngũ Lão, Thành Thái, Gò Vấp',1,'2004-11-28',N'Việt Nam',2,'','','','tai-khoan-thu-2', 'nguoi-dung-sau', 'dinh-phat-phat'
exec procAddAccountAndPerson 'recep2','11',N'Đăng Văn Trọng','0893842173','dvv@gmail.com',22000000
,N'182 Tạ Quang Bữu, Phường 9, Quận 10',1,'2004-01-02',N'Việt Nam',2,'','','','', 'nguoi-dung-tam', ''
go
--select * from receptionist


--THEM KHOA
create proc procAddFaculty
	@name NVARCHAR(MAX),
	@meta VARCHAR(MAX)
as
begin

	declare @QuanFal INT
	set @QuanFal = (select count(*) from Faculty)
	if(TRIM(@meta)='') 
		begin
			set @meta = 'khoa-' + CONVERT(varchar(MAX), @QuanFal+1)
		end
	declare @id VARCHAR(10)
	set @id = dbo.autoid('FA', @QuanFal+1)
	insert into Faculty(id,meta,name,datebegin)
	values (@id,@meta,@name,GETDATE())
end
go

--select * from Faculty
--them khoa
exec procAddFaculty 'Nha chu', 'khoa-nha-chu'
exec procAddFaculty N'Phục Hình', 'khoa-phuc-hinh'
exec procAddFaculty N'Răng trẻ em', 'khoa-rang-tre-em'
exec procAddFaculty N'Nhổ răng va tiểu phẩu', 'khoa-nho-rang-va-tieu-phau'
exec procAddFaculty N'Chữa răng và nội nha','khoa-chu-rang-va-noi-nha'
exec procAddFaculty N'Tổng quát', 'khoa-tong-quat'
GO


--them nha si
exec procAddAccountAndPerson 'dentist1','123',N'Lâm Đình Kiêm','09023511284',  'lamvak@gmail.com', 9000000,N'Tây Ninh'
,  1,'2003-01-02',N'Việt Nam',3,'', 'FA00000001',N'Thạc sĩ','','',''
exec procAddAccountAndPerson 'dentist2','123',N'Hoa Hồ Quốc Đại', '09092815226', 'hoadai@gmail.com', 8700000,N'Kiên Giang'
,  1,'1998-07-02',N'Việt Nam',3,'', 'FA00000002',N'Tiến sĩ','','',''
exec procAddAccountAndPerson 'dentist3','123',N'Bùi Xuân Huấn', '09062715226', 'buixhuan@gmail.com', 8000000,N'Trà Vinh'
,  1,'2010-11-11',N'Việt Nam',3,'', 'FA00000003',N'Thạc sĩ','','',''
exec procAddAccountAndPerson 'dentist4','123',N'Linh Văn Sơn', '09028365226', 'linhnui@gmail.com', 8000000,N'Thanh Hoá'
,  1,'2014-03-14',N'Việt Nam',3,'', 'FA00000004',N'Tiến sĩ','','',''
exec procAddAccountAndPerson 'dentist5','123',N'Tạ Minh Triết', '09024635226', 'taminhtriet16@gmail.com', 9300000,N'An Giang'
,  1,'1980-01-21',N'Việt Nam',3,'', 'FA00000005',N'Thạc sĩ','','',''
exec procAddAccountAndPerson 'dentist6','123',N'Hoa Yến Anh', '09022915226', 'anhvippro@gmail.com', 9400000,N'Tân Biên'
,  0,'1990-01-01',N'Việt Nam',3,'', 'FA00000006',N'Tiến sĩ','','',''
GO

--them phu ta 
exec procAddAccountAndPerson 'assisstant1','12',N'Thiết Kiến Công Chúa','0893320123','congchuaslay@gmail.com',3000000
,N'291 Phố Đi Bộ, Nguyễn Huệ, Quận 1',1,'2004-04-12',N'Việt Nam',4,'','','','   ','   ','  '
exec procAddAccountAndPerson 'assisstant2','13',N'Cô Văn Nan','0892930213','shinichi@gmail.com',2400000
,N'19 Phố Baker, Phường An Lạc, Bình Dương',1,'2004-05-12',N'Nhật Bản',4,'','','','','',''
exec procAddAccountAndPerson 'assisstant3','14',N'Đặc Vụ Ngầm','0902931823','aibiet@gmail.com',2200000
,N'12 Lạc long quân, Hàng Chài, Phú Thọ',0,'2001-01-02',N'Anh',4,'','','','','',''
exec procAddAccountAndPerson 'assisstant4','15',N'Mai Quốc Khánh','0902839141','khanhvippro@gmail.com',2800000
,N'20 Nguyễn Du, Phường Đồng Khánh, Quận 3',0,'2004-09-02',N'Việt Nam',4,'','','','','',''
--select * from assisstant


--them benh nhan
exec procAddAccountAndPerson 'patient1','12',N'Thân Quốc Thịnh','0908827372','thinhthinh@gmail.com',0
,N'12 Phạm Văn Đồng, Phường Tân Khải, Quận 5',1,'1998-05-30',N'Việt Nam',5,'','','','','',''
exec procAddAccountAndPerson 'patient2','13',N'Châu Nguyễn Khánh Trình','0908829374','trinhchicken@gmail.com',0
,N'19 Văn Thành, Phường Khởi Định, Quận 3',1,'1998-03-25',N'Việt Nam',5,'','','','','',''
exec procAddAccountAndPerson 'patient3','14',N'Trịnh Thị Hồng Phúc','0908861419','phuccute@gmail.com',0
,N'12 Long Thành Bắc, Khu Phố 3, Hòa Thành, Tây Ninh',0,'2004-02-02',N'Việt Nam',5,'','','','','',''
exec procAddAccountAndPerson 'patient4','15',N'Hồ Minh Thư','0908829131','thuho@gmail.com',0
,N'2 Hà Thanh, Khu Phố 2, Châu Thành, An GIang',0,'2001-10-12',N'Việt Nam',5,'','','','','',''
--select * from patient