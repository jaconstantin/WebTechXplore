CREATE DATABASE IF NOT EXISTS expensetracker; #create schema or database if not exists
USE expensetracker;							  #use your new database
SHOW tables;

DROP TABLE IF EXISTS user1;

CREATE TABLE IF NOT EXISTS user1(                            #create a table for user1
    entryDate DATE NOT NULL,                                 #native data and time data types of MySQL
    entryTime TIME NOT NULL,
	prCurrency CHAR(4) NOT NULL,                             #fixed 4-char length string to hold currency, fixed storage size 
    prValue DECIMAL(19,4) NOT NULL,                          #fixed point decimal, 15 digits for whole number, 4 digits for decimal to be compliant with accounting principles, where rounding is less than 0.01 
    description VARCHAR(100) NOT NULL,                       #a 100-character string
    
    PRIMARY KEY(entryDate,entryTime)                         #define the combination of date and time as the primary key, as this database assumes you can only have one expenditure per second
                                                             #this should be unique, and is automatically used for indexing
)ENGINE=InnoDB;                                       #note that VARCHAR can hold a much larger max character, it is stored as 1-2byte prefix plus data, where the prefix specifies the length
													  #also, the storage alloted to varchar depends on the actual length of data. It can save space if say description length can vary by a lot per entry

													  #also want to put in here indexing....

INSERT INTO user1(entryDate, entryTime, prCurrency, prValue, description)
VALUES ('2015-01-02' ,'00:45:23' ,'Php' ,450, 'judy anne crispy pata'),
('2015-01-02' ,'01:23:40' ,'Php' ,600, 'greenwich party sphagetti'),
('2015-03-04' ,'02:15:07' ,'Php' ,950, 'contis mango bravo'),
('2015-03-05' ,'03:30:03' ,'Php' ,350, 'Nuvali bike rental'),
('2015-03-05' ,'04:45:32' ,'Php' ,4300.25, 'Nike hoodie jacket'),
('2015-03-05' ,'05:50:12' ,'Php' ,3400.2, 'tommy girl perfume for lorraine'),
('2015-11-13' ,'06:20:06' ,'Php' ,430, 'rebook shorts gift to papa'),
('2015-11-13' ,'06:21:06' ,'Php' ,934.12, 'tour le jours dark choco mousse'),
('2016-02-05' ,'01:34:00' ,'Php' ,30234.5, 'Japan Airfare'),
('2016-02-07' ,'20:34:00' ,'Php' ,1240.52, 'Valentines dinner date'),
('2016-02-10' ,'08:30:23' ,'Php' ,340.25, 'McDonalds Breakfast'),
('2016-02-10' ,'09:45:13' ,'Php' ,1340, 'Shell Gas up'),
('2016-02-10' ,'11:32:00' ,'Php' ,5043.1, 'Nike Air Hoodie'),
('2016-02-10' ,'12:01:34' ,'Php' ,500.32, 'Kenny Rogers Lunch'),
('2016-02-10' ,'22:15:05' ,'Php' ,1034, 'Dinner 7/11 kyoto'),
('2016-02-11' ,'06:45:12' ,'Php' ,5034, 'Kyoto Pass'),
('2016-02-11' ,'07:05:29' ,'Php' ,450.23, 'Breakfast at yoshinoya'),
('2016-02-11' ,'10:34:09' ,'Php' ,900, 'Takuyaki and Yakitori snack'),
('2016-02-11' ,'01:26:03' ,'Php' ,1200, 'Toei Studio Park ticket'),
('2016-02-11' ,'19:34:56' ,'Php' ,2400, 'Dinner at Kurasushi'),
('2016-05-02' ,'10:23:00' ,'Php' ,1000, 'Ate Daisy Birthday gift'),
('2016-05-02' ,'11:45:08' ,'Php' ,1600, 'Birthday Lunch at vikings'),
('2016-05-02' ,'15:25:08' ,'Php' ,7800, 'Exclusively His Wedding Coat'),
('2016-05-05' ,'14:12:43' ,'Php' ,20000, 'Sulo Riviera downpayment'),
('2016-05-06' ,'09:25:56' ,'Php' ,20000, 'Awi Photography downpayment'),
('2016-08-04' ,'12:13:06' ,'Php' ,1900, 'change oil'),
('2016-08-04' ,'13:13:06' ,'Php' ,300, 'fan belt'),
('2016-08-05' ,'23:54:00' ,'Php' ,500, 'lady xtine'),
('2016-08-06' ,'18:43:59' ,'Php' ,100.34, 'the game of thrones'),
('2016-08-06' ,'18:45:59' ,'Php' ,200.36, 'pamana crispy adobo'),
('2016-08-06' ,'18:50:59' ,'Php' ,20000, 'HP pavillion'),
('2016-08-06' ,'19:43:59' ,'Php' ,8500, 'rent'),
('2016-08-06' ,'20:43:59' ,'Php' ,1037.65, 'general trias water'),
('2016-09-04' ,'22:38:53' ,'Php' ,1200, 'dell laptop bag'),
('2016-09-07' ,'22:08:04' ,'Php' ,300, 'Yummy chocolate'),
('2016-09-11' ,'14:25:28' ,'Php' ,500, 'lunch at Romeos'),
('2016-09-11' ,'15:17:54' ,'Php' ,34.01, 'hello chocolate'),
('2016-09-12' ,'11:19:27' ,'Php' ,33500, 'dell inspiron 7000'),
('2016-09-12' ,'11:19:28' ,'Php' ,2500, 'Microsoft Office 365'),
('2016-09-12' ,'11:19:50' ,'Php' ,500, 'lunch at Romeos Grill');


##to insert additional entries
INSERT INTO user1(entryDate, entryTime, prCurrency, prValue, description)
VALUES ('2016-09-12' ,'11:20:50' ,'Php' ,500, 'dinner at Melbourne');

##to delete an entry, can specifically specify 
DELETE FROM 
	user1
WHERE
	entryDate = '2016-09-12' AND entryTime = '11:19:50';


SELECT * FROM user1;

##here let us try querying for specific entries only

#PartA specify a date range

SELECT * FROM 
	user1
WHERE
	entryDate IS NOT NULL AND                              #equality operators returns unknown when operated with NULL
	entryDate BETWEEN '2015-07-20' and '2016-07-20';


##PartB Display per day
##note here, group by will only return unique row date values
##need to use aggregate sum function, so that the total expense per day is displayed...
SELECT 
	entryDate, prCurrency, SUM(prValue) AS dayTotal
FROM
	user1
GROUP BY entryDate;

##so now, how do we group by month and year?
##use the function MONTH and YEAR!
SELECT 
	MONTH(entryDate), YEAR(entryDate), prCurrency, SUM(prValue) AS monthTotal
FROM
	user1
GROUP BY YEAR(entryDate),MONTH(entryDate);

