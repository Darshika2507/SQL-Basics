-- Q.1. Create a table called employees with the following structure?
-- : emp_id (integer, should not be NULL and should be a primary key)Q
-- : emp_name (text, should not be NULL)Q
-- : age (integer, should have a check constraint to ensure the age is at least 18)Q
-- : email (text, should be unique for each employee)Q
-- : salary (decimal, with a default value of 30,000).
-- Write the SQL query to create the above table with all constraints.

-- ANSWER:

create database PW_Skills_Assignment;
use PW_Skills_Assignment;
create table employees;
CREATE TABLE employees (
    emp_id INT NOT NULL PRIMARY KEY,
    emp_name TEXT NOT NULL,
    age INT CHECK (age >= 18),
    email varchar(200) UNIQUE,
    salary DECIMAL(10,2) DEFAULT 30000
);
describe employees;

 /* Q.2. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide
examples of common types of constraints.

-- ANSWER:

--Purpose of Constraints
Constraints serve as the backbone for maintaining data integrity within a database. They work by: 
Ensuring data accuracy: By defining acceptable data formats and values, constraints prevent incorrect or nonsensical data from being stored. 
Maintaining data consistency: Constraints guarantee that data across different tables and within the same table is reliable and follows a logical structure. 
Preventing invalid operations: When a data entry, update, or deletion violates a constraint, the operation is rejected, protecting the database from damage. 
Defining relationships: Constraints establish and maintain the links between different tables, ensuring that relationships remain valid and preventing "orphaned" records.  

How Constraints Maintain Data Integrity
Constraints are enforced at the database level, acting as automatic guardians for your data. 
They validate every new piece of data, whether it's being inserted or updated. 
If a data action conflicts with a defined rule, the database system will prevent that action, ensuring that only valid data is stored. 

Examples of Common Constraint Types
PRIMARY KEY: A combination of a NOT NULL and a UNIQUE constraint, it uniquely identifies each record in a table. 
Example: A customer_id column might be a primary key to ensure every customer has a unique identifier and that no customer record lacks an ID. 
FOREIGN KEY: This constraint establishes a link between two tables by ensuring that values in one table's column(s) match values in another table's primary key. 
Example: An order_id in an orders table might be a foreign key referencing the customer_id in the customers table to ensure an order is always associated with a valid customer. 
UNIQUE: This constraint prevents duplicate values from being entered into a specific column or set of columns. 
Example: An email column could have a unique constraint to ensure that no two customers share the same email address. 
NOT NULL: This rule ensures that a column cannot have a NULL (empty) value. 
Example: A registration_date column could be marked as NOT NULL to guarantee that every registered user has a registration date recorded. 
CHECK: This constraint specifies a condition that all values in a column must meet. 
Example: A price column might have a CHECK constraint that ensures the value is always greater than zero, preventing invalid negative prices. 

--Q.3.Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify
your answer. 

-- ANSWER: You apply the NOT NULL constraint to a column to ensure it always contains a value,
 preventing empty or unknown data from being inserted and maintaining data integrity. 
 A primary key cannot contain NULL values because its fundamental purpose is to uniquely identify each row, 
 and a NULL value would make that identification impossible and defeat the purpose of having a key. 

Why apply the NOT NULL constraint?
Ensures data integrity: It guarantees that a column will always have a value, which is essential for columns where a value is always required, such as an email address or a product name. 
Verifies data quality: It prevents incorrect or incomplete data from entering the database, helping to maintain the accuracy and reliability of your data. 
Mandatory fields: For any column that represents a mandatory piece of information, the NOT NULL constraint ensures that this information is always provided. 
Performance benefits: In some cases, a NOT NULL constraint can improve query performance by helping the database optimizer. 

Can a primary key contain NULL values? 
No, a primary key cannot contain NULL values .
Justification:
Unique identification: The primary role of a primary key is to serve as a unique identifier for every record (row) in a table. If a primary key were allowed to be NULL, it would mean the identifier for that record is unknown or missing, which defeats the purpose of unique identification.
Database system enforcement: When a primary key is defined, the database system automatically enforces the NOT NULL constraint on that column, even if it wasn't explicitly stated.
Meaning of NULL: NULL in SQL represents an unknown or missing value. A primary key must be a definitive value to be useful for distinguishing rows.

-- Q.4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an example for both adding and removing a constraint.

-- ANSWER: Adding and removing constraints on an existing SQL table involves using the ALTER TABLE statement,
 which is part of the Data Definition Language (DDL).
 Adding a Constraint
Identify the constraint type and columns: Determine which type of constraint (e.g., PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK, NOT NULL) is needed and which columns it will apply to.
Choose a constraint name (optional but recommended): Providing a name for the constraint makes it easier to manage and drop later.
Use ALTER TABLE ADD CONSTRAINT: Execute the ALTER TABLE statement with the ADD CONSTRAINT clause, specifying the table name, the chosen constraint name, and the constraint definition.
 
 Example of Adding a Constraint (UNIQUE):
To add a UNIQUE constraint named UC_Email to the Email column of an Employees table:*/

ALTER TABLE Employees
ADD CONSTRAINT UC_Email UNIQUE (Email);

-- /*Removing a Constraint
/*Identify the constraint name: You need to know the exact name of the constraint you want to remove. If you don't know it, you might need to query the database's metadata (e.g., INFORMATION_SCHEMA.KEY_COLUMN_USAGE in MySQL, SHOW CONSTRAINTS FROM table_name in CockroachDB, or system views in SQL Server/Oracle) to find it.
Use ALTER TABLE DROP CONSTRAINT: Execute the ALTER TABLE statement with the DROP CONSTRAINT clause, specifying the table name and the name of the constraint to be removed. 

Example of Removing a Constraint (UNIQUE):
To remove the UC_Email constraint from the Employees table:*/

ALTER TABLE Employees
DROP CONSTRAINT UC_Email;

/*Important Considerations:
Data Validity: When adding a constraint, ensure that existing data in the table adheres to the new constraint's rules. If not, the ALTER TABLE statement will fail.
Foreign Key Dependencies: When dropping a primary key or unique constraint that is referenced by a foreign key in another table, you might need to drop the foreign key constraint first.
Performance: Adding or dropping constraints on large tables can be a resource-intensive operation and may lock the table during the process. 

--Q.5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints.
Provide an example of an error message that might occur when violating a constraint.

ANSWER:Attempting to insert, update, or delete data in a way that violates database constraints results in the rejection of the operation and the generation of an error. This mechanism ensures data integrity and consistency within the database.

Consequences of Constraint Violation:
Operation Rejection: The most immediate consequence is the failure of the INSERT, UPDATE, or DELETE statement. The database management system (DBMS) will prevent the invalid data from being committed.
Error Message: The DBMS will return an error message indicating the specific constraint that was violated and often providing details about the nature of the violation (e.g., duplicate key, foreign key not found, check constraint violation).
Data Integrity Preservation: This rejection is crucial for maintaining the defined rules and relationships within the database, preventing inconsistent or invalid data from corrupting the system.
Application-Level Handling: Applications interacting with the database must be designed to catch and handle these constraint violation errors gracefully, informing the user of the issue and potentially suggesting corrective actions.

Example Error Message (PostgreSQL):
Consider a table Employees with a PRIMARY KEY on employee_id and a FOREIGN KEY on department_id referencing a Departments table.*/

CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) UNIQUE
);departments

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department_id INT,
    CONSTRAINT fk_department
        FOREIGN KEY (department_id)
        REFERENCES Departments (department_id)
);

INSERT INTO Departments (department_id, department_name) VALUES (101, 'Sales');

/*Scenario 1: Violating a Primary Key Constraint (Duplicate employee_id)*/

INSERT INTO Employees (employee_id, employee_name, department_id) VALUES (1, 'Alice', 101);
INSERT INTO Employees (employee_id, employee_name, department_id) VALUES (1, 'Bob', 101); -- Attempt to insert duplicate primary keyemployees

/*Error Message:*/
ERROR:  duplicate key value violates unique constraint "employees_pkey"
DETAIL:  Key (employee_id)=(1) already exists.

/*Scenario 2: Violating a Foreign Key Constraint (Non-existent department_id)*/

INSERT INTO Employees (employee_id, employee_name, department_id) VALUES (2, 'Charlie', 999); -- Attempt to reference non-existent department_id;

/*Error Message:*/
ERROR:  insert or update on table "employees" violates foreign key constraint "fk_department"
DETAIL:  Key (department_id)=(999) is not present in table "departments".

/*Q.6. You created a products table without constraints as follows:

CREATE TABLE products (

    product_id INT,

    product_name VARCHAR(50),

    price DECIMAL(10, 2));  
Now, you realise that?
: The product_id should be a primary keyQ
: The price should have a default value of 50.00 
 
ANSWER:*/
ALTER TABLE products
ADD PRIMARY KEY (product_id);
ALTER TABLE products
ALTER COLUMN price SET DEFAULT 50.00;
/*Explanation

ADD CONSTRAINT pk_product PRIMARY KEY (product_id)
→ Makes product_id the primary key (unique + not null).

ALTER COLUMN price SET DEFAULT 50.00
→ Ensures if price is not specified, it defaults to 50.00.

Q.7.  You have two tables:
Write a query to fetch the student_name and class_name for each student using an INNER JOIN.*/
use pw_skills_assignment;
create table student
(student_id char(10),
student_name varchar(30),
class_id char(15));
insert into student values
("1","Alice","101"),
("2","Bob","102"),
("3","Charlie","103");
select * from student;
create table classes
(class_id char(15),
class_name varchar(20));
insert into classes values
("101","Maths"),
("102","Science"),
("103","History");
select*from classes; 
use pw_skills_assignment;
use classes;
use student;
SELECT
    s.student_name,
    c.class_name
FROM
    students AS s
INNER JOIN
    classes AS c ON s.class_id = c.class_id;
    
/* Q.8. Consider the following three tables:  
Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are
listed even if they are not associated with an order 

Hint: (use INNER JOIN and LEFT JOIN).

ANSWER: */
create table orders
(order_id char(10),
order_date char(15),
customer_id char(10));
insert into orders values
("1","2024-01-01","101"),
("2","2024-01-03","102");
describe orders;
create table Customers
(customer_id char(10),
customer_name varchar(20));
insert into Customers values
("101","Alice"),
("102","Bob");
describe Customers; 
create table Products
(product_id char(10),
product_name varchar(20),
order_id char(10));
insert into Products values
("1","Laptop","1"),
("2","Phone","NULL");
describe Products;
SELECT 
    o.order_id,
    c.customer_name,
    p.product_name
FROM Products p
LEFT JOIN Orders o 
    ON p.order_id = o.order_id
LEFT JOIN Customers c
    ON o.customer_id = c.customer_id;
    
 /*Q.9 Given the following tables: 
Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.
ANSWER:*/
create table sales
(sale_id char(10),
product_id char(15),
amount char(20));
insert into sales values
("1","101","500"),
("2","102","300"),
("3","103","700");
describe sales;
SELECT p.product_id,
       p.product_name,
       SUM(s.amount) AS total_sales
FROM Sales s
INNER JOIN Products p
  ON s.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY p.product_id;
/*Q.10. You are given three tables:
Write a query to display the order_id, customer_name, and the quantity of products ordered by each
customer using an INNER JOIN between all three tables.
ANSWER:*/
create table Order_details
(order_id char(10),
product_id char(15),
quantity char(10));
insert into Order_details values
("1","101","2"),
("2","102",	"1"),
("3","103","3");
describe Order_details;
SELECT o.order_id,
       c.customer_name,
       od.quantity
FROM Orders   o
INNER JOIN Order_Details od ON o.order_id = od.order_id
INNER JOIN Customers c      ON o.customer_id = c.customer_id;
/* SQL COMMANDS 
 Q.1-Identify the primary keys and foreign keys in maven movies db. Discuss the differences.
 ANSWER:Maven Movies Database (Sakila-style DB)
This sample database (often used for practice) has multiple tables like film, actor, customer, rental, payment, inventory, etc.
In the hypothetical Maven Movie DB, primary keys like movie_id and genre_id uniquely identify each record within their respective movies and genres tables, while foreign keys, such as the genre_id in a movie_genre_mapping table, link related records across tables by referencing a primary key in another table to maintain data integrity and enforce relationships. The key differences lie in their function: primary keys guarantee uniqueness and non-null values for a table's records, whereas foreign keys create relationships by referencing primary keys, can contain nulls, allow duplicates, and ensure referential integrity between tables.  
Primary Key (PK)
A primary key is a column or set of columns that uniquely identifies each row in a database table. 
Purpose: To provide a unique identifier for each record.
Uniqueness: Must contain unique values; no two rows can have the same primary key value.
Null Values: Cannot contain NULL values.
Number per Table: A table can have only one primary key.
Role: Often described as the "parent" table's key.
Foreign Key (FK)
A foreign key is a column or set of columns in one table that establishes a link to a primary key in another table. 
Purpose: To link two tables and maintain referential integrity.
Uniqueness: Can contain duplicate values.
Null Values: Can contain NULL values.
Number per Table: A table can have multiple foreign keys.
Role: The "child" table's key, which references the "parent" table's primary key.
Key Differences
Uniqueness vs. Relationships: A primary key guarantees the uniqueness of records within a table, while a foreign key establishes a relationship between tables. 
Nulls Allowed: Primary keys cannot be null, but foreign keys can. 
Duplicates: Primary keys do not allow duplicate values, but foreign keys do. 
Quantity: Each table has one primary key but can have many foreign keys. 
Referential Integrity: Foreign keys enforce referential integrity by ensuring that the value in the foreign key column exists in the referenced primary key column of the parent table. 

Q.2- List all details of actors.
ANSWER:*/
select*from actor;

/*Q.3 List all customer information from DB.
ANSWER:*/
select*from customer;

/*Q.4 List different countries.
ANSWER:*/
select*from country;

/*Q.5 Display all active customers.
ANSWER:*/
use customer;
SELECT *
FROM customers
WHERE status = 'active';

-- If status is a boolean (1 for active, 0 for inactive)
SELECT *
FROM customers
WHERE is_active = 1;

/*Q.6 List of all rental IDs for customer with ID 1.
ANSWER:*/
SELECT rental_id
FROM rental
WHERE customer_id = 1;

/*Q.7 Display all the films whose rental duration is greater than 5 .
ANSWER:*/
SELECT *
FROM film
WHERE rental_duration > 5;

/*Q.8 List the total number of films whose replacement cost is greater than $15 and less than $20.
ANSWER:*/
SELECT COUNT(*) AS total_films
FROM film
WHERE replacement_cost > 15 AND replacement_cost < 20;

/*Q.9 Display the count of unique first names of actors.
ANSWER:*/
SELECT COUNT(DISTINCT first_name) AS unique_first_names
FROM actor;

/*Q.10  Display the first 10 records from the customer table .
ANSWER:*/
SELECT *
FROM customer
LIMIT 10;

/*Q.11 Display the first 3 records from the customer table whose first name starts with ‘b’.
ANSWER:*/
SELECT *
FROM customer
WHERE first_name LIKE 'b%'
LIMIT 3;

/*Q.12 Display the names of the first 5 movies which are rated as ‘G’.
ANSWER:*/
SELECT title
FROM film
WHERE rating = 'G'
LIMIT 5;

/*Q.13 Find all customers whose first name starts with "a".
ANSWER:*/
SELECT *
FROM customer
WHERE first_name LIKE 'a%';

/*Q.14  Find all customers whose first name ends with "a".
ANSWER*/
SELECT *
FROM customer
WHERE first_name LIKE '%a';

/*Q.15  Display the list of first 4 cities which start and end with ‘a’ .
ANSWER:*/
SELECT city
FROM city
WHERE city LIKE 'a%a'
LIMIT 4;

/*Q.16  Find all customers whose first name have "NI" in any position.
ANSWER*/
SELECT *
FROM customer
WHERE first_name LIKE '%NI%';

/*Q.17 Find all customers whose first name have "r" in the second position .
ANSWER:*/
select*
from customer
where first_name like '_r%';

/*Q.18  Find all customers whose first name starts with "a" and are at least 5 characters in length.
ANSWER:*/
SELECT *
FROM customer
WHERE first_name LIKE 'a%'
  AND LENGTH(first_name) >= 5;
  
/*Q.19 Find all customers whose first name starts with "a" and ends with "o".
ANSWER:*/
select*
from customer
where first_name like 'a%o';  

/*Q.20 Get the films with pg and pg-13 rating using IN operator.
ANSWER:*/
SELECT *
FROM film
WHERE rating IN ('PG', 'PG-13');

/*Q.21  Get the films with length between 50 to 100 using between operator.
ANSWER:*/
SELECT *
FROM film
WHERE length BETWEEN 50 AND 100;

/*Q.22  Get the top 50 actors using limit operator.
ANSWER:*/
SELECT *
FROM actor
LIMIT 50;

/*Q.23  Get the distinct film ids from inventory table.
ANSWER:*/
SELECT DISTINCT film_id
FROM inventory
ORDER BY film_id;

/*Functions
Basic Aggregate Functions:

Q.1 Retrieve the total number of rentals made in the Sakila database.
Hint: Use the COUNT() function.
ANSWER:*/
SELECT COUNT(*) AS total_rentals
FROM rental;

/*Q.2 Find the average rental duration (in days) of movies rented from the Sakila database.
Hint: Utilize the AVG() function.
ANSWER:*/
SELECT AVG(rental_duration) AS avg_rental_duration
FROM film;

/*String Functions:
Q.3 Display the first name and last name of customers in uppercase.
Hint: Use the UPPER () function.
ANSWER:*/
SELECT UPPER(first_name) AS first_name_upper,
       UPPER(last_name) AS last_name_upper
FROM customer;

/*Q.4 Extract the month from the rental date and display it alongside the rental ID.
Hint: Employ the MONTH() function.
ANSWER:*/
SELECT rental_id,
       MONTH(rental_date) AS rental_month
FROM rental;

/*GROUP BY:
Q.5 Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
Hint: Use COUNT () in conjunction with GROUP BY.
ANSWER:*/
SELECT customer_id,
       COUNT(*) AS rental_count
FROM rental
GROUP BY customer_id;

/*Q.6 Find the total revenue generated by each store.
Hint: Combine SUM() and GROUP BY.
ANSWER:*/
SELECT store_id,
       SUM(amount) AS total_revenue
FROM payment
GROUP BY store_id;

/*Q.7 Determine the total number of rentals for each category of movies.
Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY.
ANSWER:*/
SELECT fc.category_id,
       COUNT(r.rental_id) AS total_rentals
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
GROUP BY fc.category_id;

/*Q.8 Find the average rental rate of movies in each language.
Hint: JOIN film and language tables, then use AVG () and GROUP BY.
ANSWER:*/
SELECT l.name AS language,
       AVG(f.rental_rate) AS avg_rental_rate
FROM film f
JOIN language l ON f.language_id = l.language_id
GROUP BY l.name;

/*Joins
Q.9 Display the title of the movie, customer s first name, and last name who rented it.
Hint: Use JOIN between the film, inventory, rental, and customer tables.
ANSWER:*/
SELECT f.title,
       c.first_name,
       c.last_name
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN customer c ON r.customer_id = c.customer_id;

/*Q.10 Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
Hint: Use JOIN between the film actor, film, and actor tables.
ANSWER:*/
SELECT a.first_name,
       a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Gone with the Wind';

/*Q.11 Retrieve the customer names along with the total amount they've spent on rentals.
Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY.
ANSWER:*/
SELECT c.first_name,
       c.last_name,
       SUM(p.amount) AS total_spent
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.customer_id, c.first_name, c.last_name;

/*Q.12 List the titles of movies rented by each customer in a particular city (e.g., 'London').
Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY.
ANSWER:*/
SELECT c.first_name,
       c.last_name,
       f.title
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE ci.city = 'London'
ORDER BY c.customer_id;

/*Advanced Joins and GROUP BY:
Q.13 Display the top 5 rented movies along with the number of times they've been rented.
Hint: JOIN film, inventory, and rental tables, then use COUNT () and GROUP BY, and limit the results
ANSWER:*/
SELECT f.title,
       COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC
LIMIT 5;

/*Q.14 Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY.
ANSWER:*/
SELECT c.customer_id,
       c.first_name,
       c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
WHERE i.store_id IN (1, 2)
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT i.store_id) = 2;

/*Windows Function:
Q.1 Rank the customers based on the total amount they've spent on rentals.
ANSWER:*/
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       SUM(p.amount) AS total_spent,
       RANK() OVER (ORDER BY SUM(p.amount) DESC) AS rank
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY rank;

/*Q.2 Calculate the cumulative revenue generated by each film over time.
ANSWER:*/
SELECT f.film_id,
       f.title,
       p.payment_date,
       SUM(p.amount) OVER (PARTITION BY f.film_id 
                            ORDER BY p.payment_date 
                            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_revenue
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
ORDER BY f.film_id, p.payment_date;

/*Q.3  Determine the average rental duration for each film, considering films with similar lengths.
ANSWER:*/
SELECT length,
       AVG(rental_duration) AS avg_rental_duration
FROM film
GROUP BY length
ORDER BY length;

/*Q.4  Identify the top 3 films in each category based on their rental counts
ANSWER:*/
SELECT category_id,
       title,
       rental_count
FROM (
    SELECT fc.category_id,
           f.title,
           COUNT(r.rental_id) AS rental_count,
           ROW_NUMBER() OVER (PARTITION BY fc.category_id 
                              ORDER BY COUNT(r.rental_id) DESC) AS rn
    FROM film f
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY fc.category_id, f.film_id, f.title
) AS ranked_films
WHERE rn <= 3
ORDER BY category_id, rental_count DESC;

/*Q.5  Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers.
ANSWER:*/
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       COUNT(r.rental_id) AS total_rentals,
       (COUNT(r.rental_id) - avg_r.avg_rentals) AS difference_from_avg
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
CROSS JOIN (
    SELECT AVG(rental_count) AS avg_rentals
    FROM (
        SELECT COUNT(rental_id) AS rental_count
        FROM rental
        GROUP BY customer_id
    ) AS per_customer
) AS avg_r
GROUP BY c.customer_id, c.first_name, c.last_name, avg_r.avg_rentals
ORDER BY difference_from_avg DESC;

/*Q.6  Find the monthly revenue trend for the entire rental store over time.
ANSWER:*/
SELECT 
    YEAR(payment_date) AS year,
    MONTH(payment_date) AS month,
    SUM(amount) AS monthly_revenue
FROM payment
GROUP BY YEAR(payment_date), MONTH(payment_date)
ORDER BY year, month;

/*Q.7  Identify the customers whose total spending on rentals falls within the top 20% of all customers.
ANSWER:*/
SELECT customer_id,
       first_name,
       last_name,
       total_spent
FROM (
    SELECT c.customer_id,
           c.first_name,
           c.last_name,
           SUM(p.amount) AS total_spent,
           PERCENT_RANK() OVER (ORDER BY SUM(p.amount) DESC) AS pr
    FROM customer c
    JOIN rental r ON c.customer_id = r.customer_id
    JOIN payment p ON r.rental_id = p.rental_id
    GROUP BY c.customer_id, c.first_name, c.last_name
) AS ranked_customers
WHERE pr <= 0.2
ORDER BY total_spent DESC;

/*Q.8 Calculate the running total of rentals per category, ordered by rental count.
ANSWER:*/
SELECT category_id,
       rental_count,
       SUM(rental_count) OVER (ORDER BY rental_count DESC) AS running_total
FROM (
    SELECT fc.category_id,
           COUNT(r.rental_id) AS rental_count
    FROM film_category fc
    JOIN film f ON fc.film_id = f.film_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY fc.category_id
) AS category_rentals
ORDER BY rental_count DESC;

/*Q.9  Find the films that have been rented less than the average rental count for their respective categories.
ANSWER:*/
SELECT f.film_id,
       f.title,
       fc.category_id,
       COUNT(r.rental_id) AS film_rental_count
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title, fc.category_id
HAVING COUNT(r.rental_id) < (
    SELECT AVG(film_count)
    FROM (
        SELECT COUNT(r2.rental_id) AS film_count
        FROM film f2
        JOIN inventory i2 ON f2.film_id = i2.film_id
        JOIN rental r2 ON i2.inventory_id = r2.inventory_id
        JOIN film_category fc2 ON f2.film_id = fc2.film_id
        WHERE fc2.category_id = fc.category_id
        GROUP BY f2.film_id
    ) AS category_avg
);

/*Q.10  Identify the top 5 months with the highest revenue and display the revenue generated in each month.
ANSWER:*/
SELECT 
    YEAR(payment_date) AS year,
    MONTH(payment_date) AS month,
    SUM(amount) AS monthly_revenue
FROM payment
GROUP BY YEAR(payment_date), MONTH(payment_date)
ORDER BY monthly_revenue DESC
LIMIT 5;

/*Normalisation & CTE
Q.1 First Normal Form (1NF):
    a. Identify a table in the Sakila database that violates 1NF. Explain how you would normal
ANSWER*/
/*First Normal Form (1NF) Violation in Sakila Database
The Sakila database is generally well-normalized, and finding a direct violation of 1NF in a production-ready database like Sakila can be challenging as its designed to adhere to normalization principles. However, for illustrative purposes, one could imagine a scenario where the film table might hypothetically violate 1NF if the special_features column were to store multiple distinct features as a single, comma-separated string (e.g., "Trailers,Commentaries,Deleted Scenes").    

Explanation of Violation:
If special_features contained multiple values in a single field, it would violate the atomicity rule of 1NF, which states that each column must contain only atomic (indivisible) values. A comma-separated list of features is not atomic as it represents multiple pieces of information within one field.

Normalization Process:
To normalize this hypothetical film table to 1NF, one would need to:
Create a new table for special features: A new table, for example, film_special_feature, would be created. This table would have a primary key, a foreign key referencing film_id from the film table, and a column to store individual special features.*/

    CREATE TABLE film_special_feature (
        film_special_feature_id INT PRIMARY KEY AUTO_INCREMENT,
        film_id SMALLINT UNSIGNED NOT NULL,
        feature_name VARCHAR(50) NOT NULL,
        FOREIGN KEY (film_id) REFERENCES film (film_id)
    );
/*Populate the new table: The data from the original special_features column would be parsed, and each individual feature would be inserted as a separate row into the film_special_feature table, linked to its corresponding film_id.*/
 
    -- Example of populating the new table (requires parsing logic)
    INSERT INTO film_special_feature (film_id, feature_name)
    SELECT
        f.film_id,
        SUBSTRING_INDEX(SUBSTRING_INDEX(f.special_features, ',', n.n), ',', -1) AS feature
    FROM
        film f
    INNER JOIN
        (SELECT 1 n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5) n
        ON CHAR_LENGTH(f.special_features) - CHAR_LENGTH(REPLACE(f.special_features, ',', '')) >= n.n - 1
    WHERE f.special_features IS NOT NULL;

/*Remove the original column: The special_features column would then be removed from the film table.*/

    ALTER TABLE film DROP COLUMN special_features;
/*This process ensures that each special feature is stored in its own atomic field, satisfying the requirements of First Normal Form.

Q.2  Second Normal Form (2NF):
     a. Choose a table in Sakila and describe how you would determine whether it is in 2NF. If it violates 2NF, exp 
     ANSWER: To determine if a Sakila table is in Second Normal Form (2NF), you must first ensure it's in First Normal Form (1NF) and then check if any non-key attribute is partially dependent on a composite primary key. A partial dependency occurs when a non-key attribute depends on only a proper subset of the composite primary key, not the entire key. 
     
     Example: The film_category table in Sakila
     
     Let's examine the film_category table to see if it's in 2NF.
     1NF Status: The film_category table consists of film_id, category_id, and last_update. It is already in 1NF because each attribute has atomic values and there are no repeating groups. 
     Identify Primary Key: The table has a composite primary key of (film_id, category_id). 
     Check for Partial Dependencies: We need to see if last_update depends on only a part of the composite key. In this table, last_update is a timestamp indicating when the record was last modified. The modification time is tied to the specific film_id and category_id combination. Therefore, last_update depends on the entire (film_id, category_id) key. 
     2NF Conclusion: Since there are no partial dependencies, the film_category table is in 2NF. 

     Example: A Hypothetical Violating Table
     Consider a hypothetical table to illustrate a violation of 2NF: ProductInfo with (product_id, warehouse_id) as the composite primary key, and attributes product_name and warehouse_location. product_name depends on product_id and warehouse_location depends on warehouse_id. 
     Violation:
	 Because product_name depends only on product_id (a subset of the composite key) and warehouse_location depends only on warehouse_id (another subset), neither depends on the entire composite key. 
     
     To Resolve the Violation:
     
     Split the table into two to satisfy 2NF: 
      
     Products Table: product_id (primary key), product_name.
     Warehouses Table: warehouse_id (primary key), warehouse_location.
     
Q.3 Third Normal Form (3NF):
	a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies present and outline the steps to normalize the table to 3NF.     
ANSWER: The Sakila database is generally well-normalized, but for demonstration purposes, one could consider a hypothetical scenario where the film table might violate 3NF if it contained redundant information about the language.
Hypothetical Violation in film table:
Imagine the film table in Sakila was designed as follows:*/
CREATE TABLE film (
    film_id SMALLINT UNSIGNED NOT NULL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT DEFAULT NULL,
    release_year YEAR DEFAULT NULL,
    language_id TINYINT UNSIGNED NOT NULL,
    language_name VARCHAR(20) NOT NULL, -- This is the violating attribute
    original_language_id TINYINT UNSIGNED DEFAULT NULL,
    rental_duration TINYINT UNSIGNED NOT NULL DEFAULT 3,
    rental_rate DECIMAL(4,2) NOT NULL DEFAULT 4.99,
    length SMALLINT UNSIGNED DEFAULT NULL,
    replacement_cost DECIMAL(5,2) NOT NULL DEFAULT 19.99,
    rating ENUM('G','PG','PG-13','R','NC-17') DEFAULT 'G',
    special_features SET('Trailers','Commentaries','Deleted Scenes','Behind the Scenes') DEFAULT NULL,
    last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (language_id) REFERENCES language (language_id) ON UPDATE CASCADE,
    FOREIGN KEY (original_language_id) REFERENCES language (language_id) ON UPDATE CASCADE
);
/*Transitive Dependency:
In this hypothetical film table, a transitive dependency exists:

film_id -> language_id (Primary key determines the foreign key)
language_id -> language_name (The language_id in the language table determines its language_name)

Therefore, film_id -> language_name is a transitive dependency because language_name is not directly dependent on the primary key film_id, but rather on language_id, which is a non-key attribute in this hypothetical film table (even though it's a foreign key).
Steps to Normalize to 3NF:

To normalize this hypothetical film table to 3NF, the following steps would be taken:
Identify the determinant of the transitive dependency: In this case, language_id is the determinant for language_name.
Create a new table for the dependent attributes: A new table, language, already exists in Sakila and correctly stores language_id and language_name.
Remove the transitively dependent attribute from the original table: The language_name column would be removed from the film table. The film table would retain language_id as a foreign key, referencing the language table.

The normalized film table would then look like the actual film table in Sakila:*/

CREATE TABLE film (
    film_id SMALLINT UNSIGNED NOT NULL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT DEFAULT NULL,
    release_year YEAR DEFAULT NULL,
    language_id TINYINT UNSIGNED NOT NULL,
    original_language_id TINYINT UNSIGNED DEFAULT NULL,
    rental_duration TINYINT UNSIGNED NOT NULL DEFAULT 3,
    rental_rate DECIMAL(4,2) NOT NULL DEFAULT 4.99,
    length SMALLINT UNSIGNED DEFAULT NULL,
    replacement_cost DECIMAL(5,2) NOT NULL DEFAULT 19.99,
    rating ENUM('G','PG','PG-13','R','NC-17') DEFAULT 'G',
    special_features SET('Trailers','Commentaries','Deleted Scenes','Behind the Scenes') DEFAULT NULL,
    last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (language_id) REFERENCES language (language_id) ON UPDATE CASCADE,
    FOREIGN KEY (original_language_id) REFERENCES language (language_id) ON UPDATE CASCADE
);

/*Q.4 Normalization Process:
      a. Take a specific table in Sakila and guide through the process of normalizing it from the initial unnormalized form up to at least 2NF.
ANSWER: To normalize a Sakila table to at least Second Normal Form (2NF), begin by selecting a table, like the film_text table, which contains redundant information. First, convert the table to First Normal Form (1NF) by ensuring each column contains a single value and there are no repeating groups, which the film_text table already satisfies. Next, convert to Second Normal Form (2NF) by identifying and eliminating partial dependencies, where a non-key attribute depends on only part of a composite primary key. For example, if film_text had a composite key, attributes fully dependent on one part would be moved to a new table. 

1. Start with an Unnormalized/First Normal Form (1NF) Table
Let's use the film_text table from the Sakila database as our example. In its current state, it's generally already in 1NF because it contains atomic (single) values and doesn't have repeating groups.

Example film_text Table

film_id             title                         description
   1           ACADEMY DINOSAUR       A Epic Tale of a Dinosaur And A Mad Scientist who must Save The World from A Cataclysmic Betrayal
   2           ALADDIN CALENDAR       A young man's adventure to save a princess from a wizard
 ...                ...                              ...
 
 Primary Key: film_id 
Non-Key Attributes: title, description 
Functional Dependencies: title and description are fully dependent on film_id. 

2. Convert to Second Normal Form (2NF)
A table is in 2NF if it is in 1NF and every non-key attribute is fully functionally dependent on the entire primary key. This means there should be no partial dependencies, where a non-key attribute depends on only a part of a composite primary key. 
Since our film_text table has a single-column primary key (film_id), there are no partial dependencies. Therefore, the film_text table is already in 2NF. 

Explanation
1NF Requirement: All attributes contain single, atomic values. The film_text table already meets this. 
2NF Requirement: All non-key attributes must be fully dependent on the entire primary key. 
In film_text, title and description are directly dependent on the film_id. 
There is no scenario where title or description would depend on a part of the film_id (which is not a composite key). 

Thus, the film_text table is already in 2NF, making further normalization to 3NF (which removes transitive dependencies) the next step, though not required by the prompt. 

Q.5 CTE Basics:
    a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they have.......
ANSWER: Here is a query using a Common Table Expression (CTE) to retrieve the distinct list of actor names and the number of films they have acted in, assuming a database schema with actor and film_actor tables (common in examples like Sakila): */
WITH ActorFilmCounts AS (
    SELECT
        a.first_name,
        a.last_name,
        COUNT(fa.film_id) AS number_of_films
    FROM
        actor AS a
    JOIN
        film_actor AS fa ON a.actor_id = fa.actor_id
    GROUP BY
        a.actor_id, a.first_name, a.last_name
)
SELECT
    first_name,
    last_name,
    number_of_films
FROM
    ActorFilmCounts
ORDER BY
    number_of_films DESC, first_name, last_name;
    
/*Explanation:
WITH ActorFilmCounts AS (...): This defines the CTE named ActorFilmCounts.
SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS number_of_films: Inside the CTE, this selects the actor's first name, last name, and counts the number of films associated with each actor using COUNT(fa.film_id). The count is aliased as number_of_films.
FROM actor AS a JOIN film_actor AS fa ON a.actor_id = fa.actor_id: This joins the actor table (aliased as a) with the film_actor table (aliased as fa) on their common actor_id column.
GROUP BY a.actor_id, a.first_name, a.last_name: This groups the results by each unique actor to ensure the COUNT() function correctly aggregates films per actor. Including first_name and last_name in the GROUP BY is necessary because they are in the SELECT clause and not aggregated.
SELECT first_name, last_name, number_of_films FROM ActorFilmCounts: This is the main query that selects the desired columns from the ActorFilmCounts CTE.
ORDER BY number_of_films DESC, first_name, last_name: This orders the final result, showing actors with more films first, and then alphabetically by name for actors with the same film count.

Q.6  CTE with Joins:
     a. Create a CTE that combines information from the film and language tables to display the film title, language namE........  
ANSWER: To create a CTE that combines film titles and their language names, use the WITH clause to define the CTE, an AS clause to define the CTE's query, and a SELECT statement that joins the film and language tables on their respective language_id columns, then select title from film and name from language. 
Here is an example of the SQL query:*/
WITH FilmLanguage AS (
    SELECT
        f.title AS film_title,
        l.name AS language_name
    FROM
        film AS f
    INNER JOIN
        language AS l
    ON
        f.language_id = l.language_id
)
SELECT
    film_title,
    language_name
FROM
    FilmLanguage;
    
/*Explanation:
WITH FilmLanguage AS (: This starts the Common Table Expression and gives it the name FilmLanguage. 
SELECT f.title AS film_title, l.name AS language_name: This selects the title column from the film table (aliased as f) and the name column from the language table (aliased as l), renaming them to film_title and language_name respectively for clarity. 
FROM film AS f INNER JOIN language AS l ON f.language_id = l.language_id: This part joins the film and language tables. 
INNER JOIN is used to combine rows that have matching values in both tables.
f.language_id = l.language_id specifies the condition for the join, which is that the language_id in the film table must match the language_id in the language table.
): Closes the CTE definition.
SELECT film_title, language_name FROM FilmLanguage;: This is the final SELECT statement that queries the data from the FilmLanguage CTE you just defined, retrieving the film title and language name. 

Q.7  CTE for Aggregation:
     a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments) from......  
ANSWER:To find the total revenue generated by each customer using a Common Table Expression (CTE), a payments table (or similar) with customer_id and amount columns is assumed.*/

WITH CustomerRevenue AS (
    SELECT
        customer_id,
        SUM(amount) AS total_revenue
    FROM
        payments
    GROUP BY
        customer_id
)
SELECT
    customer_id,
    total_revenue
FROM
    CustomerRevenue;
    
/*Q.8 CTE with Window Functions:
      a. Utilize a CTE with a window function to rank films based on their rental duration from the film table.
ANSWER: To rank films by rental duration using a CTE and a window function, first define a Common Table Expression (CTE) named cte_film that selects the film's ID, title, rental duration, and uses the RANK() window function to assign a rank based on the rental_duration in descending order. Then, query the cte_film to select all films from the CTE with a ranking of 1.*/
 
WITH cte_film AS (
    SELECT
        film_id,
        title,
        rental_duration,
        RANK() OVER (ORDER BY rental_duration DESC) AS duration_rank
    FROM
        film
)
SELECT
    film_id,
    title,
    rental_duration,
    duration_rank
FROM
    cte_film
ORDER BY
    duration_rank;
    
/*Explanation
WITH cte_film AS (...): This defines the CTE named cte_film. A CTE is a temporary, named result set that you can reference within a single SQL statement. 
SELECT film_id, title, rental_duration: These are the columns from the film table that will be included in the CTE's result. 
RANK() OVER (ORDER BY rental_duration DESC) AS duration_rank: This is the window function. 
RANK(): Assigns a rank to each film. If two films have the same rental_duration, they will receive the same rank, and the next rank will be skipped. 
OVER (ORDER BY rental_duration DESC): This clause specifies that the ranking should be performed over the entire result set of the CTE, ordered by rental_duration in descending order. 
SELECT * FROM cte_film ORDER BY duration_rank;: This final SELECT statement retrieves all columns from the cte_film and orders the results by the newly assigned duration_rank. 

Q.9 CTE and Filtering:
    a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the customer table to retrieve additional customer details.    
ANSWER: Here is the SQL query demonstrating the use of a Common Table Expression (CTE) to identify customers with more than two rentals and then join this CTE with the customer table to retrieve additional details.*/

WITH CustomersWithManyRentals AS (
    SELECT
        customer_id,
        COUNT(rental_id) AS total_rentals
    FROM
        rental
    GROUP BY
        customer_id
    HAVING
        COUNT(rental_id) > 2
)
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    cmr.total_rentals
FROM
    customer AS c
JOIN
    CustomersWithManyRentals AS cmr
ON
    c.customer_id = cmr.customer_id;
    
/*Explanation:
WITH CustomersWithManyRentals AS (...): This defines a CTE named CustomersWithManyRentals.
Inside the CTE, a SELECT statement counts the number of rentals for each customer_id from the rental table.
GROUP BY customer_id aggregates the rentals by each customer.
HAVING COUNT(rental_id) > 2 filters these aggregated results, keeping only those customers who have made more than two rentals.
SELECT ... FROM customer AS c JOIN CustomersWithManyRentals AS cmr ON c.customer_id = cmr.customer_id;: This is the main query that uses the defined CTE.
It selects customer_id, first_name, last_name, email from the customer table (aliased as c).
It also selects total_rentals from the CustomersWithManyRentals CTE (aliased as cmr).
An INNER JOIN connects the customer table and the CustomersWithManyRentals CTE using customer_id as the common column, ensuring that only customers found in both are included in the final result.

Q.10  CTE for Date Calculations:
      a. Write a query using a CTE to find the total number of rentals made each month, considering the Rental_date from the rental table.    
ANSWER: Here is a query using a Common Table Expression (CTE) to find the total number of rentals made each month from the rental table, based on the rental_date column.*/

WITH MonthlyRentals AS (
    SELECT
        EXTRACT(YEAR FROM rental_date) AS rental_year,
        EXTRACT(MONTH FROM rental_date) AS rental_month,
        COUNT(rental_id) AS total_rentals
    FROM
        rental
    GROUP BY
        EXTRACT(YEAR FROM rental_date),
        EXTRACT(MONTH FROM rental_date)
)
SELECT
    rental_year,
    rental_month,
    total_rentals
FROM
    MonthlyRentals
ORDER BY
    rental_year,
    rental_month;
    
/*Q.11 CTE and Self-Join:
       a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film ........
ANSWER:*/
WITH ActorPairs AS (
    SELECT 
        fa1.film_id,
        fa1.actor_id AS actor1,
        fa2.actor_id AS actor2
    FROM film_actor fa1
    JOIN film_actor fa2 
        ON fa1.film_id = fa2.film_id
       AND fa1.actor_id < fa2.actor_id   -- avoid duplicates & self-pairs
)
SELECT 
    ap.film_id,
    a1.first_name || ' ' || a1.last_name AS actor1_name,
    a2.first_name || ' ' || a2.last_name AS actor2_name
FROM ActorPairs ap
JOIN actor a1 ON ap.actor1 = a1.actor_id
JOIN actor a2 ON ap.actor2 = a2.actor_id
ORDER BY ap.film_id, actor1_name, actor2_name;
 
/*🔎 Explanation:
CTE (ActorPairs):
Performs a self-join on film_actor to find two different actors (fa1 and fa2) in the same film.

The condition fa1.actor_id < fa2.actor_id ensures:
No duplicate pairs (A,B and B,A)
No pairing of an actor with themselves.

Main Query:
Joins the CTE with the actor table twice to get the actor names.
Displays film ID, actor1, and actor2.

ORDER BY:
Makes the report easy to read by grouping pairs within each film.

Q.12 CTE for Recursive Search:
     a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager, considering...... 
ANSWER:*/

WITH RECURSIVE StaffHierarchy AS (
    -- Anchor member: start with the manager
    SELECT 
        staff_id,
        first_name,
        last_name,
        reports_to
    FROM staff
    WHERE staff_id = 1   -- 🔹 Replace with the manager's staff_id

    UNION ALL

    -- Recursive member: find employees reporting to the above staff
    SELECT 
        s.staff_id,
        s.first_name,
        s.last_name,
        s.reports_to
    FROM staff s
    INNER JOIN StaffHierarchy sh 
        ON s.reports_to = sh.staff_id
)
SELECT * 
FROM StaffHierarchy;

/*Explanation:

Anchor query
Starts with the given manager (staff_id = 1 in the example). 

Recursive query
Finds all employees whose reports_to matches the manager (or subsequent employees).
Recursively walks down the reporting chain. 

Final SELECT
Returns the full hierarchy: manager + all employees (direct & indirect reports).  

END

























   



    
    
    












