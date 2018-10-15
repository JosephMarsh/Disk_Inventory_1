/************************************************************
*	Disk Inventory Project									*
*	By Joseph Marsh											*
*	10/5/218												*
*	Build: project 3 Deliverable							*
************************************************************/

--See Line 83 for Project 3

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
	phone_number bigint not null); --Changed to bigint 10/12/18

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
	first_name varchar(32) null,--can be null
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

--List of status options for disks
INSERT INTO Disk_Status 
	(disk_description)
VALUES
	('Pre-Release. Do not rent out!'),
	('In Stock'),
	('Checked out' ),
	('Missing'),
	('Reported Stolen'),
	('Damaged - needs repaired'),
	('Damaged Out - Unseviceable'),
	('Archived');

--list of media types
INSERT INTO Disk_Type
	(disk_type_ID, disk_type_description)
VALUES
	('LD', 'Laser Disk - Video'),
	('CD','CD - Audio'),
	('CDCV','CD - Compressed Video File'),
	('CDG','CD - Game'),
	('CD_0','CD - Other Media Type'),
	('DVDA','DVD - Audio Only'),
	('DVDCV','DVD - Compressed Video File'),
	('DVD','DVD - Video'),
	('DVDG','DVD - Game'),
	('DVD_0','DVD - Other Media Type'),
	('BDA','Blu-Ray - Audio Only'),
	('BDCV','Blu-Ray - Compressed Video File'),
	('BD','Blu-Ray - Video'),
	('BDG','Blu-Ray - Game'),
	('BD_0','Blu-Ray - Other Media Type');

--List of Artist Types
INSERT INTO Artist_Type
	(artist_type_ID, artist_type_description)
VALUES
	('M','Music Band or artist'),
	('MD','Music Director'),
	('VA','Vidio Actor'),
	('VD','Vidio Director'),
	('MP','Music Producer'),
	('VP','Video Producer'),
	('MPP','Music Publisher'),
	('VPP','Vidio Publisher');

--List of Genres
INSERT INTO Genre
	(genre_name, genre_description)
VALUES
	('Rock','Fast music with upbeat tempo, frequently featuring Electric Guitars.'),
	('Country','Terrible music that no one should ever listen to, frequently featuring Steal guitars.'),
	('Rap','Often poetic and featuring loud, repeatative beats.'),
	('Clasical','Usually soft frequently featuring stringed intruments, brass instruments, or a combination therof.'),
	('Metal','Fast, Heavy and loud, frequetly featuring screeming and gravely vocals.'),
	('Horror','Scary!'),
	('Action','Pew-Pew, BOOM!'),
	('Romance','Smoochy!'),
	('Suspense','What will happen next?!!'),
	('Sci-Fi','Spaceships and superpowers!'),
	('Mystery','Who-Dun-It?'),
	('Documentry','Hu? I did not know that...');

--List of Borrowers
INSERT INTO Borrower
	(first_name, last_name, phone_number, emaill_address)
VALUES
	('Bob','Smith', 5556667777 ,'bsmith7890@email.com'),
	('Edd','Smith', 5551112222 ,'dsmith65654@email.com'),
	('Erica','Smith', 5553333333 ,'esmith78563@email.com'),
	('Sam','Smith', 5554455556 ,'ssmith0988967@email.com'),
	('Frank','Smith', 5559999999,'fsmith63342@email.com'),
	('David','Smith', 5551234567,'dsmith323422@email.com'),
	('Edith','Smith', 5557654321,'esmithnumbers0@email.com'),
	('Edna','Smith', 5551243659,'oddball76@email.com'),
	('Jade','Smith', 5551122445,'jsmith1234@email.com'),
	('Simmone','Smith', 5553322545 ,'ssmith77778@email.com'),
	('Bob','Lee', 5553242335,'bleeshouse@email.com'),
	('Bruce','Lee', 5523424325,'chucknorisfan@email.com'),
	('Brandan','Lee', 6662323232 ,'murderofcrows123@email.com'),
	('Bob','Thompson', 9991231231 ,'secrets123@email.com'),
	('Bob','Franklin', 1231231231 ,'ivotedfortheother1@email.com'),
	('Bob','Eldrich', 1233333333 ,'superman321@email.com'),
	('Bob','Keenan', 9991331231 ,'riverboat957@email.com'),
	('Danny','Elfman', 1112223333 ,'composer4life@email.com'),
	('Bob','Wright', 4445556666 ,'carzzzrgud@email.com'),
	('Joey','Marsh', 3332221111 ,'joeymarsh@email.com');

--List of Artists
INSERT INTO Artist
	(first_name, last_name, group_name, artist_type_ID)
VALUES
	('Madonna', NULL, 'Madonna', 'M' ),
	(NULL, NULL, 'TOOL', 'M' ),
	(NULL, NULL, 'Metallica', 'M' ),
	('Paul', 'Okenfold', NULL, 'M' ),
	('Will', 'Smith', NULL, 'VA' ),
	('Will', 'Smith', NULL, 'M' ),
	('Will', 'Smith', NULL, 'VP' ),
	('Johnny', 'Depp', NULL, 'M' ),
	('Johnny', 'Depp', NULL, 'VA' ),
	('Johnny', 'Depp', NULL, 'VD' ),
	('Johnny', 'Depp', NULL, 'VP' ),
	('Johnny', 'cash', NULL, 'M' ),
	('Orlando', 'Bloom', NULL, 'VA' ),
	('Kira', 'knightley', NULL, 'VA' ),
	('Danny' , 'Elfman', NULL, 'M' ),
	(NULL, NULL, 'Dream Theater', 'M' ),
	('Terry', 'Crews', NULL, 'VA' ),
	(NULL , NULL, 'Nirvana', 'M' ),
	('John', 'Petrucci', NULL, 'M' ),
	('Charlize', 'Theron', NULL, 'VA' );

--List of Disks
INSERT INTO Disk
	(disk_name, rel_date, disk_type_ID, genre_ID, status_code_ID)
VALUES
	('Hancock', 02-07-2008, 'DVD', 7, 2 ),
	('Hancock', 02-07-2008, 'DVD', 7, 1 ),
	('Hancock', 02-07-2008, 'BD', 7, 3 ),
	('Hancock', 02-07-2008, 'DVD', 7, 5 ),
	('Pirates of the Caribbean: The Curse of the Black Pearl', 13-07-2003, 'DVD', 7, 2 ),
	('Pirates of the Caribbean: The Curse of the Black Pearl', 13-07-2003, 'BD', 7, 2 ),
	('Pirates of the Caribbean: The Curse of the Black Pearl', 13-07-2003, 'DVD', 7, 2 ),
	('Metalica (Black Album)', 12-08-1991, 'CD', 5, 5 ),
	('Madonna', 07-27-1983, 'CD', 1, 2 ),
	('Madonna', 07-27-1983, 'CD', 1, 3 ),
	('Madonna', 07-27-1983, 'CD', 1, 4 ),
	('Like A Virgin', 11-12-1984, 'CD', 1, 2 ),
	('Ray of Light', 03-03-1998, 'CD', 1, 3 ),
	('Ride the Lightning', 07-27-1984, 'CD', 5, 2 ),
	('...And Justice for All', 07-27-1983, 'CD', 5, 2 ),
	('Forbidden Zone', 01-01-1982, 'CD', 4, 2 ),
	('The Rebel', 01-01-1960, 'CD', 2, 2 ),
	('The Hunted', 01-01-2003, 'DVD', 9, 3 ),
	('Octavarium', 06-07-2005, 'CD', 5, 2 ),
	('Metropolis Pt. 2: Scenes from a Memory', 10-26-1999, 'CD', 5, 2 ),
	('Black Clouds & Silver Linings', 09-24-2011, 'CD', 5, 2 );
