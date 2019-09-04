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


-- Task 2 
------------------------------------
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


--Task 4

--Testing 

SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS ;
SELECT * FROM JOB_HISTORY ;
SELECT * FROM JOBS ;



/* Query 1A: Select the names and job start dates of all employees who work for
 the department number 5. */

SELECT E.F_NAME, E.L_NAME, JH.START_DATE FROM 
		EMPLOYEES AS E INNER JOIN JOB_HISTORY AS JH
		ON E.EMP_ID = JH.EMPL_ID
		WHERE DEP_ID =5
		;

/* Query 1B: Select the names, job start dates, and job titles of all employees  
who work for the department number ... From 3 tables: EMPLOYEES, JOB_HISTORY; JOBS*/

SELECT E.F_NAME, E.L_NAME, JH.START_DATE, J.JOB_TITLE FROM 
		EMPLOYEES AS E 
		INNER JOIN JOB_HISTORY AS JH ON E.EMP_ID = JH.EMPL_ID
		INNER JOIN JOBS AS J ON JH.JOBS_ID = J.JOB_IDENT
		
		WHERE DEP_ID =5
		;

/*Query 2A: Perform a Left Outer Join on the EMPLOYEES and DEPARTMENT
tables and select employee id, last name, department id and department name
for all employees */

SELECT E.EMP_ID, E.L_NAME, D.DEPT_ID_DEP, D.DEP_NAME FROM 
		EMPLOYEES AS E
		LEFT OUTER JOIN DEPARTMENTS AS D 
		ON  E.DEP_ID = D.DEPT_ID_DEP
		;

/* Query 2B: Re-write the query for 2A to limit the result set to include only the
rows for employees born before 1980.  */

SELECT E.EMP_ID, E.L_NAME, D.DEPT_ID_DEP, D.DEP_NAME FROM 
		EMPLOYEES AS E
		LEFT OUTER JOIN DEPARTMENTS AS D 
		ON  E.DEP_ID = D.DEPT_ID_DEP
		WHERE  YEAR(E.B_DATE) < 1980
		;

/*Query 2C: Re-write the query for 2A to have the result set include all the
employees but department names for only the employees who were born
before 1980.*/

select E.EMP_ID,E.L_NAME,E.DEP_ID,D.DEP_NAME
	from EMPLOYEES AS E 
	LEFT OUTER JOIN DEPARTMENTS AS D ON E.DEP_ID=D.DEPT_ID_DEP 
	AND YEAR(E.B_DATE) < 1980
;
/*Query 3A: Perform a Full Join on the EMPLOYEES and DEPARTMENT tables
and select the First name, Last name and Department name of all employees.*/

select E.F_NAME,E.L_NAME,D.DEP_NAME
	from EMPLOYEES AS E 
	FULL OUTER JOIN DEPARTMENTS AS D ON E.DEP_ID=D.DEPT_ID_DEP
;

/* Query 3B: Re-write Query 3A to have the result set include all employee
names but department id and department names only for male employees.*/

select E.F_NAME,E.L_NAME,D.DEPT_ID_DEP, D.DEP_NAME
	from EMPLOYEES AS E 
	FULL OUTER JOIN DEPARTMENTS AS D ON E.DEP_ID=D.DEPT_ID_DEP AND E.SEX = 'M'
;
--- alt Query 3B ---
select E.F_NAME,E.L_NAME,D.DEPT_ID_DEP, D.DEP_NAME
	from EMPLOYEES AS E 
	LEFT OUTER JOIN DEPARTMENTS AS D ON E.DEP_ID=D.DEPT_ID_DEP AND E.SEX = 'M'
;
