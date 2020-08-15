select * from "Departments"
select * from "Employees"
select * from "Salaries"

--**************************************************************************************
--Question 1 - Query to get: employee number, last name, first name, sex, and salary
select e.emp_no, 
e.last_name, e.first_name, e.sex, s.salary
from "Employees" as e
left join "Salaries" as s
	On e.emp_no = s.emp_no
order by e.emp_no ASC;

--Query to get table of employee names, sex and salary.  Not required for assignment but wanted to see number of records
select count(emp_no) as "Query"
from
(
select e.emp_no, 
e.last_name, e.first_name, e.sex, s.salary
from "Employees" as e
right join "Salaries" as s
	On e.emp_no = s.emp_no
order by e.emp_no ASC
) as c ;

--******************************************************************************************
--Question 2: List first name, last name, and hire date for employees who were hired in 1986.
select e.first_name, e.last_name, hire_date
from "Employees" as e
where (e.hire_date >= '1986-01-01' and e.hire_date <= '1986-12-31') --single quotes to define string rather than column
order by e.hire_date asc;

--******************************************************************************************
--Question 3: List the manager of each department with the following information: department number, department name, 
--the manager's employee number, last name, first name.
select dm.dept_no,  d.dept_name, dm.emp_no,e.last_name, e.first_name
from "Dept_manager" as dm
inner join "Departments" as d
	on dm.dept_no = d.dept_no
inner join "Employees" as e
	on dm.emp_no = e.emp_no
order by dm.dept_no Asc;

--******************************************************************************************
--Question 4: List the department of each employee with the following information: employee number, last name, first name, and department name.
select e.emp_no, e.last_name, e.first_name, d.dept_name
from "Employees" as e
inner join "Dept_Empl" as de
	on e.emp_no = de.emp_no
inner join "Departments" as d
	on de.dept_no = d.dept_no;
	
--******************************************************************************************
--Question 5: List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
select e.last_name, e.first_name, e.sex
from "Employees" as e
where (lower(e.first_name) like lower('HERCULES') and lower(e.last_name) like lower('B%'));

--******************************************************************************************
--Question 6: List all employees in the Sales department, including their employee number, last name, first name, and department name.
select e.emp_no, e.last_name, e.first_name, d.dept_name
from "Employees" as e
inner join "Dept_Empl" as de
	on e.emp_no = de.emp_no
inner join "Departments" as d
	on de.dept_no = d.dept_no
where (d.dept_name = 'Sales');

--******************************************************************************************
--Question 7: List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
select e.emp_no, e.last_name, e.first_name, d.dept_name
from "Employees" as e
inner join "Dept_Empl" as de
	on e.emp_no = de.emp_no
inner join "Departments" as d
	on de.dept_no = d.dept_no
--where (d.dept_name = 'Sales' or d.dept_name = 'Development');
where (d.dept_name in ('Sales', 'Development')) --found use of IN reading on Slack
order by e.emp_no

--******************************************************************************************
--Question 8: In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
select e.last_name, count(e.last_name) as name_count  	--initially included distinct with count, but this is really to count the number of distinct names 
														--not number of occurance of each unique name. 
from "Employees" as e
group by e.last_name
order by name_count desc;


--*********************************************************************************************
--support for bonus

create view title_salary as 

	select e.emp_no, e.emp_title_id, t.title, s.salary
	from "Employees" as e
	inner join "Salaries" as s
		on e.emp_no = s.emp_no
	inner join "Titles" as t
		on e.emp_title_id = t.title_id

	order by e.emp_no;
	
select * from title_salary;

select * from "Departments";
select * from "Dept_Empl";
select * from "Titles"

select * from "Employees"
where emp_no = '10017'; --#marketing

select last_name from "Employees"
where emp_title_id = 'd002'; --#finance