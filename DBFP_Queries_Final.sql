-- QUERIES FOR CHECKOUTS ------------------------------------------------------------

-- Delete Checkouts with patron accounts that don't exist
Delete From Checkouts
Where PatronAccountNumber NOT IN 
	(SELECT `PatronAccountNumber` FROM Patrons);
    
-- Display the names of patrons who have past due checkouts, its due date, and the associated Title.
Select Patrons.name, Checkouts.DueDate, Media.Title
FROM Patrons
JOIN Checkouts
ON Patrons.`PatronAccountNumber` = Checkouts.PatronAccountNumber
JOIN Media
ON Checkouts.MediaID = Media.MediaID
WHERE Media.MediaID IN (
	Select MediaID from Checkouts
	Where DueDate < NOW()
);

-- Set the due date for all past-due checkouts to a month from now
Update Checkouts
Set DueDate = DATE_ADD(NOW(), INTERVAL 1 MONTH)
Where DueDate < NOW();


-- QUERIES FOR HOLDS ------------------------------------------------------------------------

-- Select media by the amount of holds each has
Select Media.Title, COUNT(*) AS `Number of Holds` from Holds
JOIN Media
ON Holds.MediaID = Media.MediaID
GROUP BY Holds.MediaID;

-- Change a hold from one piece of media to another
Update Holds
Set MediaID = 10
Where MediaID = 4
AND PatronAccountNumber ="6767782483759364";

-- Delete Holds on Items that are not checked out
Delete From Holds
Where MediaID NOT IN (
	Select MediaID FROM Checkouts
);
Select * From Holds;

-- Stored Procedure -------------------------------------------
DROP PROCEDURE IF EXISTS ShowHoldsFor;

-- STORED PROCEDURE Show the names of all patrons who have a hold on a specified piece of media
delimiter //

CREATE PROCEDURE ShowHoldsFor(IN MID INT)
BEGIN
	SELECT name, `PatronAccountNumber` FROM Patrons
    WHERE `PatronAccountNumber` IN (
		SELECT PatronAccountNumber FROM Holds
        WHERE MediaID = MID);
END //

delimiter ;

CALL ShowHoldsFor(4);
Call ShowHoldsFor(2);

-- Attendees Queries ----------------------------------------------

-- Show the number of attendees for each event
Select EventID, COUNT(*) As "Number of Attendees"
From Attendees
GROUP BY EventID;


-- Fake Data For Query; Event does not exist
INSERT INTO Attendees (EventID, PatronID)
VALUES
	(7, 2);

-- Delete entries for events that no longer exist
Delete From Attendees
Where EventID NOT IN (
	Select EventID From LibraryEvents
);

-- Update attendee ID to a new ID
Update Attendees
SET PatronID = 1
WHERE PatronID = 2
AND EventID = 2;

/* MEDIA TABLE QUERIES ---------------------------------------------------------------------  */

/* Selecting by Genre */
SELECT * FROM library.Media WHERE GENRE = "Classic";

/* Delete Media if Lost For 6+ Months */
DELETE FROM Media
WHERE MediaID IN (
	SELECT * FROM (
		SELECT m.MediaID FROM Media m
		JOIN Checkouts c ON m.MediaID = c.MediaID
		WHERE m.IsLost = 1
		AND c.DueDate <= DATE_SUB(curdate(), INTERVAL 6 MONTH)
	) AS subquery
);


/* Add New Barcode # To New Copy */
UPDATE Media
SET BarCodeNumber = CONVERT(FLOOR(RAND() * 90000000000000 + 10000000000000), CHAR)
WHERE MediaID IN (
	SELECT * FROM (
		SELECT MediaID FROM Media
		WHERE BarCodeNumber IS NULL
	) as subquery
);

/* EVENT TABLE QUERIES ---------------------------------------------------------- */

/* Select Most Recent Upcoming Events */
SELECT * FROM LibraryEvents
WHERE EventDate >= CURDATE() AND EventDate < DATE_ADD(CURDATE(), INTERVAL 2 WEEK);

/* Update Employee ID if Person in Charge Changes */
UPDATE LibraryEvents
SET ManagedByID = '2'
WHERE ManagedByID = '3';

-- Patron Table Queries -------------------------------------------------------------

-- Determining the top 3 Patrons that have the largest fines
SELECT * FROM Patrons ORDER BY fines DESC LIMIT 3;

-- Looking patron up by info
SELECT * FROM Patrons WHERE address = '4414 Eu Ave' AND  phone = '(839) 885-1834';

-- If not active for 5 years, delete Patron
Delete from Patrons 
Where `account number` NOT IN
        (SELECT PatronAccountNumber from Checkouts
        WHERE CheckoutDate >= DATE_ADD(NOW(), INTERVAL -5 YEAR))
    AND `account number` NOT IN
            (SELECT PatronAccountNumber from Holds
            WHERE HoldDatePlaced >= DATE_ADD(NOW(), INTERVAL -5 YEAR))
    AND id NOT IN
            (SELECT PatronID from Attendees
            WHERE EventID IN
                (SELECT EventID FROM LibraryEvents 
                WHERE EventDate >= DATE_ADD(NOW(), INTERVAL -5 YEAR))
            );

--  Updating specific Patron info 
UPDATE Patrons 
SET name= 'Bruce Wayne', phone = '(609) 822-8576', address = '86 Gotham Rd', postalZip ='09090' 
WHERE id = 3;
SELECT * FROM Patrons;

-- Employee Table  -----------------------------------------------------------------------

--  Determine Seniority by birthday 
SELECT * FROM Employees  ORDER BY STR_TO_DATE(birthday, '%b %d, %Y');

-- Deleting Employees by id when they are leaving the system
DELETE FROM Employees WHERE id = 1;
SELECT * FROM Employees;

-- Updating everyone's wages by 20%
UPDATE Employees SET wage = (wage * .2) + wage;
SELECT * FROM Employees;

-- Or updating by specific employee
UPDATE Employees SET wage = (wage * .2) + wage WHERE id = 4;
SELECT * FROM Employees;

-- Updating specific Employee info 
UPDATE Employees 
SET name= 'Ariel TheMermaid', address = ' 50 DisneyWorld Lane', postalZip ='1236', title = 'Resident Princess'
WHERE id = 4;
SELECT * FROM Employees;

-- Search books by publication date range ----------------------------------------------------
SELECT * FROM BOOKS;
SELECT * FROM BOOKS JOIN Media USING (MediaId) WHERE publicationDate BETWEEN '1900-12-31' AND '1950-12-31';

-- Search books by amount of pages EX: 300+
SELECT * FROM BOOKS;
SELECT * FROM BOOKS JOIN Media USING (MediaId) WHERE Pages > 300;

-- Search AudioBooks by duration EX: < 10 hours
SELECT * FROM Audiobooks;
SELECT * FROM Audiobooks JOIN Media USING (MediaId) WHERE DurationHours < 10.00;

-- Search AudioBooks by specific narrator
SELECT * FROM Audiobooks JOIN Media USING (MediaId) WHERE Narrator = 'Elijah Wood';

-- Search AudioBooks by publication date range
SELECT * FROM Audiobooks JOIN Media USING (MediaId) WHERE  publicationDate BETWEEN '1800-12-31' AND '1940-12-31';

-- Search DVDs by duration EX: < 2hrs
SELECT * FROM Dvds JOIN Media USING (MediaId) WHERE Duration <  '02:00:00';

-- Search DVDs by Year Released Range EX: 1908-1990
SELECT * FROM Dvds JOIN Media USING (MediaId) WHERE YearReleased BETWEEN 1980 AND 1990;

-- Search DVDs by specific Director EX: Christopher Nolan
SELECT * FROM Dvds JOIN Media USING (MediaId) WHERE Director = 'Christopher Nolan';


