USE Task_4
GO

CREATE VIEW EmployeesProbation
AS

SELECT DISTINCT EMPLOYEE.EmployeeID, Employee.FName, Employee.LName, Employee.RoleID
FROM dbo.EMPLOYEE Employee
JOIN dbo.ROLES Role ON Employee.RoleID = Role.RoleID
WHERE Employee.Probation != 'Completed'
AND DATEDIFF(day, Employee.HireDate, GETDATE()) <= CAST(Role.ProbationLength as varchar)


SELECT * FROM dbo.EmployeesProbation
