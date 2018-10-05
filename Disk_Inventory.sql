
/************************************************************
*	Disk Inventory Project									*
*	By Joseph Marsh											*
*	10/5/218												*
*	Build: project 2 Deliverable							*
************************************************************/

use master;

if DB_ID('Disk_Inventory') is not null
	Drop DATABASE Disk_Inventory;
GO

create database Disk_Inventory;
GO

use Disk_Inventory;

--Stores user info (no depenancies)
create table Borrower
	(borrower_ID int identity primary key not null,
	emaill_address varchar(100) not null unique,
	first_name varchar (32) not null ,
	last_name varchar (32) not null, 
	phone_number int not null);

--Stores disk status Identifiers (no depenancies)
create TABLE Disk_Status
	(status_code_ID int identity primary key not null,
	disk_description varchar(255) not null);

--Stores disk Type Identifiers (no depenancies)
create TABLE Disk_Type
	(disk_type_ID varchar(10) primary key not null,
	disk_type_description varchar(255) not null);

--Stores list of Genres (no depenancies)
create TABLE Genre
	(genre_ID int identity primary key not null,
	genre_description varchar(255) not null,
	genre_name varchar(32) not null );

--Stores list of artist types (no depenancies)
create TABLE Artist_Type
	(artist_type_ID varchar(10) primary key not null,
	artist_type_description varchar(255) not null);

--Stores list of artists (has Artist Type)
create TABLE Artist
	(artist_ID int identity primary key not null,
	first_name varchar(32) not null,
	last_name varchar(32) null, --can be null
	group_name varchar(32) null, --can be null
	artist_type_ID varchar(10) REFERENCES  Artist_Type(artist_type_ID) 
		not null);

--Stores list of disks (has Disk_Type, Status_Code, Genre)
create TABLE Disk
	(disk_ID int identity primary key,
	disk_name varchar(255) not null,
	rel_date datetime not null, --date the disk is reased for checkout
	disk_type_ID varchar(10) REFERENCES Disk_Type(disk_type_ID) not null ,
	status_code_ID int REFERENCES Disk_Status(status_code_ID) not null,
	genre_ID int REFERENCES Genre(genre_ID) not null );

--Stores log of rental activities (has Borrwer and Disk)
create TABLE Rental_Log
	(check_out_date datetime not null,
	check_in_date datetime null, --can be null for disks that have never been check in
	borrower_ID int References Borrower(borrower_ID)not null ,
	disk_ID int References Disk(disk_ID)not null ,
	PRIMARY KEY (check_out_date, borrower_ID, disk_ID )); --Three Primary Keys

--Stores Artist/Disk Relationships (has Disk and Artist)

create TABLE Disk_Has_Artist
	(disk_ID int References Disk(disk_ID)not null,
	artist_ID int References Artist(artist_ID)not null,
	PRIMARY KEY (disk_ID, artist_ID));
