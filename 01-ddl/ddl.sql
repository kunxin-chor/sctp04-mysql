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