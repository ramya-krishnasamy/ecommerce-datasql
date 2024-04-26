

--SECTION B

----1.USER DEFINED FUNCTION-----

CREATE FUNCTION dbo.LastNameFirst7(@FName VARCHAR(50), @LName VARCHAR(50))
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @FullName VARCHAR(100);
    SET @FullName = @LName + ', ' + @FName;
    RETURN @FullName;
END
SELECT EmployeeID,dbo.LastNameFirst7(FName,LName) AS 'Display Name',
SALARY FROM EMPLOYEE
GO



------2.CREATE AND A TEST VIEW---------

CREATE PROCEDURE EmployeeMedicalConcerns @employee_id INT
AS 
BEGIN
SELECT A.AllergyName FROM EmployeeAllergy AS EA
INNER JOIN Allergy AS A ON EA.AllergyID=A.Allergy WHERE EA.EmployeeID = @employee_id;
END;


-----4.BUILD THE STORED PROCEDURE--------------

CREATE PROCEDURE StoredProcedure AS 

BEGIN

SET NOCOUNT ON;

UPDATE EMPLOYEE set Salary = FORMAT(CAST(Salary AS INT), 'C') WHERE Salary IS NOT NULL and  Salary NOT LIKE '%$%'

END;
Execute StoredProcedure