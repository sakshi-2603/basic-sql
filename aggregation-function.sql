/*--------Aggregation Function ----------*/
create database aggregation;
use aggregation;
create table student(
   student_id int primary key,
   name varchar(20),
   subject varchar(20),
   marks int,
   city varchar(20)
);

insert into student values(1,"anil","math",78,"Pune"),
                          (2,"bhumika","science",93,"mumbai"),
                          (3,"chetan","math",85,"pune"),
                          (4,"dhruv","science",96,"delhi"),
                          (5,"farah","math",82,"mumbai"),
                          (6,"gouri","english",88,"pune"),
                          (7,"hari","english",67,"delhi");
select* from student;

select count(*) from student;

select sum(marks) from student;

select avg(marks) from student;

select max(marks),min(marks) from student;

select subject,avg(marks) 
from student
group by subject;

select subject,avg(marks)
from student
group by subject
having avg(marks)>85;

select city,count(*)
from student
group by city;

select city,count(*)
from student
group by city
having count(*)>2;

select city,sum(marks)
from student
group by city;

select name , marks
from student
where marks >
(
   select  avg(marks) from student
) ;

select distinct subject , count(*)
from student
group by subject;

select subject ,sum(marks)
from student
group by subject;

select city , max(marks),min(marks)
from student
group by city;

SELECT subject, AVG(marks) AS avg_marks
FROM student
GROUP BY subject
ORDER BY avg_marks ASC;


select subject , count(*),avg(marks)
from student
group by subject
order by avg(marks) desc;
