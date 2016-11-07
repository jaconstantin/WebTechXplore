USE classicmodels;             #go to the classicmodel database

SELECT * FROM customers;       #try out and query the entire customer table





SELECT * FROM employees;       #select all data from employees table
SELECT employeeNumber, email   #select only the employeeNumber and email columns of the employee table
	FROM employees;
    
SELECT DISTINCT lastName       #use select distinct to return only unique row values
	FROM employees             #use order by to sort the entries
	ORDER BY lastName;                      


SELECT DISTINCT                #when select distinct is used with multiple row, the combination of all columns determines the uniquesness of a row
    state, city                #say for this sample, Vic Melbourne and Vic Glen Waverly will be returned
FROM                           #note that the WHERE keyword filters out the row values that is not NULL
    customers
WHERE
    state IS NOT NULL          #LIMIT keyword limits the amount of entries
ORDER BY state , city
LIMIT 10;


 #Where keyword is used to filter in rows that have jobtitle=Sales Rep
 #can form more complicated conditions using logical operators AND OR, and equality operators =, >, <, !=, >=
SELECT 
    lastname, firstname, jobtitle
FROM
    employees
WHERE
    jobtitle = 'Sales Rep' AND officeCode = 1;
    
    
SELECT 
    lastname, firstname, jobtitle, officeCode
FROM
    employees
WHERE
    officeCode > 5;
    

#this time, use the keyword IN, to filter countries that are either USA or France
#can use NOT IN to negate
SELECT 
    officeCode, city, phone, country
FROM
    offices
WHERE
    country IN ('USA' , 'France');


#this time, use IN with a subquery
#note that the subquery returns the list of countries that is not the USA
#that list is then used by the IN statement in the main query

SELECT 
    officeCode, city, phone, country
FROM
    offices
WHERE
    country IN (SELECT 
			country
		FROM
			offices
		WHERE 
			country != "USA");


#in this example, we use the keyword BETWEEN to specify a range to be filtered
SELECT 
	productCode, productName, buyPrice
FROM
	products
WHERE
	buyPrice BETWEEN 90 and 100;

#the LIKE keyword is used to filter using patterns
#the %wildcard matches one or more characters, hence this filters in all firstname starting with a
#_ wildcard matches a single character only, eg 'T_m' -> Tim, Tom, etc...
SELECT 
    employeeNumber, lastName, firstName
FROM
    employees
WHERE
    firstName LIKE 'a%';
    


##use ORDER BY to sort entries in ascending order, can use keyword DESC to have descending
##furthermore, can specify that after sorting by last name, sort each first name (with the same last name)
##in ascending order
#can further specify more columns
SELECT
 contactLastname,
 contactFirstname
FROM
 customers
ORDER BY
 contactLastname DESC,
 contactFirstname ASC;
 
 #here, we specify the order that we want to sort orderNumber
 #we use the status field as the basis of the order, and specified how we want it to get sorted
SELECT 
    orderNumber, status
FROM
    orders
ORDER BY FIELD(status,
        'In Process',
        'On Hold',
        'Cancelled',
        'Resolved',
        'Disputed',
        'Shipped');


##last section here, natural sorting
##when we sort data that is a combination of number and char

CREATE TABLE IF NOT EXISTS items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    item_no VARCHAR(255) NOT NULL
);

INSERT INTO items(item_no)
VALUES ('1'),
       ('1C'),
       ('10Z'),
       ('2A'),
       ('2'),
       ('3C'),
       ('20D');

SELECT 
    item_no
FROM
    items
ORDER BY item_no;

##see that in the result, order by process the string one character at a time, so 10Z comes first before 2 because the first char is 1
##to solve this, separate the numbers and char in two columns, say prefix and suffix, then do the following...
SELECT 
    CONCAT(prefix, suffix)
FROM
    items
ORDER BY prefix , suffix;


##groupBy -> returns unique row entries of Status, similar to SELECT DISTINCT

SELECT 
    status, orderNumber
FROM
    orders
GROUP BY status;

##group by is usually used with an aggregate function
##in this example, we use count to specify the number of orders (or entries) per group of status
SELECT 
    status, COUNT(*)
FROM
    orders
GROUP BY status;
