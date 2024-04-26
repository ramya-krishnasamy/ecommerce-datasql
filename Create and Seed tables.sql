USE Group_1
GO


CREATE TABLE dbo.REGIONS
(	RegionID int  NOT NULL,
	RegionName varchar(50),
	CONSTRAINT PK_REGIONS_RegionID PRIMARY KEY (RegionID)
);

CREATE TABLE dbo.COUNTRIES
(	CountryID int  NOT NULL,
	RegionID int NOT NULL,
	CountryName varchar(50) NOT NULL CONSTRAINT Check_CountryName CHECK (CountryName IN ('Canada','Columbia','Brazil','Uganda','Vietnam','Indonesia')),
	CONSTRAINT PK_COUNTRIES_CountryID PRIMARY KEY (CountryID),
	CONSTRAINT FK_COUNTRIES_RegionID FOREIGN KEY (RegionID) REFERENCES REGIONS(RegionID)
);

CREATE TABLE dbo.FACILITYADDRESS 
(   FacilityID int NOT NULL  IDENTITY(1,1),
    CountryID int NOT NULL,
    FacilityName varchar(50) NOT NULL,
	CONSTRAINT PK_FACILITYADDRESS_FacilityID PRIMARY KEY (FacilityID),
    CONSTRAINT FK_FACILITYADDRESS_CountryID FOREIGN KEY (CountryID) REFERENCES COUNTRIES(CountryID)
);

CREATE TABLE dbo.ADDRESS
(	AddressID int  NOT NULL,
	FacilityID int NOT NULL,
	StreetNumber int,
	StreetName varchar(50),
	StreetType varchar(50),
	PostalCode varchar(50),
	City varchar(50),
	Province varchar(50)
	CONSTRAINT PK_ADDRESS_AddressID PRIMARY KEY (AddressID),
	CONSTRAINT FK_ADDRESS_FacilityID FOREIGN KEY (FacilityID) REFERENCES FACILITYADDRESS (FacilityID)
);


CREATE TABLE dbo.DEPARTMENTS
(	DepartmentID int IDENTITY(10,10),
	FacilityID int NOT NULL,
	DepartmentName varchar(50),
	DepartmentDesc varchar(225),
	CONSTRAINT PK_DEPARTMENTS_DepartmentID PRIMARY KEY (DepartmentID),
	CONSTRAINT FK_DEPARTMENTS_FacilityID FOREIGN KEY (FacilityID) REFERENCES FACILITYADDRESS (FacilityID)
);



CREATE TABLE dbo.ROLES 
(   RoleID int NOT NULL,
    PositionTitle varchar(50),
    PositionDescription varchar(50),
    ProbationLength varchar(50),
    MinSalary decimal (10,2),
    MaxSalary decimal (10,2),
	CONSTRAINT PK_ROLES PRIMARY KEY (RoleID)
);

CREATE TABLE dbo.EMPLOYEEADDRESS
(	EmpAddressID int IDENTITY(10000,2),  
	CountryID int NOT NULL,
	HomeType varchar(50),
	UnitNumber int,
	CONSTRAINT PK_EMPLOYEEADDRESS_EmpAddressID PRIMARY KEY (EmpAddressID),
	CONSTRAINT FK_EMPLOYEEADDRESS_CountryID FOREIGN KEY (CountryID) REFERENCES COUNTRIES (CountryID)
);

CREATE TABLE dbo.EMPLOYEE
(	EmployeeID int IDENTITY(1117,17),
	RoleID int NOT NULL,
	ManagerID int REFERENCES EMPLOYEE(EmployeeID),
	DepartmentID int NOT NULL,
	EmpAddressID int NOT NULL,
	FName varchar(25),
	LName varchar(25),
	Salary decimal(10,2),
	HireDate datetime,
	Probation varchar(25),
	PersonaleMail varchar (75),
	PersonalPhoneNumber int,
	CONSTRAINT PK_EMPLOYEE_EmployeeID PRIMARY KEY (EmployeeID),
	CONSTRAINT FK_EMPLOYEE_RoleID FOREIGN KEY (RoleID) REFERENCES ROLES(RoleID),
	--CONSTRAINT FK_EMPLOYEE_ManagerID FOREIGN KEY (ManagerID) REFERENCES EMPLOYEE (EmployeeID),
	CONSTRAINT FK_EMPLOYEE_DepartmentID FOREIGN KEY (DepartmentID) REFERENCES DEPARTMENTS (DepartmentID),
	CONSTRAINT FK_EMPLOYEE_EmpAddressID FOREIGN KEY (EmpAddressID) REFERENCES EMPLOYEEADDRESS (EmpAddressID)
);



CREATE TABLE dbo.DEPENDENTS 
(   DependentID int  NOT NULL,
    EmployeeID int NOT NULL,
    Relationships varchar(50),
    FName varchar(50),
    LName varchar(50),
    DateOfBirth datetime,
	CONSTRAINT PK_DEPENDENTS_DependentID PRIMARY KEY (DependentID),
    CONSTRAINT FK_DEPENDENTS_EmployeeID  FOREIGN KEY (EmployeeID) REFERENCES EMPLOYEE(EmployeeID)
);


CREATE TABLE dbo.EMPLOYEEPERSONAL
(   PersonalID int NOT NULL,
    EmployeeID int NOT NULL,
	DateOfBirth date,
	SocialSecurityNumber int,
	AllergyName varchar(50),
	AllergyDesc varchar(50),
	EpiPen varchar(50),
	DisabilityName varchar(50),
	DisabilityDesc varchar(50),
	Gender varchar(10),
	CONSTRAINT PK_EMPLOYEEPERSONAL_PersonalID PRIMARY KEY (PersonalID),
	CONSTRAINT FK_EMPLOYEEPERSONAL_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES EMPLOYEE(EmployeeID)
);

CREATE TABLE dbo.EMPLOYEECONTACT -- no graph
(   EmpContactID int NOT NULL,
    EmployeeID int NOT NULL,
	FacilityID int NOT NULL,
	WorkExtension varchar(50),
	OfficeNumber int,
	CONSTRAINT PK_EMPLOYEECONTACT_EmpContactID PRIMARY KEY (EmpContactID),
	CONSTRAINT FK_EMPLOYEECONTACT_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES EMPLOYEE(EmployeeID),
    CONSTRAINT FK_EMPLOYEECONTACT_FacilityID FOREIGN KEY(FacilityID)REFERENCES FACILITYADDRESS(FacilityID)
);

CREATE TABLE dbo.EMERGENCYCONTACTS
(   ContactID int  NOT NULL,
    EmployeeID int NOT NULL,
	FName varchar(50),
	LName varchar(50),
	ContactNumber int DEFAULT 911,
	ContactAltNumber int DEFAULT 911,
	CONSTRAINT PK_EMERGENCYCONTACTS_ContactID PRIMARY KEY (ContactID),
	CONSTRAINT FK_EMERGENCYCONTACTS_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES EMPLOYEE(EmployeeID)
);


--INSERTION----
--GO

INSERT INTO REGIONS (RegionID, RegionName) VALUES (101,'ONTARIO');
INSERT INTO REGIONS (RegionID, RegionName) VALUES (201,'NOVA SCOTIA');
INSERT INTO REGIONS (RegionID, RegionName) VALUES (301,'QUEBEC');
INSERT INTO REGIONS (RegionID, RegionName) VALUES (401,'MANITOBA');
INSERT INTO REGIONS (RegionID, RegionName) VALUES (501,'BRITISH COLOMBIA');

INSERT INTO COUNTRIES (CountryID, RegionID, CountryName) VALUES (111,101,'Canada');
INSERT INTO COUNTRIES (CountryID, RegionID, CountryName) VALUES (222,201,'Columbia');
INSERT INTO COUNTRIES (CountryID, RegionID, CountryName) VALUES (333,301,'Brazil');
INSERT INTO COUNTRIES (CountryID, RegionID, CountryName) VALUES (444,401,'Uganda');
INSERT INTO COUNTRIES (CountryID, RegionID, CountryName) VALUES (555,501,'Vietnam');
INSERT INTO COUNTRIES (CountryID, RegionID, CountryName) VALUES (666,601,'Indonesia');

INSERT INTO EMPLOYEEADDRESS (CountryID, HomeType, UnitNumber) VALUES (111,'House',112);
INSERT INTO EMPLOYEEADDRESS (CountryID, HomeType, UnitNumber) VALUES (222,'Condo',502);
INSERT INTO EMPLOYEEADDRESS (CountryID, HomeType, UnitNumber) VALUES (333,'Apartment',305);
INSERT INTO EMPLOYEEADDRESS (CountryID, HomeType, UnitNumber) VALUES (444,'House',222);
INSERT INTO EMPLOYEEADDRESS (CountryID, HomeType, UnitNumber) VALUES (555,'Apartment',321);


INSERT INTO FACILITYADDRESS  (CountryID, FacilityName) VALUES (111,'Hotel');
INSERT INTO FACILITYADDRESS  (CountryID, FacilityName) VALUES (222,'Hospital');
INSERT INTO FACILITYADDRESS  (CountryID, FacilityName) VALUES (333,'School');
INSERT INTO FACILITYADDRESS  (CountryID, FacilityName) VALUES (444,'Transportation');
INSERT INTO FACILITYADDRESS  (CountryID, FacilityName) VALUES (555,'Industries');

INSERT INTO ADDRESS (AddressID, FacilityID, StreetNumber, StreetName, StreetType, PostalCode, City, Province) VALUES (15,1, 376, 'Churchill', 'Court', 'N2L 6B4', 'WATERLOO', 'ONTARIO');
INSERT INTO ADDRESS (AddressID, FacilityID, StreetNumber, StreetName, StreetType, PostalCode, City, Province) VALUES (25,2, 100, 'Sasaga', 'Dr', 'N2C 2G7', 'KITCHENER', 'ONTARIO');
INSERT INTO ADDRESS (AddressID, FacilityID, StreetNumber, StreetName, StreetType, PostalCode, City, Province) VALUES (35,3, 16, 'Stevenson', 'St S', 'N1E 5N1', 'GUELPH', 'ONTARIO');
INSERT INTO ADDRESS (AddressID, FacilityID, StreetNumber, StreetName, StreetType, PostalCode, City, Province) VALUES (45,4, 25, 'Peel Centre', 'Dr', 'L6T 3R5', 'BRAMPTON', 'ONTARIO');
INSERT INTO ADDRESS (AddressID, FacilityID, StreetNumber, StreetName, StreetType, PostalCode, City, Province) VALUES (55,5, 220, 'Younge', 'St', 'M5B 2H1', 'TRONTO', 'ONTARIO');

INSERT INTO DEPARTMENTS (FacilityID, DepartmentName, DepartmentDesc) VALUES ('1', 'Sales', 'Managing Sales');
INSERT INTO DEPARTMENTS (FacilityID, DepartmentName, DepartmentDesc) VALUES ('2', 'Management', 'Managing Management');
INSERT INTO DEPARTMENTS (FacilityID, DepartmentName, DepartmentDesc) VALUES ('3', 'PR', 'Public Relation');
INSERT INTO DEPARTMENTS (FacilityID, DepartmentName, DepartmentDesc) VALUES ('4', 'HR', 'Human Resource');
INSERT INTO DEPARTMENTS (FacilityID, DepartmentName, DepartmentDesc) VALUES ('5', 'Marketing', 'Handle Marketing');



INSERT INTO ROLES (RoleID, PositionTitle, PositionDescription, ProbationLength, MinSalary, MaxSalary) VALUES (123,'Administrative Assistant', 'Assistant','3 months',40000,60000);
INSERT INTO ROLES (RoleID, PositionTitle, PositionDescription, ProbationLength, MinSalary, MaxSalary) VALUES (234,'Manager', 'employees','6 months',70000,90000);
INSERT INTO ROLES (RoleID, PositionTitle, PositionDescription, ProbationLength, MinSalary, MaxSalary) VALUES (345,'Software Developer', 'Develop and maintain','1 year',80000,120000);
INSERT INTO ROLES (RoleID, PositionTitle, PositionDescription, ProbationLength, MinSalary, MaxSalary) VALUES (456,'Sales Associate', 'Sell products and services to customers','5 months',30000,50000);
INSERT INTO ROLES (RoleID, PositionTitle, PositionDescription, ProbationLength, MinSalary, MaxSalary) VALUES (567,'Customer Service', 'Interact with customers','6 months',35000,55000);
 


INSERT INTO EMPLOYEE (RoleID, ManagerID, DepartmentID, EmpAddressID, FName, LName, Salary, HireDate, Probation, PersonaleMail, PersonalPhoneNumber) VALUES (123,NULL,10,'10000','John','Doe', 50000,'2021-01-01','3 months','john.doe@company.com',123456789);
INSERT INTO EMPLOYEE (RoleID, ManagerID, DepartmentID, EmpAddressID, FName, LName, Salary, HireDate, Probation, PersonaleMail, PersonalPhoneNumber) VALUES (234,NULL,20,'10002','Jane','Smith', 60000,'2021-02-03','4 months','jane.smith@company.com',234567890);
INSERT INTO EMPLOYEE (RoleID, ManagerID, DepartmentID, EmpAddressID, FName, LName, Salary, HireDate, Probation, PersonaleMail, PersonalPhoneNumber) VALUES (345,NULL,30,'10004','Bob','Johnson', 70000,'2022-03-11','3 months','bob.johnson@company.com',345678901);
INSERT INTO EMPLOYEE (RoleID, ManagerID, DepartmentID, EmpAddressID, FName, LName, Salary, HireDate, Probation, PersonaleMail, PersonalPhoneNumber) VALUES (456,NULL,40,'10006','Sara','Lee', 80000,'2020-05-01','3 months','sara.lee@company.com',456789012);
INSERT INTO EMPLOYEE (RoleID, ManagerID, DepartmentID, EmpAddressID, FName, LName, Salary, HireDate, Probation, PersonaleMail, PersonalPhoneNumber) VALUES (567,NULL,50,'10008','Tom','Wilson', 90000,'2022-10-22','3 months','tom.wilson@company.com',567890123);

INSERT INTO EMERGENCYCONTACTS ( ContactID, EmployeeID, FName, LName) VALUES(11111, 1117, 'Charles' , 'Dickens');
INSERT INTO EMERGENCYCONTACTS ( ContactID, EmployeeID, FName, LName) VALUES(11121, 1134, 'Jane ' , 'Austen');
INSERT INTO EMERGENCYCONTACTS ( ContactID, EmployeeID, FName, LName) VALUES(12111, 1151, 'George ' , 'Orwell');
INSERT INTO EMERGENCYCONTACTS ( ContactID, EmployeeID, FName, LName) VALUES(13411, 1168, 'Virginia ' , 'George');
INSERT INTO EMERGENCYCONTACTS ( ContactID, EmployeeID, FName, LName) VALUES(11115, 1185, 'Eliot' , 'Johnson');

INSERT INTO EMPLOYEECONTACT (EmpContactID, EmployeeID, FacilityID, WorkExtension, OfficeNumber) VALUES (251,1117,'1','1 month' ,2535);
INSERT INTO EMPLOYEECONTACT (EmpContactID, EmployeeID, FacilityID, WorkExtension, OfficeNumber) VALUES (351,1134,'2','3 months',4555);
INSERT INTO EMPLOYEECONTACT (EmpContactID, EmployeeID, FacilityID, WorkExtension, OfficeNumber) VALUES (451,1151,'3','5 months',6575);
INSERT INTO EMPLOYEECONTACT (EmpContactID, EmployeeID, FacilityID, WorkExtension, OfficeNumber) VALUES (551,1168,'4','6 months',8595);
INSERT INTO EMPLOYEECONTACT (EmpContactID, EmployeeID, FacilityID, WorkExtension, OfficeNumber) VALUES (651,1185,'5','7 months',9505);
	
INSERT INTO EMPLOYEEPERSONAL (PersonalID, EmployeeID, DateOfBirth, SocialSecurityNumber, AllergyName, AllergyDesc, EpiPen, DisabilityName, DisabilityDesc, Gender) VALUES (001,1117,'1991-07-12',987654,'Peanuts','Allergic to peanuts','YES',NULL,NULL,'Female');
INSERT INTO EMPLOYEEPERSONAL (PersonalID, EmployeeID, DateOfBirth, SocialSecurityNumber, AllergyName, AllergyDesc, EpiPen, DisabilityName, DisabilityDesc, Gender) VALUES (002,1134,'1975-03-22',654321,'Latex','Allergic to Latex','NO',NULL,NULL,'Male');
INSERT INTO EMPLOYEEPERSONAL (PersonalID, EmployeeID, DateOfBirth, SocialSecurityNumber, AllergyName, AllergyDesc, EpiPen, DisabilityName, DisabilityDesc, Gender) VALUES (003,1151,'1990-02-17',753698, NULL,NULL,NULL,'Dyslexia','Difficulty with reading and writing','Female');
INSERT INTO EMPLOYEEPERSONAL (PersonalID, EmployeeID, DateOfBirth, SocialSecurityNumber, AllergyName, AllergyDesc, EpiPen, DisabilityName, DisabilityDesc, Gender) VALUES (004,1168,'1999-12-10',475869,'Shellfish','Allergic to shellfish','YES',NULL,NULL,'Male');
INSERT INTO EMPLOYEEPERSONAL (PersonalID, EmployeeID, DateOfBirth, SocialSecurityNumber, AllergyName, AllergyDesc, EpiPen, DisabilityName, DisabilityDesc, Gender) VALUES (005,1185,'1980-06-25',243568, NULL,NULL,NULL,NULL,NULL,'Female');

	
INSERT INTO DEPENDENTS (DependentID, EmployeeID, Relationships, FName, LName, DateOfBirth) VALUES (199,1117,'Manager','John','Doe','2001-01-15');
INSERT INTO DEPENDENTS (DependentID, EmployeeID, Relationships, FName, LName, DateOfBirth) VALUES (299,1134,'Leader','Jane','Smith','2015-02-14');
INSERT INTO DEPENDENTS (DependentID, EmployeeID, Relationships, FName, LName, DateOfBirth) VALUES (399,1151,'Junior','Bob','Johnson','2021-05-06');
INSERT INTO DEPENDENTS (DependentID, EmployeeID, Relationships, FName, LName, DateOfBirth) VALUES (499,1168,'Director','Sara','Lee','2016-10-22');
INSERT INTO DEPENDENTS (DependentID, EmployeeID, Relationships, FName, LName, DateOfBirth) VALUES (599,1185,'Manager','Tom','Wilson','2001-01-14');



-----------------------------Section A -----------------------------------------------

--1) "Employeepersonal" table issue addressed--

--CREATE "ALLERGY" TABLE ----

CREATE TABLE dbo.ALLERGY
(

    AllergyID int IDENTITY(1,1) ,
    EmployeeID int NOT NULL,
    AllergyName varchar(50),
    AllergyDesc varchar(150),
    CONSTRAINT FK_ALLERGY_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES EMPLOYEE(EmployeeID)
);


--MIGRATE VALUES TO "ALLERGY" FROM "EMPLOYEEPERSONAL"-----
INSERT INTO ALLERGY (EmployeeID, AllergyName, AllergyDesc)
SELECT EmployeeID, AllergyName, AllergyDesc FROM EMPLOYEEPERSONAL
WHERE AllergyName IS NOT NULL;


--DELETE COLUMN IN "EMPLOYEEPERSONAL"--
ALTER TABLE EMPLOYEEPERSONAL DROP COLUMN AllergyName;
ALTER TABLE EMPLOYEEPERSONAL DROP COLUMN AllergyDesc;


--INSERT NEW ALLERGIES TO "ALLERGY" TABLE--
INSERT INTO ALLERGY (EmployeeID, AllergyName, AllergyDesc) VALUES (1117, 'Mustard', 'Allergic to mustard');
INSERT INTO ALLERGY (EmployeeID, AllergyName, AllergyDesc) VALUES (1168, 'Gluten', 'Allergic to gluten');
INSERT INTO ALLERGY (EmployeeID, AllergyName, AllergyDesc) VALUES (1185, 'Soybeans','Allergic to Soybeans');



--2) Expanding database usability - INTERSECTION TABLE
-- EMPLOYEEADDRESS----

CREATE TABLE dbo.MULTIPLE_ADDRESS (
    EmployeeID int NOT NULL,
    EmpAddressID int NOT NULL, 
    CONSTRAINT PK_MULTIPLE_ADDRESS PRIMARY KEY (EmployeeID, EmpAddressID),
    CONSTRAINT FK_MULTIPLE_ADDRESS_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES EMPLOYEE (EmployeeID),
    CONSTRAINT FK_MULTIPLE_ADDRESS_EmpAddressID FOREIGN KEY (EmpAddressID) REFERENCES EMPLOYEEADDRESS (EmpAddressID),
	
);


INSERT INTO MULTIPLE_ADDRESS (EmployeeID,EmpAddressID) VALUES (1134,10002);
INSERT INTO MULTIPLE_ADDRESS (EmployeeID,EmpAddressID) VALUES (1134,10004);
INSERT INTO MULTIPLE_ADDRESS (EmployeeID,EmpAddressID) VALUES (1185,10008);
INSERT INTO MULTIPLE_ADDRESS (EmployeeID,EmpAddressID) VALUES (1185,10006);


------3)Database stability concerns

ALTER TABLE EMPLOYEEADDRESS ADD FacilityID int
ALTER TABLE EMPLOYEEADDRESS ADD CONSTRAINT FK_ADDRESS FOREIGN KEY (FacilityID) REFERENCES FACILITYADDRESS (FacilityID)


UPDATE dbo.EMPLOYEEADDRESS
SET FacilityID = fa.FacilityID
FROM dbo.EMPLOYEEADDRESS ea
JOIN dbo.FACILITYADDRESS fa ON ea.CountryID = fa.CountryID
WHERE ea.FacilityID IS NULL;
