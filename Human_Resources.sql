CREATE LOGIN HumanResources
WITH PASSWORD = 'hr_123'

CREATE USER HumanResourceManager FOR LOGIN HumanResources;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, EXECUTE
ON SCHEMA:: GENERAL_INFORMATION TO HumanResourceManager;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, EXECUTE
ON SCHEMA:: PERSONAL_DATA TO HumanResourceManager;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, EXECUTE
ON SCHEMA:: CONTACT_INFORMATION TO HumanResourceManager;
