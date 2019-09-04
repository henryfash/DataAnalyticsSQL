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
