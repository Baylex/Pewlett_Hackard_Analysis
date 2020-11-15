---------------------------------------------
-- Beginning of Challenge work
---------------------------------------------
-- Checking csv tables before starting
SELECT * FROM employees; -- Returns 300k rows
SELECT * FROM titles; -- Returns 443k rows

---------------------------------------------
-- Deliverable 1: Retirement titles, remove duplicates
---------------------------------------------
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

---------------------------------------------
-- Deliverable 2: Create Mentor List
---------------------------------------------
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

---------------------------------------
-- Deliverable 3: Write 2 additional queries
---------------------------------------
-- Create mentee counts per titles, is there a good match up of mentors and mentees? 
SELECT COUNT(me.title), me.title
INTO mentee_counts
FROM mentorship_eligibilty AS me
GROUP BY me.title
ORDER BY COUNT(me.title) DESC;

-- Viewing the mentee counts
SELECT * FROM mentee_counts; -- returns 6 rows, one less than the retiring list (7 rows)

-- Narrow the list of retiring employees to a list of potential mentors by 
-- filtering on being about 35 years old when starting job with current job title
SELECT DISTINCT ON (e.emp_no)e.emp_no, 
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO unique_mentors_list
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (t.from_date BETWEEN '1985-01-01' AND '1985-12-31')
ORDER by e.emp_no ASC, t.from_date DESC;

-- Check the counts that the list has been reduced
SELECT * FROM unique_mentors_list; -- Returns 5521 rows

-- Creates list of potential mentors by title counts
SELECT COUNT(um.title), um.title
INTO unique_mentor_count
FROM unique_mentors_list AS um
GROUP BY um.title
ORDER BY COUNT(um.title) DESC;

-- Returns smaller count of unique mentors by title to better match exisiting mentee criteria
SELECT * FROM unique_mentor_count;

