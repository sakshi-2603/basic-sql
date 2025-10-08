/*------------ Views --------------*/
create database views;
use views;
----------------------------------------
CREATE TABLE student (
   student_id INT,
   name VARCHAR(30),
   subject VARCHAR(20),
   marks INT,
   city VARCHAR(30)
);
------------------------------------------------------------------------
insert into student values(1,"anil","math",78,"Pune"),
                          (2,"bhumika","science",93,"mumbai"),
                          (3,"chetan","math",85,"pune"),
                          (4,"dhruv","science",96,"delhi"),
                          (5,"farah","math",82,"mumbai"),
                          (6,"gouri","english",88,"pune"),
                          (7,"hari","english",67,"delhi");
select* from student;
------------------------------------------------------------------
create view avg_marks as
select subject , avg(marks)
from student
group by subject;

select* from avg_marks;
---------------------------------------------
create  view high_marks as
select subject, marks
from student
where marks>90;
drop view high_marks;

select* from high_marks;
---------------------------------------------
create view city as
select city,avg(marks)
from student
group by city;

select * from city;
---------------------------------------------
create view top_marks as
select max(marks)
from student;

select * from top_marks;
---------------------------------------------
create view subject_performance as
select subject,sum(marks),count(*)
from student
group by subject;

select * from subject_performance;
---------------------------------------------
create view passing_student as 
select * from student
where marks >= 75;

select * from passing_student ;
---------------------------------------------
create view result as
select name,subject,marks, 
case
    when marks >= 75 then 'pass'
    else 'fail'
    end as result
from student;

select * from result;
---------------------------------------------
create view city_pune as 
select * from student 
where city = "pune"; 

select * from city_pune;
-----------------------------------------------
create view marks as
select subject,marks from student
order by marks desc;

select * from marks;
---------------------------------------------
create view above_avg_marks as 
select * from student
where
marks > 
(select avg(marks) from student);

select * from above_avg_marks;
---------------------------------------------
create view sub_avg_marks as 
select subject ,avg(marks) 
from student
group by subject;

select * from sub_avg_marks;
---------------------------------------------
create view top_score as 
select * from student
where marks > 90;
select * from top_score;
---------------------------------------------
create view city_wise_data as
select city , count(*)
from student
group by city;
select * from city_wise_data;
---------------------------------------------
create view student_result as 
select name,subject,marks,
case
   when marks >= 75 then 'pass'
   else 'fail'
   end as result
from student;
drop view student_result;
select * from student_result;
-------------------------------------------------------
create view above_avg as
select *
from student
where marks > (select avg(marks) from student);

select * from above_avg;
---------------------------------------------------------
create view failing_student as 
select * from student 
where marks < 75;
select * from failing_student;
---------------------------------------------------------
create view eng_sub as
select * from student 
where subject = 'english';
select* from eng_sub;
---------------------------------------------------------
