CREATE SCHEMA CONTACT_INFORMATION
GO

ALTER SCHEMA CONTACT_INFORMATION TRANSFER dbo.EMPLOYEECONTACT;
ALTER SCHEMA CONTACT_INFORMATION TRANSFER dbo.EMERGENCYCONTACTS;

SELECT * FROM CONTACT_INFORMATION.EMPLOYEECONTACT;
SELECT * FROM CONTACT_INFORMATION.EMERGENCYCONTACTS;