-------------------------------------------------------Tutorial-1------------------------------------------------------
--Name: Sabin Acharya
--Roll no.: THA077BEI035
--Description: Tutorial-1
-----------------------------------------------------------------------------------------------------------------------

--CONTENTS:

------------------------------------------------Figure 5: Employee database---------------------------------------------
--employee(employee-name, street, city)
--works(employee-name, company-name, salary)
--company(company-name, city)
--manages (employee-name, manager-name)
-----------------------------------------------------------------------------------------------------------------------



--QUESTIONS:


--1.) Give an SQL schema definition for the employee database of Figure 5. Choose an appropriate primary key for each relation schema, and insert any other integrity constraints (for example, foreign keys) you find necessary

CREATE TABLE
    tbl_Employee (
        employee_name VARCHAR(255) NOT NULL,
        street VARCHAR(255) NOT NULL,
        city VARCHAR(255) NOT NULL,
        PRIMARY KEY(employee_name)
    );
 
CREATE TABLE
    tbl_Company (
        company_name VARCHAR(255) NOT NULL,
        city VARCHAR(255),
        PRIMARY KEY(company_name)
    );
 
CREATE TABLE
    tbl_Works (
        employee_name VARCHAR(255) NOT NULL,
        FOREIGN KEY (employee_name) REFERENCES tbl_Employee(employee_name),
        company_name VARCHAR(255) FOREIGN KEY REFERENCES tbl_Company(company_name),
        salary DECIMAL(10, 2)
    );
 
CREATE TABLE
    tbl_Manages (
        employee_name VARCHAR(255) NOT NULL,
        FOREIGN KEY (employee_name) REFERENCES tbl_Employee(employee_name),
        manager_name VARCHAR(255) FOREIGN KEY REFERENCES tbl_Employee(employee_name),
    );
 
INSERT INTO
    tbl_Employee (employee_name, street, city)
VALUES (
        'Alice Williams',
        '321 Maple St',
        'Houston'
    ), (
        'Sara Davis',
        '159 Broadway',
        'New York'
    ), (
        'Mark Thompson',
        '235 Fifth Ave',
        'New York'
    ), (
        'Ashley Johnson',
        '876 Market St',
        'Chicago'
    ), (
        'Emily Williams',
        '741 First St',
        'Los Angeles'
    ), (
        'Michael Brown',
        '902 Main St',
        'Houston'
    ), (
        'Samantha Smith',
        '111 Second St',
        'Chicago'
    ), (
        'Patrick',
        '123 Main St',
        'New Mexico'
    ), (
        'Jane Doe',
        '123 Main St',
        'New Mexico'
    ), (
		'John Smith',
		'902 Street', 
		'Houston'
	);

INSERT INTO
    tbl_Company (company_name, city)
VALUES (
        'Small Bank Corporation', 'Chicago'), 
        ('ABC Inc', 'Los Angeles'), 
        ('Def Co', 'Houston'), 
        ('First Bank Corporation','New York'), 
        ('456 Corp', 'Chicago'), 
        ('789 Inc', 'Los Angeles'), 
        ('321 Co', 'Houston'),
        ('Pongyang Corporation','Chicago'
    );
 
INSERT INTO
    tbl_Works (
        employee_name,
        company_name,
        salary
    )
VALUES (
        'Alice Williams',
        'Small Bank Corporation',
        82500.00
    ), (
        'Sara Davis',
        'First Bank Corporation',
        82500.00
    ), (
        'Mark Thompson',
        'Small Bank Corporation',
        78000.00
    ), (
        'Ashley Johnson',
        'Small Bank Corporation',
        92000.00
    ), (
        'Emily Williams',
        'Small Bank Corporation',
        86500.00
    ), (
        'Michael Brown',
        'Small Bank Corporation',
        81000.00
    ), (
        'Samantha Smith',
        'First Bank Corporation',
        77000.00
    ), (
        'Jane Doe',
        'Pongyang Corporation',
        79000.00
    ), (
        'John Smith',
        'Pongyang Corporation',
        110000.00
    ), (
        'Patrick',
        'Pongyang Corporation',
        500000
    );
 
 
INSERT INTO
    tbl_Manages(employee_name, manager_name)
VALUES 
    ('Mark Thompson', 'Emily Williams'),
    ('John Smith', 'Jane Doe'),
    ('Alice Williams', 'Emily Williams'),
    ('Samantha Smith', 'Sara Davis'),
    ('Patrick', 'Jane Doe');


--2.)  Consider the employee database of Figure 5, where the primary keys are underlined. Give an expression in SQL for each of the following queries:


-------a.)  Find the names of all employees who work for First Bank Corporation.
--------------i.) Using Queries:
				SELECT tbl_Employee.employee_name FROM tbl_Employee, tbl_Works WHERE tbl_Employee.employee_name = tbl_Works.employee_name AND tbl_Works.company_name = 'First Bank Corporation';
--------------ii.) Using Subqueries:
				SELECT employee_name FROM tbl_Employee WHERE employee_name IN (SELECT employee_name FROM tbl_Works WHERE tbl_Works.company_name = 'First Bank Corporation' );
--------------iii.) Using Join
				SELECT tbl_Employee.employee_name FROM tbl_Employee JOIN tbl_Works on tbl_Employee.employee_name= tbl_Works.employee_name WHERE tbl_Works.company_name='First Bank Corporation';



-------b.)  Find the names and cities of residence of all employees who work for First Bank Corporation.
--------------i.) Using Queries:
				SELECT tbl_Employee.employee_name, tbl_Employee.city FROM tbl_Employee, tbl_Works WHERE tbl_Employee.employee_name = tbl_Works.employee_name AND tbl_Works.company_name = 'First Bank Corporation';
--------------ii.) Using Subqueries:
				SELECT employee_name, city FROM tbl_Employee WHERE employee_name IN (SELECT employee_name FROM tbl_Works WHERE tbl_Works.company_name = 'First Bank Corporation' );
--------------iii.) Using Join
				SELECT tbl_Employee.employee_name, tbl_Employee.city FROM tbl_Employee JOIN tbl_Works on tbl_Employee.employee_name= tbl_Works.employee_name WHERE tbl_Works.company_name='First Bank Corporation';



-------d.)  Find all employees in the database who live in the same cities as the companies for which they work.
--------------i.) Using Queries:
				SELECT tbl_Employee.employee_name FROM tbl_Employee, tbl_Works, tbl_Company WHERE tbl_Employee.employee_name = tbl_Works.employee_name AND tbl_Works.company_name = tbl_Company.company_name AND tbl_Company.city = tbl_Employee.city;
--------------ii.) Using Subqueries:
				SELECT employee_name FROM tbl_Employee WHERE employee_name IN (SELECT employee_name FROM tbl_Works WHERE company_name IN (SELECT company_name FROM tbl_Company WHERE tbl_Company.city = tbl_Employee.city));
--------------iii.) Using Join
				SELECT tbl_Employee.employee_name FROM tbl_Employee JOIN tbl_Works on tbl_Employee.employee_name= tbl_Works.employee_name JOIN tbl_Company on tbl_Company.company_name=tbl_Works.company_name WHERE tbl_Company.city = tbl_Employee.city;



-------e.)   Find all employees in the database who live in the same cities and on the same streets as do their managers.
--------------i.) Using Queries:
				SELECT emp.employee_name FROM tbl_Employee emp, tbl_Manages, tbl_Employee mgr WHERE emp.employee_name = tbl_Manages.employee_name AND tbl_Manages.manager_name = mgr.employee_name AND emp.city = mgr.city AND emp.street = mgr.street;
--------------ii.) Using Subqueries:
				SELECT emp.employee_name FROM tbl_Employee emp WHERE emp.city IN (SELECT city FROM tbl_Employee WHERE tbl_Employee.employee_name IN (SELECT manager_name FROM tbl_Manages WHERE tbl_Manages.employee_name = emp.employee_name) ) AND emp.street IN (SELECT street FROM tbl_Employee WHERE tbl_Employee.employee_name IN (SELECT manager_name FROM tbl_Manages WHERE tbl_Manages.employee_name = emp.employee_name));
--------------iii.) Using Join
				SELECT emp.employee_name FROM tbl_Employee emp JOIN tbl_Manages on emp.employee_name=tbl_Manages.employee_name JOIN tbl_Employee mgr on tbl_Manages.manager_name = mgr.employee_name WHERE emp.city = mgr.city AND emp.street = mgr.street;



-------f.)   Find all employees in the database who do not work for First Bank Corporation.
--------------i.) Using Queries:
				SELECT tbl_Employee.employee_name FROM tbl_Employee, tbl_Works WHERE tbl_Employee.employee_name = tbl_Works.employee_name AND NOT tbl_Works.company_name = 'First Bank Corporation';
--------------ii.) Using Subqueries:
				SELECT employee_name FROM tbl_Employee WHERE employee_name IN (SELECT employee_name FROM tbl_Works WHERE NOT tbl_Works.company_name = 'First Bank Corporation' );
--------------iii.) Using Join
				SELECT tbl_Employee.employee_name FROM tbl_Employee JOIN tbl_Works on tbl_Employee.employee_name= tbl_Works.employee_name WHERE NOT tbl_Works.company_name='First Bank Corporation';



-------g.)  Find all employees in the database who earn more than each employee of Small Bank Corporation..
--------------i.) Using SubQueries:
				SELECT tbl_Employee.employee_name FROM tbl_Employee, tbl_Works WHERE tbl_Employee.employee_name = tbl_Works.employee_name AND tbl_Works.salary > (SELECT MAX(salary) FROM tbl_Works WHERE tbl_Works.company_name='Small Bank Corporation');



-------h.)   Assume that the companies may be located in several cities. Find all companies located in every city in which Small Bank Corporation is located
--------------i.) Using SubQueries:
				SELECT company_name FROM tbl_Company WHERE city = (SELECT city FROM tbl_Company WHERE company_name = 'Small Bank Corporation');




-------i.)   Find all employees who earn more than the average salary of all employees of their company.
--------------i.) Using SubQueries:
				SELECT tbl_Employee.employee_name FROM tbl_Employee, tbl_Works wrk WHERE tbl_Employee.employee_name = wrk.employee_name AND wrk.salary > (SELECT AVG(salary) FROM tbl_Works WHERE tbl_Works.company_name = wrk.company_name );



-------j.)   Find the company that has the most employees.
--------------i.) Using Queries:
				SELECT TOP 1 company_name, COUNT(*) AS Employee_Count FROM tbl_Works GROUP BY company_name ORDER BY COUNT(*) DESC;




-------k.)   Find the company that has the smallest payroll.
--------------i.) Using SubQueries:
				SELECT company_name FROM tbl_Works WHERE salary = (SELECT MIN(salary) FROM tbl_Works);



-------l.)   Find those companies whose employees earn a higher salary, on average, than the average salary at First Bank Corporation.
--------------i.) Using SubQueries:
				SELECT company_name FROM tbl_Works GROUP BY company_name HAVING AVG(salary) > (SELECT AVG(salary) FROM tbl_Works WHERE company_name = 'First Bank Corporation');


--3.)  Consider the relational database of Figure 5. Give an expression in SQL for each of the following queries:
-------a.)    Modify the database so that Jones now lives in Newtown.
				UPDATE tbl_Employee SET city = 'Newtown' WHERE employee_name='Jones';
				




SELECT * FROM tbl_Employee;
SELECT * FROM tbl_Company;
SELECT * FROM tbl_Works;
SELECT * FROM tbl_Manages;
