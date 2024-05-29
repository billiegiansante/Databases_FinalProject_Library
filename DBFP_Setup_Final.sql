/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`library` /*!40100 DEFAULT CHARACTER SET latin1 */;

SET SQL_SAFE_UPDATES = 0;
USE `library`;

DROP TABLE IF EXISTS `Employees`;

CREATE TABLE `Employees` (
  `id` mediumint(8) unsigned NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `phone` varchar(100) default NULL,
  `email` varchar(255) default NULL,
  `address` varchar(255) default NULL,
  `postalZip` varchar(10) default NULL,
  `birthday` varchar(255),
  `title` TEXT default NULL,
  `wage` DECIMAL(7,2) default NULL,
  PRIMARY KEY (`id`)
) AUTO_INCREMENT=1;

INSERT INTO `Employees` (`name`,`phone`,`email`,`address`,`postalZip`,`birthday`,`title`,`wage`)
VALUES
  ("Brady Cantrell","(722) 464-0823","velit.quisque@hotmail.couk","Ap #908-7793 Ligula Road","72-547","Dec 1, 1983","Page","22.41"),
  ("Len Patrick","(766) 889-8847","lacus.varius@outlook.org","124-7315 Tempor Rd.","791928","May 24, 1972","Reference","18.63"),
  ("Gregory Burks","(128) 811-8861","egestas.nunc.sed@icloud.ca","255-9394 Dapibus Av.","3938","Aug 7, 1982","Assistant(front","23.07"),
  ("Ariel Reid","(877) 766-6164","duis.risus@yahoo.com","Ap #770-5816 Sed Street","A5W 1G2","Jul 2, 1957","Page","24.11"),
  ("McKenzie O'donnell","(383) 524-1358","posuere.cubilia@aol.org","Ap #514-3258 Mauris Rd.","O4W 5S2","Jul 2, 1981","desk)","26.95");
  
DROP TABLE IF EXISTS `Patrons`;
CREATE TABLE `Patrons` (
  `id` mediumint(8) unsigned NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `phone` varchar(100) default NULL,
  `email` varchar(255) default NULL,
  `address` varchar(255) default NULL,
  `postalZip` varchar(10) default NULL,
  `birthday` varchar(255),
  `PatronAccountNumber` varchar(255),
  `signUp Date` Date,
  `fines` DECIMAL(7,2) default NULL,
  PRIMARY KEY (`id`)
) AUTO_INCREMENT=1;

INSERT INTO `Patrons` (`name`,`phone`, `email`, `address`,`postalZip`,`birthday`,`PatronAccountNumber`,`signUP Date`, `fines`)
VALUES
("Roanna Munoz","(875) 536-7427", "munoz81@gmail.com", "683-9041 Ultricies St.","77221","Aug 7, 1981","6767782483759364", "2023-02-04", "0.17"),
  ("Brian Sherman","(175) 407-4204","shermann2189@hotmail.com", "993-6649 Elementum Av.","66720","May 21, 1989","6334437258373867", "2022-06-03", "1.15"),
  ("Bruce Drake","(879) 747-7842", "drakeN98@aol.com", "8236 Dolor Rd.","25443","Mar 5, 1998","6767386173652440","2023-03-08", "1.22"),
  ("Seth Cohen","(839) 885-1834", " sethC75@yahoo.com", "4414 Eu Ave","44694","Apr 23, 1975","6767622243265221","2023-07-15", "0.48"),
  ("David Jimenez","(892) 375-9147", "DJ04@gmail.com", "334-8013 Massa. St.","96122","Mar 1, 2004","6767577584637331","2022-09-25", "1.97"),
  ("Gary Smith", "(876) 301-7867", "smithG9817@hotmail.com", "4118 Carrenbury Ln.", "78891", "Apr 17, 1998", "689909697190476", "2020-10-09", "1.07"),
  ("Katniss Everdeen", "(609) 756-7842", "ihateSnow@yahoo.com", "98 NoHome Lane", "037469", "June 21, 2078", "7389047261739408", "2018-10-04", "0.00");


DROP TABLE IF EXISTS `LibraryEvents`;
CREATE TABLE LibraryEvents (
    `EventID` INT PRIMARY KEY AUTO_INCREMENT,
    `EventTitle` VARCHAR(255),
    `LibraryHosting` VARCHAR(255),
    `OnlineVsInPerson` VARCHAR(20),
    `EventDescription` TEXT,
    `ManagedByID` INT,
    `EventDate` DATE
);

DROP TABLE IF EXISTS `Attendees`;
CREATE TABLE Attendees (
	`EventID` INT,
	`PatronID` INT
);

INSERT INTO LibraryEvents (EventTitle, LibraryHosting, OnlineVsInPerson, EventDescription, EventDate, ManagedByID)
VALUES 
    ('Book Club Meeting', 'Central Library', 'In Person', 'Join us for a discussion on "To Kill a Mockingbird" by Harper Lee. Refreshments will be provided.', "2024-04-02", 1),
    ('Virtual Storytime', 'Eastside Branch', 'Online', 'Gather around for a fun and interactive storytime session for children ages 3-6. Registration required.', "2018-03-17", 1),
    ('DIY Craft Workshop', 'Westside Branch', 'In Person', 'Get creative with our DIY craft workshop! Learn to make personalized bookmarks. All materials provided.', "2022-12-08", 3),
    ('Author Talk', 'Downtown Library', 'Online', 'Join us for a live virtual discussion with bestselling author John Doe about his latest book. Q&A session included.', "2023-07-23", 5),
    ('Resume Building Workshop', 'Northside Branch', 'In Person', 'Need help polishing your resume? Join us for a workshop where we\'ll provide tips and feedback. Limited spots available.', "2024-02-28", 4);

INSERT INTO Attendees (EventID, PatronID)
VALUES
	(1, 2),
    (1, 1),
    (1, 3),
    (2, 2),
    (2, 4),
    (3, 1),
    (3, 2),
    (3, 5),
    (4, 3),
    (4, 4),
    (4, 5),
    (5, 1),
    (5, 2),
    (5, 4);


-- Create the table for Media
DROP TABLE IF EXISTS `Media`;
CREATE TABLE Media (
	`MediaID` INT PRIMARY KEY AUTO_INCREMENT,
	`Title` VARCHAR(255),
    `CallNumber` VARCHAR(50),
    `BarCodeNumber` VARCHAR(50),
    `Genre` VARCHAR(100),
    `IsLost` BOOLEAN,
    `HoldAmount` INT,
    `MediaType` VARCHAR(10)
) AUTO_INCREMENT=1;

INSERT INTO `Media` (Title, CallNumber, BarCodeNumber, Genre, IsLost, HoldAmount, MediaType)
VALUES
	('The Great Gatsby', 'FIC-FIT', '12345678901234', 'Classic', FALSE, 15, 'Book'),
	('1984', 'FIC-ORW', '23456789012345', 'Dystopian', FALSE, 20, 'Book'),
	('To Kill a Mockingbird', 'FIC-LEE', '34567890123456', 'Classic', FALSE, 10, 'Book'),
	('The Catcher in the Rye', 'FIC-SAL', '45678901234567', 'Coming-of-Age', FALSE, 25, 'Book'),
	('Harry Potter and the Sorcerer''s Stone', 'FIC-ROW', '56789012345678', 'Fantasy', FALSE, 5, 'Book'),
    ('The Hobbit', 'FIC-TOL', '4567890123', 'Fantasy', FALSE, 0, 'Audiobook'),
	('Pride and Prejudice', 'FIC-AUS', '5678901234', 'Romance', FALSE, 0, 'Audiobook'),
	('The Catcher in the Rye', 'FIC-SAL', '6789012345', 'Coming-of-age', FALSE, 0, 'Audiobook'),
	('The Lord of the Rings', 'FIC-TOL', '7890123456', 'Fantasy', FALSE, 0, 'Audiobook'),
	('Harry Potter and the Philosopher''s Stone', 'FIC-ROW', '8901234567', 'Fantasy', FALSE, 0, 'Audiobook'),
    ('The Shawshank Redemption', 'DVD-Sha', '1234567890123', 'Drama', false, 0, 'DVD'),
    ('Inception', 'DVD-Inc', '2345678901234', 'Science Fiction', false, 0, 'DVD'),
    ('The Godfather', 'DVD-God', '3456789012345', 'Crime', false, 0, 'DVD'),
    ('Pulp Fiction', 'DVD-Pul', '4567890123456', 'Crime', false, 0, 'DVD'),
    ('The Dark Knight', 'DVD-Dar', '5678901234567', 'Action', false, 0, 'DVD'),
    ('The Matrix', 'DVD-Mat', '1234567890123', 'Action', false, 0, 'DVD'),
    ('Forrest Gump', 'DVD-Gum', '2345678901234', 'Drama', false, 0, 'DVD'),
    ('Jurassic Park', 'DVD-Jur', '3456789012345', 'Adventure', false, 0, 'DVD'),
    ('The Silence of the Lambs', 'DVD-Sil', '4567890123456', 'Thriller', false, 0, 'DVD'),
    ('Back to the Future', 'DVD-Bac', '5678901234567', 'Science Fiction', false, 0, 'DVD');


-- Create the table for DVDs
DROP TABLE IF EXISTS `DVDs`;
CREATE TABLE DVDs (
	`MediaID` INT PRIMARY KEY,
    `Director` VARCHAR(255),
	`YearReleased` INT,
    `Duration` TIME,
    FOREIGN KEY (MediaID) REFERENCES Media (MediaID)
);

INSERT INTO `DVDs` (MediaID, Director, YearReleased, Duration)
VALUES
	(11, 'Frank Darabont', 1994, '02:22:00'),
    (12, 'Christopher Nolan', 2010, '02:28:00'),
    (13, 'Francis Ford Coppola', 1972, '02:55:00'),
    (14, 'Quentin Tarantino', 1994, '02:34:00'),
    (15, 'Christopher Nolan', 2008, '02:32:00'),
	(16, 'The Wachowskis', 1999, '01:30:00'),
    (17, 'Robert Zemeckis', 1994, '01:42:00'),
    (18, 'Steven Spielberg', 1993, '01:57:00'),
    (19, 'Jonathan Demme', 1991, '01:58:00'),
    (20, 'Robert Zemeckis', 1985, '01:56:00'); 

-- Create the table for Books
DROP TABLE IF EXISTS `Books`;
CREATE TABLE Books (
	`MediaID` INT PRIMARY KEY,
    `Author` VARCHAR (255),
    `Pages` INT,
    `ISBN` VARCHAR(20),
	`PublicationDate` DATE,
    FOREIGN KEY (MediaID) REFERENCES Media (MediaID)
);

INSERT INTO `Books` (MediaID, Author, Pages, ISBN, PublicationDate)
VALUES
	(1, 'F. Scott Fitzgerald', 180, '978-0-7432-7356-5', '1925-04-10'),
	(2, 'George Orwell', 328, '978-0-452-28423-4', '1949-06-08'),
	(3, 'Harper Lee', 281, '978-0-06-112008-4', '1960-07-11'),
	(4, 'J.D. Salinger', 224, '978-0-316-76948-4', '1951-07-16'),
	(5, 'J.K. Rowling', 320, '978-0-7475-3269-6', '1997-06-26');


-- Create the table for Audiobooks
DROP TABLE IF EXISTS `Audiobooks`;
CREATE TABLE Audiobooks (
	`MediaID` INT PRIMARY KEY,
    `Author` VARCHAR(255),
    `Narrator` VARCHAR(255),
    `NumCDs` INT,
    `ISBN` VARCHAR(20),
    `PublicationDate` DATE,
    `DurationHours` DECIMAL(5, 2),
    FOREIGN KEY (MediaID) REFERENCES Media (MediaID)
);

INSERT INTO `Audiobooks` (MediaID, Author, Narrator, NumCDs, ISBN, PublicationDate, DurationHours)
VALUES
	(6, 'J.R.R. Tolkien', 'Rob Inglis', 7, '978-0547928227', '1937-09-21', 10.42),
	(7, 'Jane Austen', 'Rosamund Pike', 6, '978-1503290567', '1813-01-28', 6.5),
	(8, 'J.D. Salinger', 'Elijah Wood', 5, '978-0316769488', '1951-07-16', 8.83),
	(9, 'J.R.R. Tolkien', 'Rob Inglis', 12, '978-0618640157', '1954-07-29', 24.50),
	(10, 'J.K. Rowling', 'Stephen Fry', 8, '978-0747532743', '1997-06-26', 7.75);


DROP TABLE IF EXISTS `Holds`;
CREATE TABLE Holds (
    `HoldID` INT PRIMARY KEY auto_increment,
    `MediaID` INT,
    `HoldDatePlaced` DATE,
    `PatronAccountNumber` VARCHAR(255)
) AUTO_INCREMENT=1;

INSERT INTO `Holds` (`MediaID`, `HoldDatePlaced`, `PatronAccountNumber`)
VALUES
	(4, "2024-03-14", "6767782483759364"),
    (4, "2024-04-02", "6767386173652440"),
    (2, "2024-02-28", "6767386173652440"),
    (3, "2024-04-11", "6767577584637331"),
    (1, "2024-04-12", "6767622243265221");
	

DROP TABLE IF EXISTS `Checkouts`;
CREATE TABLE Checkouts (
    `CheckoutID` INT PRIMARY KEY AUTO_INCREMENT,
    `MediaID` INT,
    `PatronAccountNumber` VARCHAR(255),
    `CheckoutDate` DATE,
    `DueDate` DATE
);

INSERT INTO `Checkouts` (MediaID, PatronAccountNumber, CheckoutDate, DueDate)
VALUES
	(1, "6767782483759364", "2024-02-21", "2024-03-21"),
    (4, "6767577584637331", "2023-12-15", "2024-01-15"),
    (7, "6767386173652440", "2024-04-01", "2024-05-01"),
    (11, "6767386173652440", "2024-03-27", "2024-04-27"),
    (2, "6767577584637331", "2024-01-13", "2024-02-13"),
    (14, "123456789123456", "2022-03-07", "2023-04-07");
    
/* isLost Event */
SET GLOBAL event_scheduler = ON;
DELIMITER $$
CREATE EVENT check_lost_books
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    UPDATE Media m JOIN Checkouts c ON m.MediaID = c.MediaID
    SET m.isLost = 1
    WHERE c.DueDate < curdate() - INTERVAL 30 DAY;
END$$
DELIMITER ;

/* Trigger - Automatically Add Due Date Upon New Checkout */
DELIMITER $$
CREATE TRIGGER add_due_date BEFORE INSERT on Checkouts
FOR EACH ROW
BEGIN
	SET NEW.DueDate = DATE_ADD(NEW.CheckoutDate, INTERVAL 1 MONTH);
END$$
DELIMITER ;

/* Creating Index for Media Title */
CREATE INDEX media_title_asc ON media (Title);

/* Delete Events After The Day Passes */
SET GLOBAL event_scheduler = ON;
DELIMITER $$
CREATE EVENT remove_past_events
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    DELETE FROM LibraryEvents
    WHERE EventDate < CURDATE();
END$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
