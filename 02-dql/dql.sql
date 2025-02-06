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