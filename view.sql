--1. Create a view on table employee which includes the details of employees belonging to department 1001. 
CREATE VIEW Emp_Finance
AS
SELECT emp_id, emp_name, salary, dep_id
FROM employees
WHERE dep_id = 1001;
select * from Emp_Finance
--2. Create the above view with check option so that it accepts only records of department 1001. 
CREATE or Alter VIEW Emp_Finance1 
AS
SELECT emp_id, emp_name, salary, dep_id
FROM dbo.employees
WHERE dep_id = 1001
WITH CHECK OPTION;
select * from Emp_Finance1 where dep_id = 1002

in
--3. Create a view using inner join on the tables dept and emp.  
CREATE VIEW DeptEmpView AS
SELECT d.dep_id, d.dep_name, e.emp_id, e.emp_name, e.salary
FROM department d
INNER JOIN employees e
ON d.dep_id = e.dep_id;
select * from DeptEmpView where dep_id = 1001
--4. Create a view using right join on the tables dept and emp along with schema binding. 
CREATE VIEW DepEmpView WITH SCHEMABINDING
AS
SELECT d.dep_id, d.dep_name, e.emp_id, e.emp_name, e.salary
FROM dbo.department d
LEFT JOIN dbo.employees e
ON d.dep_id = e.dep_id;
select * from DepEmpView


---------------------
drop table  dbo.employees 

insert into Emp_Finance1 ( emp_id, emp_name, salary, dep_id) values (69345,'ali',1500,1001)
insert into Emp_Finance1 ( emp_id, emp_name, salary, dep_id) values (69346,'khalid',1500,1002)