use master;

if DB_ID('Disk_Inventory') is not null
	Drop DATABASE Disk_Inventory;
GO

create database Disk_Inventory;
GO

use Disk_Inventory;

create table Borrower
	(borrower_ID int identity primary key,
	emaill_address varchar(100) not null unique,
	first_name varchar (32) not null ,
	last_name varchar (32) not null, 
	phone_number int not null);

create TABLE Disk_Status
	(status_code_ID int identity primary key,
	disk_description varchar(255) not null);

create TABLE Disk_Type
	(disk_type_ID varchar(10) primary key,
	disk_type_description varchar(255) not null);

create TABLE Genre
	(genre_ID int identity primary key,
	genre_description varchar(255) not null,
	genre_name varchar(32) not null );

create TABLE Artist_Type
	(artist_type_ID varchar(10) primary key,
	artist_type_description varchar(255) not null);

create TABLE Artist
	(artist_ID int identity primary key,
	first_name varchar(32) not null,
	last_name varchar(32) null,
	disk_type_ID varchar(10) REFERENCES Disk_Type(disk_type_ID),
	);

create TABLE Disk
	(disk_ID int identity primary key,
	disk_name varchar(255) not null,
	release_date datetime not null,
	disk_type_ID varchar(10) REFERENCES Disk_Type(disk_type_ID),
	);