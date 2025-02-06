-- Select all rows and tables
-- SELECT <table> FROM <table>
-- * means ALL THE COLUMNS

-- List all the employees and all their columns
select * from employees;

-- Select specific columns
SELECT firstName, lastName, email  FROM employees;

-- Rename the columns after the select
SELECT firstName AS 'First Name', lastName AS 'Last Name', email AS 'Email' FROM employees;

-- filtering: only want a subset of the rows 
-- only show the employees from officeCode 1
SELECT * FROM employees WHERE officeCode=1;

-- Only show customers that are from France
SELECT * FROM customers WHERE country = "France";

-- Show only specific columns (and rename them)
-- from specific rows
-- Show only customer name, phone and country for all customers from France
SELECT customerName AS "Customer Name", phone as "Phone", country as "Country" 
FROM customers 
WHERE country="France";


-- We want to select all employees that have the word 'sales' in their job title
-- LIKE allows us to match by string patterns
-- % ==> ANYTHING OF ANY LENGTH
SELECT * FROM employees WHERE jobTitle LIKE "%sales%";

-- find all the comments that have the word "complain" from the orders table
SELECT * FROM orders WHERE comments LIKE "%complain%";


-- JOINS
-- get all the employee's first, last name and their office address: address, country and state
-- joins will always happen first
-- so select and where will happen on the JOINed table
SELECT firstName, lastName, city, addressLine1, addressLine2, state, country FROM employees JOIN offices
  ON employees.officeCode = offices.officeCode

  -- get all the employee's first, last name and their office address: address, country and state
-- joins will always happen first
-- so select and where will happen on the JOINed table
SELECT firstName, lastName, city, employees.officeCode, 
  addressLine1, addressLine2, state, country 
FROM employees JOIN offices
ON employees.officeCode = offices.officeCode

-- WHERE happens on the JOINED table (WHERE happens after JOIN)
SELECT * FROM orders JOIN orderdetails ON 
	orders.orderNumber = orderdetails.orderNumber
WHERE orders.orderNumber = 10100;

-- INNER JOIN: when we do an inner join, both sides must have a corresponding
-- partner row before it will appear in the results
SELECT firstName, lastName, email, customerName FROM employees  JOIN customers
 ON employees.employeeNumber = customers.salesRepEmployeeNumber
 WHERE country = "France";


-- LEFT JOIN
-- All the rows from the left hand side of the join WILL BE included in the results
SELECT * FROM customers  LEFT JOIN
  employees on customers.salesRepEmployeeNumber = employees.employeeNumber;

-- RIGHT JOIN
-- All the rows from the left hand side of the join WILL BE included in the results
SELECT * FROM customers  RIGHT JOIN
  employees on customers.salesRepEmployeeNumber = employees.employeeNumber;

-- DATE AND TIME MANIPULATION
-- It will be based on server's timezone, frequently UTC
-- Get the current date
select curdate();

-- Get the current date and time
select now();

-- get all the payments made after 30th June 2003
select * from payments where paymentDate > "2003-06-30";

-- get all the payments made btween 30th June 2003 and first Jan 2004
select * from payments where paymentDate >= "2003-06-30" AND paymentDate <="2004-01-01";

-- get the exact components of date
-- for every payment, we want to know which YEAR it is made in
-- the year() returns the YEAR that the data is in
select customerNumber, checkNumber, year(paymentDate) FROM payments;

-- for every payment, show which month and which year is made in
select customerNumber, checkNumber, year(paymentDate), month(paymentDate) FROM payments;

-- show all the payments made in the year of 2004
SELECT * from payments where year(paymentDate) = 2004;

-- AGGREGATE FUNCTIONS
-- Operate on a column and they return (simplify to a numerical result)
-- Find the sum of all the payment
select sum(amount) from payments;

-- Find the average of all the payment
select avg(amount) from payments where year(paymentDate) = 2004;

-- Find the min (lowest amount) of all the payment
select min(amount) from payments where year(paymentDate) = 2004;

-- Find the max (max amount) of all the payment
select max(amount) from payments where year(paymentDate) = 2004;

-- Count how many payments were made in the year 2004
select count(*) from payments where year(paymentDate) = 2004;

-- REVISION
-- Find the total amount of payment made in the year of 2004 Feb for customers in the USA
select SUM(amount) from payments  JOIN customers
  ON payments.customerNumber = customers.customerNumber
  WHERE country="USA" AND YEAR(paymentDate) = 2004 AND MONTH(paymentDate) = 2;

-- LOGICAL OPERATORS

-- AND: both left hand side and right hand side must be true
-- x AND y ==> only if x is true and y is true, then the "x AND y" ==> true

-- Find customers in the USA which credit limit is more than 10000
SELECT * FROM customers WHERE country="USA" AND creditLimit > 10000;

-- Find customers in the USA which credit limit is more than 10000 AND the name include the 
-- word "toys"
SELECT * FROM customers WHERE country="USA" AND creditLimit > 10000
   AND customerName LIKE "%toy%"

-- Find all the employees from officeCode 1 or officeCode 2
SELECT * FROM employees WHERE officeCode = 1 OR officeCode = 2 

-- find all the customers with credit limit > 100K or from France or From USA

SELECT * FROM customers WHERE creditLimit > 100000 OR country = "France" or country = "USA";

-- find all customers from the USA where their credit limit is more than 50K
-- OR any customer from France (AND has higher precedence than OR so for clarity surround the AND togehter)
SELECT * FROM customers WHERE (country="USA" AND creditLimit > 50000) OR country="France";

-- find all customers from the country  USA or France and the credit limit must be more than 50K

SELECT * FROM customers WHERE (country = "USA" OR country="France") AND creditLimit > 50000;

-- find all customers from the  USA or France and has credit limit must be more than 50K
-- OR from Brazil with credit limit lesser than 50K
SELECT * FROM customers WHERE (country = "USA" OR country="France") AND creditLimit > 50000
 OR (country="Brazil" AND creditLimit < 50000);


 -- SORT RESULTS
 -- show all the customers sorted by their creditLimit (ascending order, lowest to highest)
SELECT * FROM customers ORDER BY creditLimit;

-- show all the customers sorted by their creditLimit
SELECT * FROM customers ORDER BY creditLimit DESC;

-- show all the customers from the USA sorted by their creditLimit in the descending order
SELECT customerName, creditLimit FROM customers 
WHERE country="USA"
ORDER BY creditLimit DESC;

-- show all the customers and the name of their sales rep from the USA sorted by their creditLimit in the descending order
-- only interested in the top three
SELECT customerName, creditLimit, employees.firstName, employees.lastName FROM customers JOIN employees
  ON customers.salesRepEmployeeNumber = employees.employeeNumber
WHERE country="USA"
ORDER BY creditLimit DESC
LIMIT 3;

-- For each office, show how many employees there are
SELECT officeCode, COUNT(*) FROM employees
GROUP BY officeCode;

-- For each country, show how many customers there are
SELECT country, COUNT(*)
FROM customers
GROUP BY country;

-- For each country, show their average credit limit of all the customers
-- 1. figure out which column which grouping by
-- 2. all group by WILL use aggregate functions: count, sum, avg, min or max
--    WHICH ONE?
-- 3. WHATEVER WE GROUP BY, WE HAVE TO SELECT
SELECT country, avg(creditLimit) FROM customers
GROUP BY country;

-- For each office, show the city, state and country and how many employees there are
SELECT COUNT(*), employees.officeCode, city, state, country FROM employees JOIN offices
  ON employees.officeCode = offices.officeCode
  GROUP BY employees.officeCode, city, state, country;

  -- For each office, show the city, state and country and how many employees there are
-- but only for offices not in the USA and have at least 3 employees
SELECT COUNT(*) AS "Employee Count", employees.officeCode, city, state, country FROM employees JOIN offices
  ON employees.officeCode = offices.officeCode
  WHERE country != "USA"
  GROUP BY employees.officeCode, city, state, country
  HAVING `Employee Count` > 2;  -- backtick is reserved for column names


-- find the top three best performing salesman in the year of 2004
-- and only those with at least 100K in revenue are considered
SELECT employeeNumber, firstName, lastName, SUM(amount) AS "total_revenue" FROM employees JOIN customers
    ON employees.employeeNumber = customers.salesRepEmployeeNumber
  JOIN payments
    ON customers.customerNumber = payments.customerNumber
  WHERE YEAR(paymentDate) = "2004"
GROUP BY employeeNumber, firstName, lastName
HAVING total_revenue > 100000
ORDER BY total_revenue DESC
LIMIT 3;
