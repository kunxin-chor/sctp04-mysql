-- creating a new database
-- create database <name of database>
create database swimming_coach;

-- show all the databases on the server
show databases;

-- set the current active database
-- use <name of the database>
use swimming_coach;

-- to create a new table
-- create table <name of table> (
--   <name of column> <data type> <options>
-- ) engine = innodb;

-- all tables must have at least one primary key column
-- and all the values must be unique in the table
-- if a column is not marked with not null then it is optional
-- (exception: primary key)
create table parents (
  parent_id int unsigned auto_increment primary key,
  first_name varchar(200) not null, 
  last_name varchar(200) 
) engine = innodb;

-- show tables
show tables;

-- check the columns in a table
-- describe <name of table>
describe parents;

create table locations (
   location_id int unsigned auto_increment primary key,
   name varchar(255) not null,
   address varchar(255) not null 
) engine = innodb;

-- if you ever need to
-- rename table <old_name> to <new_name>
-- rename table Locations to locations

-- Adding in a new column
-- alter table <name of table> add column <name of column> <data type> <options>
alter table parents add column contact_number varchar(30) not null;

-- Modifying an existing column
-- alter table <name of table> modify column <name of column> <data type> <options>
alter table parents modify column contact_number varchar(50) null default 'n/a';

-- Delete an existing column
alter table parents drop column contact_number;

---- Creating a table with foreign key
-- Create the students table (WITHOUT THE FOREGIN KEY)
create table students (
    student_id int unsigned auto_increment primary key,
    first_name varchar(45) not null,
    last_name varchar(45) default '',
    swimming_level tinyint unsigned,
    dob datetime
) engine = innodb;

-- when creating a foreign key
-- the related primary key and the foregin key must have
-- the same data type
alter table students add column parent_id int unsigned not null;

-- define the parent_id column as a foreign key
-- that refers to the parent_id column in the parents table

-- add constraint: a constraint is a rule in SQL
-- (eg. the UNIQUE constraint ensures that a value is not repeated in a column)
alter table students add constraint fk_parents_students
   foreign key (parent_id) references parents(parent_id);

-- a schema file in a relational databae is a .sql file that only has create tables
-- and alter tables (or drop tables). the intent of the file is for people to create tables
-- in a database quickly

-- INSERT ROWS
-- insert into <table name> (<col1>, <col2>, <col3>....) VALUES (value for col 1, value for col 2, value for col 3...)
INSERT INTO parents (first_name, last_name) VALUES ("Jon", "Snow");

-- See all the rows from a table
SELECT * FROM parents;

-- Insert multiple rows
INSERT INTO parents (first_name, last_name) VALUES ("Mary", "Sue"),
 ("Ah Kow", "Tan"), 
 ("Peter", "Barker");

 -- Insert a new student with a foregin key
 INSERT INTO students (first_name, last_name, swimming_level, dob, parent_id)
 VALUES ('Ah Mew', 'Tan', 1, '2019-06-28',  3 );

 -- Update an existing row's data
 -- UPDATE <table name> SET col = <new value> WHERE ....
 -- WHERE is VERY IMPORTANT
 UPDATE parents SET first_name = "John" WHERE parent_id=1;

 -- DELETE an existing row from a table
 -- If we just want to delete one single specific row
 -- it's best that we delete by the primary key (aka the id column)
 DELETE FROM parents WHERE parent_id = 4;