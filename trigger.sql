/*------------------- Trigger --------------------- */
create database triggers;
use triggers;
create table student (
   id int auto_increment primary key ,
   name varchar(20),
   marks int
);
create table student_log(
   log_id int auto_increment primary key,
   stud_name varchar(20),
   action varchar(50),
   log_time timestamp default current_timestamp
);
create trigger after_stud_insert
after insert on student
for each row
     insert into student_log(stud_name,action)
     values(new.name,'student added successfully');

insert into student(name,marks) values("sakshi", 95);
select * from student;
insert into student(name,marks) values ("Dhruv",88);

create trigger after_marks_updated
after update on student
for each row 
	  insert into student_log(stud_name,action)
      values(new.name,'data updated successfully');
      
set sql_safe_updates = 0;
      
update student 
set marks = 99
where name = 'Dhruv';

select * from student_log;

create trigger after_delete_data
before delete on student
for each row 

       insert into student_log(stud_name,action)
       values(old.name,'deleted record');

drop trigger after_delete_data;

delete from student
where id = 3;

select* from student_log;
select * from student;

DELIMITER //

CREATE TRIGGER aftr_delete_data
AFTER DELETE ON student
FOR EACH ROW
BEGIN
    DELETE FROM student_log
    WHERE stud_name = 'Dhruv';
END;
//

DELIMITER ;
select* from student_log;

DELIMITER //

CREATE TRIGGER aft_student_delete
AFTER DELETE ON student
FOR EACH ROW
BEGIN
    INSERT INTO student_log(stud_name, action)
    VALUES (OLD.name, 'student deleted');
END;
//

DELIMITER ;

DELETE FROM student
WHERE name = 'Dhruv';

SELECT * FROM student_log;


---------------------New table of bank------------------------
---------------------trigger operations on it ----------------

create database trigger1;
use trigger1;
create table accounts(
   acc_no int primary key,
   acc_name varchar(50),
   balance decimal(10,2)
);

create table transactions(
   trans_id int primary key auto_increment,
   acc_no int,
   trans_type varchar(50),
   amount decimal(10,2),
   trans_time datetime
);

insert into accounts 
values (101,"sakshi",25000),
	   (102,"rahul",20000),
       (103,"dhruv",10000);
       
       
set sql_safe_updates = 0;
----------------------------after insert trigger----------------------------
delimiter //
create trigger after_insert_trigger
after insert on transactions
for each row

begin
    if upper(new.trans_type) = 'Deposit' then
    update accounts
    set balance = balance + new.amount
    where acc_no = new.acc_no;
    
    elseif upper(new.trans_type) = 'Withdraw' then
    update accounts
    set balance = balance - new.amount
    where acc_no = new.acc_no;
    end if;
end;
//
delimiter ;

insert into transactions (acc_no,trans_type,amount,trans_time)
values(102,'Deposit',2000,now());
select * from transactions;
select * from accounts;
--------------------------------------before insert trigger-----------------------------
delimiter //
create trigger before_insert_trigger
before insert on transactions
for each row
begin
    declare current_balance decimal(10,2);
    select balance into current_balance
    from accounts
    where acc_no = new.acc_no;
    
    if upper(new.trans_type) = 'Withdraw' and
    new.amount > current_balance then
    signal sqlstate '45000'
    set message_text = 'error withdrawal amount is greater than account balance';
    end if;
end;
//
delimiter ;

insert into transactions (acc_no,trans_type,amount,trans_time)
values (101,'Withdraw',20000,now());

select * from accounts;
-------------------------------delete trigger-------------------------
delimiter //
create trigger after_delete_trigger
after delete on transactions
for each row
begin
    if upper(old.trans_type) = 'Deposit' then
    update accounts
    set balance = balance - old.amount
    where acc_no = old.acc_no;
    
    elseif upper(old.trans_type) = 'Withdraw' then
    update accounts
    set balance = balance + old.amount
    where acc_no = old.acc_no;
    end if;
end;
//
delimiter ;
    
insert into transactions(acc_no,trans_type,amount,trans_time)
values(101,'Deposit',2000,now()),
      (103,'Withdraw',1000,now());
    
select * from accounts;
select * from transactions;
delete from transactions where trans_id = 3;

----------------------------update trigger------------------------- 
delimiter //
create trigger after_update_trigger
after update on transactions
for each row
begin 
     declare diff decimal(10,2);
     set diff = new.amount - old.amount;
	 if upper(new.trans_type) = 'Deposit' then
     update accounts
     set balance = balance + diff
     where acc_no = new.acc_no;
     
     elseif upper(new.trans_type) = 'Withdraw' then 
     update accounts
     set balance = balance - diff
     where acc_no = new.acc_no;
     end if;
end;
// 
delimiter ;

set sql_safe_updates = 0;
update transactions 
set amount = 3000
where acc_no = 101;

select * from transactions
where trans_type = 'Deposit' and acc_no = 101;


