CREATE TABLE department
(
dep_id INTEGER PRIMARY KEY,
dep_name VARCHAR(20),
dep_location VARCHAR(15)
);

CREATE TABLE salary_grade
(
grade INTEGER,
min_salary INTEGER,
max_salary INTEGER

);
CREATE TABLE employees
(
emp_id INTEGER,
emp_name VARCHAR(15),
job_name VARCHAR(10),
manager_id INTEGER,
hire_date DATE,
salary DECIMAL(10, 2),
commission DECIMAL(7,2),
dep_id INTEGER,
    CONSTRAINT FK_dep_id FOREIGN KEY (dep_id)
      REFERENCES department(dep_id)
);

  
  INSERT INTO department
   (dep_id  , dep_name  , dep_location)
VALUES
   (   1001 , 'FINANCE'   ,'SYDNEY'),
    ( 2001 , 'AUDIT', 'MELBOURNE'),
   (3001 ,'MARKETING' , 'PERTH'),
   (4001,  'PRODUCTION' , 'BRISBANE');
  



INSERT INTO employees
   (emp_id,emp_name,job_name,manager_id,hire_date,salary,commission,dep_id)
VALUES
   ( 68319,'KAYLING','PRESIDENT', NULL, '1991-11-18',6000.00,NULL,1001),
    ( 66928 , 'BLAZE'    , 'MANAGER'   ,      68319 , '1991-05-01' , 2750.00 ,      NULL      ,  3001),
 ( 67832 , 'CLARE'    ,'MANAGER'   ,      68319 , '1991-06-09' , 2550.00 ,     NULL       ,   1001),
  (65646 , 'JONAS'    , 'MANAGER'   ,      68319 , '1991-04-02', 2957.00 , NULL,   2001),
  (67858 , 'SCARLET'  , 'ANALYST'   ,      65646 , '1997-04-19' , 3100.00 , NULL,   2001),
  (69062 , 'FRANK'    , 'ANALYST'   ,      65646 , '1991-12-03' , 3100.00 , NULL,  2001),
  (63679 , 'SANDRINE' , 'CLERK'       ,    69062 , '1990-12-18' ,  900.00 ,          NULL  ,  2001),
  (64989 , 'ADELYN'   , 'SALESMAN' ,       66928 , '1991-02-20',  1700.00 ,     400.00 ,   3001),
  (65271 , 'WADE'     , 'SALESMAN'  ,     66928 , '1991-02-22'  ,1350.00 ,     600.00 ,   3001),
  (66564 , 'MADDEN'   , 'SALESMAN'  ,      66928 , '1991-09-28'  ,1350.00 ,    1500.00 ,   3001),
  (68454 , 'TUCKER'   , 'SALESMAN'  ,      66928 , '1991-09-08' , 1600.00 ,       0.00 ,   3001),
  (68736 , 'ADNRES'   ,'CLERK'     ,      67858 , '1997-05-23' , 1200.00 ,   NULL,   2001),
  (69000 , 'JULIUS'   , 'CLERK'     ,     66928 , '1991-12-03' , 1050.00 ,  NULL,  3001),
  (69324 , 'MARKER'   , 'CLERK'     ,      67832 , '1992-01-23' , 1400.00 ,   NULL ,   1001);


  INSERT INTO salary_grade
   (grade,min_salary,max_salary)
VALUES
   (1,800,1300),
    (2,1301,1500),
   (3,1501,2100),
   (4,2101,3100),
   (5,310,9999);
  
  SELECT * from employees
    DELETE FROM 