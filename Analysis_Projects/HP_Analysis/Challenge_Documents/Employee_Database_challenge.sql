---------------------------------------------
-- Beginning of Challenge work
---------------------------------------------
-- Checking csv tables before starting
SELECT * FROM employees; -- Returns 300k rows
SELECT * FROM titles; -- Returns 443k rows

-- Create a table of retirement titles with defined birthdates
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER by e.emp_no ASC;

-- Checking the newly created table
SELECT * FROM retirement_titles; -- Returns 133k rows

-- Use Distinct with Orderby to remove duplicate rows, fixed spelling error from starter code
SELECT DISTINCT ON (rt.emp_no) rt.emp_no, 
	rt.first_name,
	rt.last_name,
	rt.title 
INTO unique_titles
FROM retirement_titles as rt
ORDER BY rt.emp_no ASC, rt.to_date DESC;

-- Checking the newly crated table 
SELECT * FROM unique_titles; -- Returns 90398 rows

-- Create count of retiring titles
SELECT COUNT(ut.title), ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC;

-- Viewing the newly created count table
SELECT * FROM retiring_titles; -- Returns 7 rows of titles

-- Create mentorship eligibility table filtering on birthdate and distinct on emp no
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	   e.first_name,
	   e.last_name,
	   e.birth_date,
	   de.from_date,
	   de.to_date,
	   t.title
INTO mentorship_eligibilty
FROM employees as e
	INNER JOIN dept_emp as de
		ON (e.emp_no = de.emp_no)
	INNER JOIN titles as t
		ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (t.to_date = '9999-01-01')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no ASC, de.from_date DESC;

-- Viewing the newly mentor list
SELECT * FROM mentorship_eligibilty; -- Returns 1549 employees are eligible for mentorship