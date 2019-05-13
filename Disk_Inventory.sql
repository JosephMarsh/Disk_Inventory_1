/************************************************************
*	Disk Inventory Project				    *
*	By Joseph Marsh					    *
*	10/19/218					    *
*	Build: project 4 Deliverable			    *
************************************************************/

--See Line 285 for Project 4 Selects

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
	('Charlize', 'Theron', NULL, 'VA' ),
	('Johnny', 'cash', NULL, 'VA' );

--List of Disks in inventory
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

--Associates disks with artists.
INSERT INTO Disk_Has_Artist
	(disk_ID, artist_ID)
VALUES
	(19, 16),
	(19, 19),
	(1, 20),
	(2, 20),
	(3, 20),
	(4, 20),
	(1, 5),
	(2, 5),
	(3, 5),
	(4, 5),
	(5, 14),
	(5, 9),
	(6, 14),
	(6, 9),
	(7, 14),
	(7, 9),
	(8, 3),
	(14, 3),
	(15, 3),
	(9, 1),
	(10, 1),
	(11, 1),
	(12, 1),
	(13, 1),
	(20, 19),
	(20, 16),
	(16, 12),
	(17, 12),
	(18, 21),
	(21, 16);

--Added some Null enties 10/19/2018 for testing purposes 
INSERT INTO Rental_Log
	(disk_ID, Borrower_ID, check_out_date,check_in_date)
VALUES
	(8, 18, '2017-10-10 12:12:09', '2017-10-17 13:15:15'  ),
	(8, 18, '2017-12-30 12:15:19', '2018-01-07 12:15:19'  ),
	(2, 18, '2017-02-20 11:01:19', '2017-02-22 11:01:23'  ),
	(4, 13, '2017-12-15 12:16:22', '2017-12-21 12:16:33'  ),
	(4, 15, '2017-01-17 13:22:33', '2017-01-22 13:22:43'  ),
	(6, 18, '2017-12-01 16:33:44', NULL  ),
	(8, 13, '2017-09-06 17:44:55', '2017-09-12 17:44:23'  ),
	(8, 18, '2017-07-08 12:53:34', '2017-07-18 12:53:23'  ),
	(6, 18, '2017-06-20 14:23:43', '2017-07-01 14:23:12'  ),
	(8, 1, '2017-11-21 12:15:12', '2017-12-01 12:15:19'  ),
	(17, 18, '2017-07-29 15:53:21', '2017-08-12 15:53:29'  ),
	(8, 13, '2017-05-28 12:32:24', NULL  ),
	(8, 18, '2017-02-22 17:41:44', '2017-02-28 17:41:44'  ),
	(20, 8, '2017-05-15 12:22:23', '2017-05-23 12:22:23'  ),
	(19, 16, '2017-05-25 13:31:13', '2017-06-02 13:31:13'  ),
	(8, 15, '2017-03-22 12:45:09', '2017-03-25 12:45:11'  ),
	(15, 13, '2017-08-21 15:32:19', '2017-08-26 15:32:29'  ),
	(13, 11, '2017-12-13 09:21:29', NULL  ),
	(1, 11, '2017-11-14 10:32:19', '2017-11-20 12:32:03'  ),
	(15, 10, '2017-12-12 13:44:11', NULL  ),
	(21, 18, '2017-12-13 12:22:12', '2017-12-15 12:22:32'  );

-- 3 Show the disks in your database and any associated Individual artists only. 
-- Sort by Artist Last Name, First Name & Disk Nam
SELECT disk_Name AS [Disk Title], CAST (rel_date AS DATE) AS [Release Date], 
	first_name As [Artist's First Name],
	last_name AS [Artist's Last Name]
FROM Disk 
	JOIN Disk_Has_Artist ON Disk.disk_ID = Disk_Has_Artist.disk_ID
	JOIN Artist ON Disk_Has_Artist.artist_ID = Artist.artist_ID
WHERE first_name IS NOT NULL AND last_name IS NOT NULL
ORDER BY last_name, first_name

/**********************************************************************/

-- 4 Create a view called View_Individual_Artist that shows the artists 
-- names and not group names
--Check to see if the View has already been created
if OBJECT_ID ('View_Inividual_Artist') IS NOT NULL
	Drop View View_Inividual_Artist;
GO
--Create the View
CREATE VIEW View_Inividual_Artist AS
SELECT artist_id,
	first_name As [First Name],
	last_name AS [Last Name]
FROM Artist
Where first_name IS NOT NULL;
GO

--Show results of View creation
SELECT [First Name],[Last Name]
FROM View_Inividual_Artist;
/**********************************************************************/

-- 5 Show the disks in your database and any associated Group artists only.
-- Use the View_Individual_Artist view. Sort by Group Name & Disk Name.
SELECT disk_Name AS [Disk Title],CAST (rel_date AS DATE) AS [Release Date],
	 group_name AS [Group Name]
FROM disk
	JOIN Disk_Has_Artist ON Disk.disk_ID = Disk_Has_Artist.disk_ID
	JOIN Artist ON Artist.artist_ID = Disk_Has_Artist.artist_ID
	--Find all the Groups that are not Individual Artists
Where Disk_Has_Artist.artist_ID NOT IN 
	(SELECT artist_ID 
	FROM View_Inividual_Artist)
ORDER BY [Group Name];
/**********************************************************************/

-- 6 Show which disks have been borrowed and who borrowed them. 
-- Sort by Borrowers Last Name.
SELECT first_name AS [First], last_name AS [Last], disk_name AS [Disk Name]
FROM Rental_Log
	JOIN Borrower ON Borrower.borrower_ID = Rental_Log.borrower_ID
	JOIN Disk ON  Rental_Log.disk_ID = Disk.disk_ID
ORDER BY [Last], [First];
/**********************************************************************/

-- 7 In disk_id order, show the number of times each disk has been borrowed.
SELECT Rental_Log.disk_ID AS [Disk ID], disk_name AS [Disk Name],
	 Count(Rental_Log.disk_ID) AS [Times Borrowed]
FROM Rental_Log
	JOIN Disk ON Disk.disk_ID = Rental_Log.disk_ID
GROUP BY  Rental_Log.disk_ID, Disk.disk_name
/**********************************************************************/

-- 8 Show the disks outstanding or on-loan and who has each disk. Sort by disk name.
SELECT disk_name AS [Disk Name], CAST(check_out_date AS DATE) AS [Borrowed],
	check_in_date AS [Returned],last_name AS [Last Name]
FROM Rental_Log
	JOIN Borrower ON Borrower.borrower_ID = Rental_Log.borrower_ID
	JOIN Disk ON Disk.disk_ID = Rental_Log.disk_ID
Where check_in_date IS NULL
