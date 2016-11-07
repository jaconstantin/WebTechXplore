CREATE DATABASE IF NOT EXISTS expensetracker; #create schema or database if not exists
USE expensetracker;							  #use your new database
SHOW tables;

CREATE TABLE IF NOT EXISTS user1(             #create a table for user1
	itemID INT AUTO_INCREMENT PRIMARY KEY,    #create userID as the unique primary index, auto increment means it will just count from 1,2,3,etc...
	price INT,            
    description VARCHAR(100)
)ENGINE=InnoDB;                               #MySQL stores various types of table, use this one as it supports transactions

INSERT INTO user1(price,description)          #this is how you insert new entries...
VALUES(10,'breakfast');                       #specify first the order of entry, then set the values...

SELECT * FROM user1;

INSERT INTO user1(price,description)         
VALUES(20,'lunch'), (5,'dinner'); 

INSERT INTO user1(itemID,price,description)  #note here, when explicity specified user ID to be 10, then it counts from 10...
VALUES(10,20,'lunch again');

INSERT INTO user1(price,description)
VALUES(20,'lunch'), (5,'dinner'); 


##this is how you delete a table 
DROP TABLE IF EXISTS user1, user2;
