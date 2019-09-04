--Task 1

-- remove any table with the name INSTRUCTOR

DROP TABLE INSTRUCTOR
;

--Creates a table INSTRUCTOR
CREATE TABLE INSTRUCTOR (
ins_id INTEGER PRIMARY KEY NOT NULL,
lastname VARCHAR(15) NOT NULL,
firstname VARCHAR(15) NOT NULL,
city VARCHAR(15),
country char(2)
)
;

--Insert one row into the table 
INSERT INTO INSTRUCTOR 
(ins_id, lastname, firstname, city, country)
VALUES
(1, 'Ahuja', 'Rav', 'Toronto', 'CA')

;

--inserting multiple rows at the same time
INSERT into INSTRUCTOR 
(ins_id, lastname, firstname, city, country)
VALUES
(2, 'Chong', 'Raul', 'Toronto', 'CA'),
(3, 'Vasudevan', 'Hima', 'Chicago', 'US')
;

--Query the table to get all fields
select * from INSTRUCTOR;

--Query just to obtain the firstname, lastname and country
SELECT firstname, lastname, country from INSTRUCTOR 
WHERE city = 'Toronto';

--Update one row
UPDATE INSTRUCTOR SET
city = 'Markham' WHERE ins_id =1 
;

select city from INSTRUCTOR
where ins_id = 1 
;

--Delete a row
DELETE FROM INSTRUCTOR
WHERE ins_id = 2 
;

--Query to obtain all fields
select * from INSTRUCTOR;

-- Task 2 

------------------------------------------
--DDL statement for table 'HR' database--
--------------------------------------------

CREATE TABLE EMPLOYEES (
                            EMP_ID CHAR(9) NOT NULL, 
                            F_NAME VARCHAR(15) NOT NULL,
                            L_NAME VARCHAR(15) NOT NULL,
                            SSN CHAR(9),
                            B_DATE DATE,
                            SEX CHAR,
                            ADDRESS VARCHAR(30),
                            JOB_ID CHAR(9),
                            SALARY DECIMAL(10,2),
                            MANAGER_ID CHAR(9),
                            DEP_ID CHAR(9) NOT NULL,
                            PRIMARY KEY (EMP_ID));
                            
  CREATE TABLE JOB_HISTORY (
                            EMPL_ID CHAR(9) NOT NULL, 
                            START_DATE DATE,
                            JOBS_ID CHAR(9) NOT NULL,
                            DEPT_ID CHAR(9),
                            PRIMARY KEY (EMPL_ID,JOBS_ID));
 
 CREATE TABLE JOBS (
                            JOB_IDENT CHAR(9) NOT NULL, 
                            JOB_TITLE VARCHAR(15) ,
                            MIN_SALARY DECIMAL(10,2),
                            MAX_SALARY DECIMAL(10,2),
                            PRIMARY KEY (JOB_IDENT));

CREATE TABLE DEPARTMENTS (
                            DEPT_ID_DEP CHAR(9) NOT NULL, 
                            DEP_NAME VARCHAR(15) ,
                            MANAGER_ID CHAR(9),
                            LOC_ID CHAR(9),
                            PRIMARY KEY (DEPT_ID_DEP));

CREATE TABLE LOCATIONS (
                            LOCT_ID CHAR(9) NOT NULL,
                            DEP_ID_LOC CHAR(9) NOT NULL,
                            PRIMARY KEY (LOCT_ID,DEP_ID_LOC));
 
 -- query 1 ;
 SELECT * FROM EMPLOYEES 
 							WHERE  ADDRESS LIKE  '% Elgin,IL%'
                          ;
                            
 --query 2 
 SELECT * FROM EMPLOYEES
 								WHERE B_DATE LIKE  '197%'
 								;
 
 --query3 ;
 SELECT * FROM EMPLOYEES
 								WHERE (SALARY BETWEEN  60000 and 70000) AND DEP_ID = 5
 								;
 
 --QUERY 4A
 SELECT * FROM EMPLOYEES
 								ORDER BY DEP_ID
 								;

 --QUERY 4B
 SELECT * FROM EMPLOYEES
 								ORDER BY DEP_ID DESC, L_NAME DESC
 								;
 
--query 5A
SELECT DEP_ID, COUNT(*)
								FROM EMPLOYEES
								GROUP BY DEP_ID
								;
--QUERY 5B & C;
SELECT  DEP_ID, COUNT(*) AS NUM_EMPLOYEES , AVG(SALARY) AS AVG_SALARY
								FROM EMPLOYEES
								GROUP BY DEP_ID
								;

--QUERY 5D;
SELECT  DEP_ID, COUNT(*) AS NUM_EMPLOYEES , AVG(SALARY) AS AVG_SALARY
								FROM EMPLOYEES
								GROUP BY DEP_ID ORDER BY AVG_SALARY
								;

--QUERY 5E;
SELECT  DEP_ID, COUNT(*) AS NUM_EMPLOYEES , AVG(SALARY) AS AVG_SALARY
								FROM EMPLOYEES
								GROUP BY DEP_ID  
								HAVING COUNT(*) < 4
								ORDER BY AVG_SALARY
								;

--5E alternative: if you want to use the label
select DEP_ID, NUM_EMPLOYEES, AVG_SALARY from
  ( select DEP_ID, COUNT(*) AS NUM_EMPLOYEES, AVG(SALARY) AS AVG_SALARY from EMPLOYEES group by DEP_ID)
  where NUM_EMPLOYEES < 4
order by AVG_SALARY;
--BONUS Query6--
;
select D.DEP_NAME , E.F_NAME, E.L_NAME
from EMPLOYEES as E, DEPARTMENTS as D
where E.DEP_ID = D.DEPT_ID_DEP
order by D.DEP_NAME, E.L_NAME desc ;

