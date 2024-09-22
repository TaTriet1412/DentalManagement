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
  hide BIT NOT NULL,
  [order] INT NOT NULL,
  datebegin DATETIME NOT NULL,
  able BIT NOT NULL,
  PRIMARY KEY (id),
  UNIQUE (username)
);

CREATE TABLE Person
(
  meta VARCHAR(MAX) NOT NULL,
  hide BIT NOT NULL,
  [order] INT NOT NULL,
  datebegin DATETIME NOT NULL,
  name NVARCHAR(100) NOT NULL,
  phoneNumber VARCHAR(10) NOT NULL,
  email VARCHAR(100) NOT NULL,
  salary INT NOT NULL,
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
  hide BIT NOT NULL,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL,
  datebegin DATETIME NOT NULL,
  id VARCHAR(10) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES Person(id)
);

CREATE TABLE Receptionist
(
  hide BIT NOT NULL,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL,
  datebegin DATETIME NOT NULL,
  id VARCHAR(10) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES Person(id)
);

CREATE TABLE Assisstant
(
  hide BIT NOT NULL,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL,
  datebegin DATETIME NOT NULL,
  id VARCHAR(10) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES Person(id)
);

CREATE TABLE Patient
(
  isVip INT NOT NULL,
  hide BIT NOT NULL,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL,
  datebegin DATETIME NOT NULL,
  id VARCHAR(10) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES Person(id)
);

CREATE TABLE Bill
(
  id VARCHAR(10) NOT NULL,
  price INT NOT NULL,
  able BIT NOT NULL,
  hide BIT NOT NULL,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL,
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
  price INT NOT NULL,
  quantity INT NOT NULL,
  note NVARCHAR(MAX) NOT NULL,
  kind NVARCHAR(100) NOT NULL,
  able BIT NOT NULL,
  hide BIT NOT NULL,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL,
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
  able BIT NOT NULL,
  hide BIT NOT NULL,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL,
  datebegin DATETIME NOT NULL,
  img VARCHAR(MAX) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE (name)
);

CREATE TABLE FixedMaterial
(
  hide BIT NOT NULL,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL,
  datebegin DATETIME NOT NULL,
  able BIT NOT NULL,
  id VARCHAR(10) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES Material(id)
);

CREATE TABLE ConsumableMaterial
(
  expirationDate DATETIME NOT NULL,
  kind NVARCHAR(50) NOT NULL,
  hide BIT NOT NULL,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL,
  datebegin DATETIME NOT NULL,
  able BIT NOT NULL,
  id VARCHAR(10) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES Material(id)
);

CREATE TABLE Medicine
(
  price INT NOT NULL,
  hide BIT NOT NULL,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL,
  datebegin DATETIME NOT NULL,
  able BIT NOT NULL,
  id VARCHAR(10) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES ConsumableMaterial(id)
);

CREATE TABLE Bill_Service
(
  id VARCHAR(10) NOT NULL,
  hide BIT NOT NULL,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL,
  datebegin DATETIME NOT NULL,
  billID VARCHAR(10) NOT NULL,
  SerID VARCHAR(10) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (billID) REFERENCES Bill(id),
  FOREIGN KEY (SerID) REFERENCES Service(id)
);

CREATE TABLE Falcuty
(
  id VARCHAR(10) NOT NULL,
  name NVARCHAR(MAX) NOT NULL,
  able BIT NOT NULL,
  hide BIT NOT NULL,
  meta VARCHAR NOT NULL,
  [order] INT NOT NULL,
  datebegin DATETIME NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE Calendar
(
  id VARCHAR(10) NOT NULL,
  timeStart DATETIME NOT NULL,
  timeEnd DATETIME NOT NULL,
  able BIT NOT NULL,
  hide BIT NOT NULL,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL,
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
  hide BIT NOT NULL,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL,
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
  hide BIT NOT NULL,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL,
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
  hide BIT NOT NULL,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL,
  datebegin INT NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE Dentist
(
  title NVARCHAR(50) NOT NULL,
  hide BIT NOT NULL,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL,
  datebegin DATETIME NOT NULL,
  id VARCHAR(10) NOT NULL,
  falid VARCHAR(10) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES Person(id),
  FOREIGN KEY (falID) REFERENCES Falcuty(id)
);

CREATE TABLE Prescription
(
  note NVARCHAR(MAX) NOT NULL,
  id VARCHAR(10) NOT NULL,
  able BIT NOT NULL,
  price INT NOT NULL,
  hide BIT NOT NULL,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL,
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
  hide BIT NOT NULL,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL,
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
  hide BIT NOT NULL,
  meta VARCHAR(MAX) NOT NULL,
  [order] INT NOT NULL,
  datebegin DATETIME NOT NULL,
  denid VARCHAR(10) NOT NULL,
  patid VARCHAR(10) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (denID) REFERENCES Dentist(id),
  FOREIGN KEY (patID) REFERENCES Patient(id)
);

