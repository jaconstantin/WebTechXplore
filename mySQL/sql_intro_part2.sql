USE classicmodels;             #go to the classicmodel database

SELECT * FROM customers;       #try out and query the entire customer table


##CONCAT_WS function concatenates the lastName and firstName column separated by ', '
##the AS keyword renames the returned column name to an alias
SELECT 
    CONCAT_WS(', ', lastName, firstname) AS `Full name`
FROM
    employees
ORDER BY
	`Full name`;

##here, orderNumber is aliased to Order no. with the AS keyword ommited
##also, the sum function of multiplication of columns is alias to total
##group by and having both makes use of the alias
##cannot use alias in the WHERE keyword because when MySQL eval a where clause, the values of columns spcified in select clause may not be determined yet
##also note, groupby is used together with the sum function
##this will return the distinct row values of orderNumber, and on the total field, it will display the sum of all price*quantity of those having the same orderNumber

SELECT
 orderNumber `Order no.`,
 SUM(priceEach * quantityOrdered) total
FROM
 orderdetails
GROUP BY
 `Order no.`
HAVING
 total > 60000;

SELECT * FROM orderdetails ORDER BY orderNumber;

