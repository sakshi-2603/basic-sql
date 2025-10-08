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
