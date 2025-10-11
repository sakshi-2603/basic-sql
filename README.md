-----------------------------------------------------------------Aggregation Function----------------------------------------------------------------------
What Are Aggregate Functions?

Aggregate functions in SQL are used to perform calculations on multiple rows of a table and return a single result (one value).

👉 For example:
If you have 100 students’ marks, and you want to know average marks, you’ll use the aggregate function AVG().

🔹 List of Common Aggregate Functions
Function	Description	Example
COUNT()	Counts the number of rows or non-NULL values	COUNT(student_id)
SUM()	Adds up all the values in a column	SUM(marks)
AVG()	Calculates the average of numeric values	AVG(marks)
MIN()	Finds the smallest (minimum) value	MIN(marks)
MAX()	Finds the largest (maximum) value	MAX(marks)
🧠 Important Points

Aggregate functions ignore NULL values (except COUNT(*) which counts all rows).
They are often used with the GROUP BY clause to group data.
They return one value per group or one total value for the entire table.

📘 Example Table: students
student_id	name	marks	subject
1	Anil	78	Math
2	Bhumika	93	Science
3	Chetan	85	Math
4	Dhruv	96	Science
5	Farah	82	Math
🔸 1. COUNT() — Count Rows

Purpose: To count total number of records.
SELECT COUNT(*) AS total_students
FROM students;

👉 Output:
total_students
---------------
5

Count only specific column values (non-null):
SELECT COUNT(marks) FROM students;
🔸 2. SUM() — Add Values
Purpose: To find total sum of numeric column.

SELECT SUM(marks) AS total_marks
FROM students;


👉 Output:

total_marks
------------
434

🔸 3. AVG() — Find Average
Purpose: To find the average marks.
SELECT AVG(marks) AS average_marks
FROM students;

👉 Output:
average_marks
--------------
86.8

🔸 4. MIN() — Find Minimum
Purpose: To find the lowest marks.
SELECT MIN(marks) AS lowest_marks
FROM students;

👉 Output:
lowest_marks
--------------
78

🔸 5. MAX() — Find Maximum
Purpose: To find the highest marks.
SELECT MAX(marks) AS highest_marks
FROM students;

👉 Output:
highest_marks
---------------
96

🔸 6. GROUP BY with Aggregate Functions
If you want to apply functions for each subject:
SELECT subject, AVG(marks) AS avg_marks
FROM students
GROUP BY subject;


👉 Output:
subject   | avg_marks
-----------|------------
Math       | 81.66
Science    | 94.5

🔸 7. Using HAVING with Aggregate Functions
You cannot use WHERE with aggregate results — use HAVING instead.

Example:
Show only subjects where average marks > 85:
SELECT subject, AVG(marks) AS avg_marks
FROM students
GROUP BY subject
HAVING AVG(marks) > 85;

👉 Output:
subject  | avg_marks
----------|------------
Science  | 94.5

🧩 Summary Table
Function	Meaning	Example
COUNT()	Number of rows	COUNT(*)
SUM()	Total of values	SUM(marks)
AVG()	Average value	AVG(marks)
MIN()	Minimum value	MIN(marks)
MAX()	Maximum value	MAX(marks)

------------------------------------------------------------- View-------------------------------------------------------------------

🧩 What Is a View in SQL?

A VIEW is a virtual table that is based on the result of an SQL query.
It looks and acts like a table but does not store data physically — it stores only the SQL query.
You can select, join, and filter data from one or more tables and save that query as a view.

💡 Think of it like this:
A view is a saved SELECT query that behaves like a table.

🔹 Syntax
CREATE VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition;

🔹 Example 1 – Simple View
Suppose we have a table called students:

student_id	name	subject	marks	city
1	Anil	Math	78	Pune
2	Bhumika	Science	93	Mumbai
3	Chetan	Math	85	Pune
4	Dhruv	Science	96	Delhi
5	Farah	Math	82	Mumbai
✅ Create a View
CREATE VIEW high_scorers AS
SELECT name, subject, marks
FROM students
WHERE marks > 85;
✅ Use the View
SELECT * FROM high_scorers;

Result:
name	subject	marks
Bhumika	Science	93
Dhruv	Science	96
🔹 Example 2 – View with Aggregation
You can create a view that shows average marks by subject:
CREATE VIEW subject_avg AS
SELECT subject, AVG(marks) AS avg_marks
FROM students
GROUP BY subject;

Now you can query the view just like a table:
SELECT * FROM subject_avg;

Result:
subject	avg_marks
Math	81.66
Science	94.5
🔹 Example 3 – View with Join
If you have two tables:

students
student_id	name	city
1	Anil	Pune
2	Bhumika	Mumbai

marks
student_id	subject	marks
1	Math	78
2	Science	93

You can create a view combining both:
CREATE VIEW student_marks AS
SELECT s.name, s.city, m.subject, m.marks
FROM students s
JOIN marks m
ON s.student_id = m.student_id;

🔹 View Modification
✅ To update a view:
CREATE OR REPLACE VIEW high_scorers AS
SELECT name, marks FROM students WHERE marks > 90;

✅ To delete (drop) a view:
DROP VIEW high_scorers;

🧠 Key Properties of a View
Property	Description
Virtual Table	Does not store data physically
Based on Query	Stores SQL query, not results
Dynamic	Automatically shows updated data
Can be Queried	Acts like a real table
Read-only or Updatable	Some views allow updates (with conditions)
🧩 Advantages of Views

🧱 Simplifies Complex Queries
Save long joins or calculations once, reuse them easily.

🔐 Security
Restrict access — users can see only specific columns via a view.
♻️ Data Independence
If the base table structure changes, only the view may need updating.
🧾 Reusability
Use the same view in multiple queries or reports.

⚠️ Limitations of Views
Limitation	Explanation
Cannot have indexes	Views don’t store data physically
Some views are read-only	If the view has joins or aggregates
Dependent on base tables	Dropping base tables breaks the view
Performance	Complex views can be slow
🔹 Example 4 – Security Use Case

Let’s say the students table has confidential columns like email and phone.
We can hide them:

CREATE VIEW public_students AS
SELECT name, city, subject
FROM students;

Now users can:
SELECT * FROM public_students;

but can’t see sensitive info.
🔹 Example 5 – Updatable View (If Simple)
If a view is created from a single table without aggregates, you can update it.
CREATE VIEW student_basic AS
SELECT student_id, name, marks FROM students;

You can now do:
UPDATE student_basic
SET marks = 90
WHERE student_id = 1;

This updates the base table (students).
🧾 Summary Table
Feature	Description	Example
Create a view	CREATE VIEW v1 AS SELECT * FROM table;	Creates virtual table
View with filter	CREATE VIEW v2 AS SELECT * FROM emp WHERE salary > 50000;	Filtered data
Replace view	CREATE OR REPLACE VIEW v2 AS ...	Updates view query
Drop view	DROP VIEW v2;	Deletes the view
Query view	SELECT * FROM v2;	Works like table

Why and When to Use a View
You use a view when you want to make your SQL cleaner, safer, and reusable — especially when dealing with complex queries, large systems, or restricted access.

------------------------------ Trigger ----------------------------------------

What is a Trigger in SQL?

A Trigger in SQL is a special stored procedure that automatically executes (fires) in response to certain events on a table or view.

💡 In short:

A trigger is a set of SQL statements that automatically runs when an INSERT, UPDATE, or DELETE operation occurs on a specified table.

🔹 Types of Triggers
Type	Description
BEFORE Trigger	Executes before the data modification (before insert/update/delete).
AFTER Trigger	Executes after the data modification.
INSTEAD OF Trigger	Used mostly in views, executes instead of the triggering action.
🔹 Trigger Event Operations

A trigger can fire on the following events:

INSERT
UPDATE
DELETE

🔹 Syntax of a Trigger
CREATE TRIGGER trigger_name
{BEFORE | AFTER} {INSERT | UPDATE | DELETE}
ON table_name
FOR EACH ROW
BEGIN
    -- SQL statements
END;

🔹 Example Database Setup

Let’s create two tables:

CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    salary DECIMAL(10,2)
);

CREATE TABLE emp_audit (
    audit_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    action VARCHAR(20),
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    action_time DATETIME
);


Now we’ll create triggers for INSERT, UPDATE, and DELETE events.

⚙️ 1. INSERT Trigger
✅ Goal:

Whenever a new employee is inserted, record this action in the emp_audit table.

🧠 Trigger Code:
CREATE TRIGGER after_employee_insert
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    INSERT INTO emp_audit(emp_id, action, new_salary, action_time)
    VALUES (NEW.emp_id, 'INSERT', NEW.salary, NOW());
END;

⚡ Explanation:

AFTER INSERT → Trigger runs after an insert.
NEW → Refers to the newly inserted row.
A record is added in emp_audit every time a new employee is added.

💬 Example:
INSERT INTO employees(name, salary) VALUES ('Sakshi', 40000);

Result:
emp_id	name	salary
1	Sakshi	40000
audit_id	emp_id	action	old_salary	new_salary	action_time
1	1	INSERT	NULL	40000.00	2025-10-09 20:15:00
⚙️ 2. UPDATE Trigger
✅ Goal:

Whenever an employee’s salary changes, record the old and new salary in the audit table.

🧠 Trigger Code:
CREATE TRIGGER after_employee_update
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO emp_audit(emp_id, action, old_salary, new_salary, action_time)
    VALUES (OLD.emp_id, 'UPDATE', OLD.salary, NEW.salary, NOW());
END;

⚡ Explanation:

AFTER UPDATE → Trigger runs after an update.
OLD → The row’s data before the update.
NEW → The row’s data after the update.

💬 Example:
UPDATE employees
SET salary = 50000
WHERE emp_id = 1;

Result:
emp_id	name	salary
1	Sakshi	50000
audit_id	emp_id	action	old_salary	new_salary	action_time
2	1	UPDATE	40000.00	50000.00	2025-10-09 20:18:00
⚙️ 3. DELETE Trigger
✅ Goal:

Whenever an employee is deleted, record the deleted employee details in the audit table.

🧠 Trigger Code:
CREATE TRIGGER after_employee_delete
AFTER DELETE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO emp_audit(emp_id, action, old_salary, action_time)
    VALUES (OLD.emp_id, 'DELETE', OLD.salary, NOW());
END;

⚡ Explanation:

AFTER DELETE → Trigger runs after a delete.
OLD → Refers to the deleted row’s data.

💬 Example:
DELETE FROM employees WHERE emp_id = 1;

Result:
emp_id	name	salary
(no rows)		
audit_id	emp_id	action	old_salary	new_salary	action_time
3	1	DELETE	50000.00	NULL	2025-10-09 20:20:00
⚙️ BEFORE Triggers Example
✅ Goal:

Before inserting a record, ensure salary is not less than 30000.

CREATE TRIGGER before_employee_insert
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary < 30000 THEN
        SET NEW.salary = 30000;
    END IF;
END;

💬 Example:
INSERT INTO employees(name, salary) VALUES ('Rahul', 25000);


👉 The trigger will automatically set salary = 30000, not 25000.
⚙️ INSTEAD OF Trigger (used on Views)

If you have a view that joins multiple tables, you can’t directly insert or update it.
You can use INSTEAD OF triggers to define what should happen instead.

Example:
CREATE VIEW emp_view AS
SELECT emp_id, name, salary FROM employees;

CREATE TRIGGER instead_of_insert
INSTEAD OF INSERT ON emp_view
FOR EACH ROW
BEGIN
    INSERT INTO employees(name, salary)
    VALUES (NEW.name, NEW.salary);
END;


Now inserting into the view will actually insert into the employees table.

🔹 Viewing and Dropping Triggers
View existing triggers
SHOW TRIGGERS;

Drop a trigger
DROP TRIGGER IF EXISTS after_employee_insert;

📘 Summary Table
Operation	Timing	OLD / NEW	Typical Use
BEFORE INSERT	NEW	Validate or modify data before insert	
AFTER INSERT	NEW	Log new inserts	
BEFORE UPDATE	OLD + NEW	Validate or modify updated data	
AFTER UPDATE	OLD + NEW	Track changes	
BEFORE DELETE	OLD	Validate delete	
AFTER DELETE	OLD	Log deleted data	
INSTEAD OF	NEW/OLD	Used in views	
🎯 Real-World Uses of Triggers

✅ Maintaining an audit log
✅ Enforcing business rules (e.g., prevent negative balance)
✅ Auto-updating related tables
✅ Validating data before insert/update
✅ Synchronizing data between tables

Would you like me to make a diagram/table flow showing how the trigger fires and data flows for each operation (INSERT, UPDATE, DELETE)?
It helps visualize how OLD and NEW values move between tables.

-----------------------------------------------------Constraints Query ------------------------------------------------------------------
What Are Constraints?

Constraints in SQL are rules applied to table columns to ensure the accuracy and reliability of data in a database.

They prevent invalid data from being entered into the table.

Types of SQL Constraints

Constraint	                                                         Purpose

NOT NULL	                                           Ensures a column cannot have a NULL value
UNIQUE	                                               Ensures all values in a column are different
PRIMARY KEY	                                           Uniquely identifies each row in a table (NOT NULL + UNIQUE)
FOREIGN KEY	                                           Links two tables together
CHECK	                                               Ensures values meet a specific condition
DEFAULT	                                               Sets a default value if no value is provided
AUTO_INCREMENT (MySQL) / IDENTITY (SQL Server)	       Automatically generates unique numbers for new rows

1. NOT NULL Constraint
Meaning: Column must have a value (cannot be NULL).
Example:
CREATE TABLE students (
  id INT NOT NULL,
  name VARCHAR(50) NOT NULL,
  marks INT
);


Here, id and name cannot be left blank when inserting data.
Insert Example:
INSERT INTO students (id, name, marks) VALUES (1, 'Anil', 85);  -- ✅ Works
INSERT INTO students (id, name, marks) VALUES (2, NULL, 90);   -- ❌ Error (name cannot be NULL)

🔹 2. UNIQUE Constraint
Meaning: No two rows can have the same value in this column.
Example:
CREATE TABLE employees (
  emp_id INT UNIQUE,
  emp_name VARCHAR(50),
  email VARCHAR(100) UNIQUE
);


Each emp_id and email must be unique.
Insert Example:
INSERT INTO employees VALUES (1, 'Sakshi', 'sakshi@gmail.com');  -- ✅ Works
INSERT INTO employees VALUES (2, 'Raj', 'sakshi@gmail.com');     -- ❌ Error (email duplicate)

🔹 3. PRIMARY KEY Constraint
Meaning: Uniquely identifies each record (cannot be NULL and must be unique).
Example:

CREATE TABLE students (
  roll_no INT PRIMARY KEY,
  name VARCHAR(50),
  marks INT
);

Insert Example:
INSERT INTO students VALUES (1, 'Anil', 78);  -- ✅
INSERT INTO students VALUES (1, 'Bhumika', 93);  -- ❌ Duplicate roll_no

🔹 4. FOREIGN KEY Constraint
Meaning: Creates a link between two tables. The foreign key refers to the primary key of another table.
Example:
CREATE TABLE departments (
  dept_id INT PRIMARY KEY,
  dept_name VARCHAR(50)
);

CREATE TABLE employees (
  emp_id INT PRIMARY KEY,
  emp_name VARCHAR(50),
  dept_id INT,
  FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);


Insert Example:
INSERT INTO departments VALUES (1, 'HR');
INSERT INTO employees VALUES (101, 'Sakshi', 1);  -- ✅ Works
INSERT INTO employees VALUES (102, 'Yogesh', 2);  -- ❌ Error (dept_id 2 doesn’t exist)

🔹 5. CHECK Constraint
Meaning: Ensures that a column’s value satisfies a condition.

Example:
CREATE TABLE students (
  id INT PRIMARY KEY,
  name VARCHAR(50),
  marks INT CHECK (marks >= 0 AND marks <= 100)
);


Insert Example:
INSERT INTO students VALUES (1, 'Anil', 85);  -- ✅ Works
INSERT INTO students VALUES (2, 'Farah', 150);  -- ❌ Error (marks > 100)

🔹 6. DEFAULT Constraint
Meaning: Assigns a default value if no value is provided.
Example:
CREATE TABLE students (
  id INT PRIMARY KEY,
  name VARCHAR(50),
  city VARCHAR(50) DEFAULT 'Pune'
);


Insert Example:
INSERT INTO students (id, name) VALUES (1, 'Anil');  -- city = 'Pune' automatically
🔹 7. AUTO_INCREMENT (MySQL) / IDENTITY (SQL Server)
Meaning: Automatically generates a unique number for each new record.
Example (MySQL):
CREATE TABLE students (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50),
  marks INT
);


Insert Example:
INSERT INTO students (name, marks) VALUES ('Anil', 85);
INSERT INTO students (name, marks) VALUES ('Farah', 92);
-- IDs will be automatically 1, 2, etc.

✅ Combine Multiple Constraints
You can use multiple constraints together:

CREATE TABLE students (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  email VARCHAR(100) UNIQUE,
  marks INT CHECK (marks BETWEEN 0 AND 100),
  city VARCHAR(50) DEFAULT 'Mumbai'
);
