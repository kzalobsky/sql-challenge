DROP TABLE if exists department_manager;
DROP TABLE if exists department_employee;
DROP TABLE if exists salaries;
DROP TABLE if exists titles;
DROP TABLE if exists departments;
DROP TABLE if exists employees;

--Create a table for the employee information with a primary key - employee number

CREATE TABLE employees(
	employee_number INT NOT NULL,
	employee_title_id CHAR(5),
	birth_date DATE NOT NULL, 
	first_name VARCHAR(30) NOT NULL, 
	last_name VARCHAR (30) NOT NULL,
	gender CHAR(1) NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (employee_number)
);

--Create a table defining the departments with a primary key for the deparment number and a unique identifying key for each department
CREATE TABLE departments(
	department_number CHAR (4) NOT NULL,
	department_name VARCHAR (50) NOT NULL,
	PRIMARY KEY (department_number)
	
);
--UNIQUE KEY (department_name)

--Create a table for the department managers, use foreign keys to relate the employee and department numbers to the department manager
CREATE TABLE department_manager(
	department_number CHAR(4) NOT NULL,
	employee_number INT NOT NULL,
	FOREIGN KEY (employee_number) REFERENCES employees (employee_number),
	FOREIGN KEY (department_number) REFERENCES departments (department_number),
	PRIMARY KEY (employee_number, department_number)
);

--Create a table for the employees in each department
CREATE TABLE department_employee (
	employee_number INT NOT NULL,
	department_number CHAR (4) NOT NULL,
	FOREIGN KEY (employee_number) REFERENCES employees (employee_number),
	FOREIGN KEY (department_number) REFERENCES departments (department_number),
	PRIMARY KEY (employee_number, department_number)
);

-- Create a table for the employee titles
CREATE TABLE titles(
	title_id CHAR(5) NOT NULL,
	title VARCHAR(50) NOT NULL,
	PRIMARY KEY (title_id)
);

--Create a table for the employee salaries
CREATE TABLE salaries(
	employee_number INT NOT NULL,
	salary INT NOT NULL,
	FOREIGN KEY (employee_number) REFERENCES employees (employee_number),
	PRIMARY KEY (employee_number)
);

--Checking data import
SELECT *
FROM department_employee;

SELECT *
FROM department_manager;

SELECT *
FROM DEPARTMENTS;

SELECT *
FROM employees

SELECT *
FROM salaries;

SELECT *
FROM titles;

--List the employee #, last & first names, gender and salary for each employee
SELECT employees.employee_number, employees.last_name, employees.first_name, employees.gender, salaries.salary
FROM employees
INNER JOIN salaries ON
salaries.employee_number=employees.employee_number;

--Count how many employees were hired in 1986
SELECT COUNT(hire_date) FROM employees
WHERE hire_date between '1986-01-01' and '1986-12-31';
--List the first & last names and hire dates for those that were hired in 1986
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date between '1986-01-01' and '1986-12-31' ORDER BY hire_date;

--List the manager of each dpt, dpt #, dept name, employee #, last & first names
SELECT departments.department_number, departments.department_name, department_manager.employee_number, employees.last_name, employees.first_name
FROM departments
INNER JOIN department_manager on departments.department_number=department_manager.department_number
INNER JOIN employees on department_manager.employee_number=employees.employee_number ORDER BY employee_number;

--List dpt # for each employee, employee #, last & first names, and dpt name
SELECT employees.employee_number, employees.last_name, employees.first_name, departments.department_name
FROM employees
INNER JOIN department_employee on department_employee.employee_number=employees.employee_number
INNER JOIN departments on departments.department_number=department_employee.department_number
ORDER BY employee_number;

--List first & last names and gender for all employees first name Hercules and last name starting with B
SELECT first_name, last_name, gender FROM employees
WHERE first_name = 'Hercules' and last_name like 'B%';

--List each employee in the Sales dpt with their employee #, last & first names
SELECT employees.employee_number, employees.last_name, employees.first_name, departments.department_name
FROM employees
INNER JOIN department_employee on department_employee.employee_number=employees.employee_number
INNER JOIN departments on departments.department_number=department_employee.department_number
WHERE department_name = 'Sales' ORDER BY employee_number;

--List each employee in the Sales and Development dpts with thier employee #, last & first names, and dpt name
SELECT employees.employee_number, employees.last_name, employees.first_name, departments.department_name
FROM employees
INNER JOIN department_employee on department_employee.employee_number=employees.employee_number
INNER JOIN departments on departments.department_number=department_employee.department_number
WHERE department_name = 'Sales' or department_name = 'Department' ORDER BY employee_number;

--List the frequency counts in DESCENDING order of the employee last name
--Getting total amount of last names
SELECT COUNT(last_name) FROM employees;
--Counting by last name
SELECT last_name, COUNT(last_name) AS "Last_Names"
FROM employees
GROUP BY last_name
ORDER BY "Last_Names" DESC;