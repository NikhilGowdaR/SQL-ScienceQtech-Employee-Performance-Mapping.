CREATE DATABASE employee;
USE employee;
###Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT from the 
###employee record table, and make a  list of employees and details of their department.

Select * from data_science_team;
Select * from emp_record_table;
select* from proj_table;
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DET FROM emp_record_table;

###Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: 
##less than two , greater than four ,  between two and four

SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING FROM emp_record_table
WHERE EMP_RATING < 2;

SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING FROM emp_record_table
WHERE EMP_RATING > 4;

SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING FROM emp_record_table
WHERE EMP_RATING >= 2 AND EMP_RATING <= 4 ;

##Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance department from the 
##employee table and then give the resultant column alias as NAME.

SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS NAME
FROM emp_record_table
WHERE DEPT = 'FINANCE';

##Write a query to list only those employees who have someone reporting to them. Also, show the number of reporters (including the President).
SELECT EMP_ID, FIRST_NAME, LAST_NAME,MANAGER_ID, 
(SELECT COUNT(*) FROM emp_record_table WHERE MANAGER_ID = e.EMP_ID) AS NumReporters
FROM emp_record_table e
Where MANAGER_ID is not null;

### Write a query to list down all the employees from the healthcare and finance departments using union.
## Take data from the employee record table.

select EMP_ID, FIRST_NAME, LAST_NAME, DEPT FROM emp_record_table
where DEPT = 'healthcare' 
union
select EMP_ID, FIRST_NAME, LAST_NAME, DEPT FROM emp_record_table
where DEPT = 'finance' 

## also
SELECT EMP_ID, FIRST_NAME, LAST_NAME, DEPT
FROM emp_record_table
WHERE DEPT IN ('HEALTHCARE', 'FINANCE');

###Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, 
### and EMP_RATING grouped by dept. Also include the respective employee rating along with the max emp rating for the department.

 SELECT EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPT, EMP_RATING, MAX(EMP_RATING) OVER (PARTITION BY DEPT) AS MaxRatingInDept
 FROM   emp_record_table
 
 ### Write a query to calculate the minimum and the maximum salary of the employees in each role. Take data from the employee record table.
 select  ROLE,MAX(SALARY) AS MAX_SALRY, MIN(SALARY) AS MIN_SALARY  FROM  emp_record_table
 GROUP BY ROLE ;
 
 ### 10.Write a query to assign ranks to each employee based on their experience. Take data from the employee record table.
SELECT EMP_ID, FIRST_NAME, LAST_NAME, EXP, RANK() OVER (ORDER BY EXP) AS ExperienceRank
FROM  emp_record_table
### ALSO
SELECT EMP_ID, FIRST_NAME, LAST_NAME, EXP, DENSE_RANK() OVER (ORDER BY EXP) AS ExperienceRank
FROM  emp_record_table

###Write a query to create a view that displays employees in various countries 
##whose salary is more than six thousand. Take data from the employee record table.
CREATE VIEW HighSalaryEmployees AS
SELECT EMP_ID, FIRST_NAME, LAST_NAME,SALARY, COUNTRY FROM emp_record_table
 WHERE SALARY > 6000 ;
 
 ##3 Write a nested query to find employees with experience of more than ten years. Take data from the employee record table.
 
 SELECT EMP_ID, FIRST_NAME, LAST_NAME,EXP FROM emp_record_table
 WHERE EXP > 10
 ## ALSO
 SELECT EMP_ID, FIRST_NAME, LAST_NAME,EXP FROM emp_record_table
 WHERE  EXP > (SELECT MAX(EXP) FROM emp_record_table WHERE EXP <= 10);
 
 #### Write a query to create a stored procedure to retrieve the details OF
 ##the employees whose experience is more than three years. Take data from the employee record table.
 
 Delimiter //
 create procedure EMP_more_exp()
 begin
 SELECT EMP_ID, FIRST_NAME, LAST_NAME,EXP FROM emp_record_table
 WHERE EXP > 3;
 end //
 Delimiter ;
 call EMP_more_exp();
 
 
 ####14 Write a query using stored functions in the project table to check
 ### whether the job profile assigned to each employee in the data science team matches the organization’s set standard.

use employee
drop function DetermineJobProfile
 DELIMITER //
 CREATE FUNCTION DetermineJobProfile(exp INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE jobProfile VARCHAR(50);

    IF exp <= 2 THEN
        SET jobProfile = 'JUNIOR DATA SCIENTIST';
    ELSEIF exp <= 5 THEN
        SET jobProfile = 'ASSOCIATE DATA SCIENTIST';
    ELSEIF exp <= 10 THEN
        SET jobProfile = 'SENIOR DATA SCIENTIST';
    ELSEIF exp <= 12 THEN
        SET jobProfile = 'LEAD DATA SCIENTIST';
    ELSE
        SET jobProfile = 'MANAGER';
    END IF;

    RETURN jobProfile;
END //

DELIMITER ;

-- Use the stored function in a query for the project table
SELECT
    EMP_ID,
    FIRST_NAME,
    LAST_NAME,
    EXP,
    DetermineJobProfile(EXE) AS JobProfile
FROM proj_table
WHERE
    DEPT = 'Data Science';
LIMIT 0, 1000;
 
 SHOW TABLES FROM employee;
 
 
 
 ## 15 
 CREATE INDEX idx_first_name ON emp_record_table (FIRST_NAME(100));
 EXPLAIN SELECT * FROM emp_record_table WHERE FIRST_NAME = 'Eric';
 
 
 ##16
 SELECT
    EMP_ID,
    FIRST_NAME,
    LAST_NAME,
    SALARY,
    EMP_RATING,
    0.05 * SALARY * EMP_RATING AS Bonus
FROM
    emp_record_table;
    
    
    ## 17 
    
    SELECT
    CONTINENT,
    COUNTRY,
    AVG(SALARY) AS AverageSalary
FROM
    emp_record_table
GROUP BY
    CONTINENT,
    COUNTRY;
 
 