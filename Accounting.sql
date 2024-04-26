CREATE LOGIN Accounting
WITH PASSWORD = 'accounting_123'

CREATE USER AccountManager FOR LOGIN Accounting;

GRANT SELECT ON SCHEMA:: GENERAL_INFORMATION TO AccountManager;    --Only Giving pull/read access

GRANT SELECT ON SCHEMA:: ADDRESS_SCHEMA TO AccountManager;