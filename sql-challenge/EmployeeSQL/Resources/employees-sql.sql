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
