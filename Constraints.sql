------------------------------Constraints In SQL-------------------------------
# First Query
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    roll_no INT UNIQUE,
    marks INT CHECK (marks BETWEEN 0 AND 100)
);

INSERT INTO students VALUES (1, 'Sakshi', 10, 90);

-----------------------------------------------------------------------------
# Second Query
CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) CHECK (salary > 0),
    department VARCHAR(30) DEFAULT 'General'
);

INSERT INTO employees (emp_name, salary) VALUES ('Sakshi', 40000);

--------------------------------------------------------------------------------
# Third Query
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    salary DECIMAL(10,2) CHECK (salary > 0),
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

INSERT INTO departments VALUES (1, 'HR');
INSERT INTO employees VALUES (101, 'Sakshi', 1, 55000);
--------------------------------------------------------------------------------
# Fourth Query
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_amount DECIMAL(10,2) CHECK (order_amount > 0),
    order_date DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers VALUES (1, 'Sakshi');
INSERT INTO orders (customer_id, order_amount) VALUES (1, 1500.00);
------------------------------------------------------------------------------------------------
# Fifth Query
CREATE TABLE bank_accounts (
    account_no INT PRIMARY KEY,
    balance DECIMAL(10,2) CHECK (balance >= 0),
    account_type VARCHAR(20) DEFAULT 'Savings',
    account_status VARCHAR(20) CHECK (account_status IN ('Active', 'Inactive', 'Closed'))
);

INSERT INTO bank_accounts VALUES (101, 5000.00, 'Savings', 'Active');
--------------------------------------------------------------------------------------------------
# Sixth Query
CREATE TABLE library (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    ISBN INT UNIQUE,
    published_year INT CHECK (published_year > 2000)
);

INSERT INTO library (title, ISBN, published_year)
VALUES ('Data Science 101', 1001, 2021);
---------------------------------------------------------------------------------------------------

