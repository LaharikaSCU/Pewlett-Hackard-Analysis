--Retirment_titles table creation
SELECT e.emp_no, 
       e.first_name, 
       e.last_name, 
       ti.title, 
       ti.from_date, 
       ti.to_date
INTO retirment_titles
FROM employees AS e
INNER JOIN titles AS ti
ON ti.emp_no = e.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

--unique_titles table creation
SELECT DISTINCT ON (rt.emp_no) emp_no, 
                   rt.first_name, 
                   rt.last_name, 
                   rt.title
INTO unique_titles
FROM retirment_titles AS rt
ORDER BY rt.emp_no ASC, rt.to_date DESC;

--retiring_titles table creation
SELECT COUNT(title) AS title_count, 
       title 
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY title_count DESC;

--mentorship_elibility table creation
SELECT DISTINCT ON (rd.emp_no) emp_no, 
                   rd.first_name, 
                   rd.last_name, 
                   rd.birth_date,
                   rd.from_date, 
                   rd.to_date, 
                   rd.title
INTO mentorship_eligibility
FROM retirement_dates AS rd
WHERE rd.to_date = '9999-01-01' AND (rd.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY rd.emp_no;