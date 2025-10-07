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
