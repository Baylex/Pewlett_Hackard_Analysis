-- Creating tables for PH-EmployeeDB
-- Create the departments table
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

--Create the employees table
CREATE TABLE employees (
	 emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

-- Create the managers table with keys
CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

--Create salary table with keys
CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

--Querying the database
SELECT * FROM departments;

-- Create titles table
CREATE TABLE titles (
  emp_no INT NOT NULL,
  title varchar NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no, title, from_date)
);

-- Create dept_emp table 
CREATE TABLE dept_emp (
dept_no VARCHAR NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
PRIMARY KEY (emp_no, dept_no)
);

--Querying the database
SELECT * FROM dept_manager;

-- Delete the table
DROP TABLE employees CASCADE;

-- Directions said delete the table, but then add it back
CREATE TABLE employees(
	  emp_no INT NOT NULL,
	  birth_date DATE NOT NULL,
	  first_name VARCHAR NOT NULL,
	  last_name VARCHAR NOT NULL,
	  gender VARCHAR NOT NULL,
	  hire_date DATE NOT NULL,
	  PRIMARY KEY (emp_no)
);

-- Retirement Elligibity investigation
-- Returned 90k names
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';
-- Returned 20k names
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';
-- Returned 22k names
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';
-- Returned 23k names
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';
-- Returned 23k names
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Retirement eligibility, Returned 41k names
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring -- output 41380
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- creates a new data table based on the search criteria
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Run to view the new data table that was created
SELECT * FROM retirement_info;


-- Directions said to drop table
DROP TABLE retirement_info;

-- Create new table for retiring employees, returned 41k names, addes emp_no to table
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables, returns 24 rows
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining retirement_info and dept_emp tables, retuned 45k names, fixed nulls in to_date
SELECT retirement_info.emp_no,
    retirement_info.first_name,
	retirement_info.last_name,
    dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

-- Joining retirement_info and dept_emp tables, 45k names, fixed nulls
SELECT retirement_info.emp_no,
    retirement_info.first_name,
retirement_info.last_name,
    dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

-- retuns 45k names, this is a way to write variables for the table names
SELECT ri.emp_no,
    ri.first_name,
	ri.last_name,
    de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;

-- Verified dept_emp was fixed
SELECT * FROM dept_emp;

-- dept_emp would not import file, deleting and creating again. 
CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

-- Alias method departments = d, department managers = dm, returns 24 rows
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

-- Use Left Join for retirement_info and dept_emp tables
SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Returned 30k rows, descending order
SELECT * FROM salaries
ORDER BY to_date DESC;

-- Creating a temp table
SELECT emp_no,
    first_name,
	last_name,
    gender
INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- List 1, 33k names
SELECT e.emp_no, 
	e.first_name, 
	e.last_name, 
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

-- Check the table, 33k names, 6 columns of data, List 1
SELECT * FROM emp_info;
-- List 2, joining emp_info to more stuff
SELECT dm.dept_no,
	d.dept_name,
	dm.emp_no,
	ce.last_name,
	ce.first_name,
	dm.from_date,
	dm.to_date
INTO manager_info
FROM dept_manager AS dm
	INNER JOIN departments AS d
		ON (dm.dept_no = d.dept_no)
	INNER JOIN current_emp AS ce
		ON (dm.emp_no = ce.emp_no);
-- Check the table, 5 names!!!, 6 columns of data, List 1
SELECT * FROM manager_info;

-- List 3: Department Retirees
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO dept_info
FROM current_emp AS ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

-- Check the table, 36k names, 4 columns of data
SELECT * FROM dept_info;

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- Check the table, What department number is sales, d007
SELECT * FROM departments;

-- Skill Drill 7.3.6 tailored list for Sales Team
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO sales_info
FROM current_emp AS ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE (d.dept_name = 'Sales');
-- Returns 5k rows of data
SELECT * FROM sales_info;

-- Skill Drill 7.3.6 Tailored List For Sales and Development Teams
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO sales_development
FROM current_emp AS ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE d.dept_name IN ('Sales', 'Development' );
-- Returns 15k rows of data
SELECT * FROM sales_development


