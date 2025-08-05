-- Check if database exists and create it if it doesn't
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'UAE_EmployeeDB')
BEGIN
    CREATE DATABASE UAE_EmployeeDB
    PRINT 'Database UAE_EmployeeDB created successfully.'
END
ELSE
BEGIN
    PRINT 'Database UAE_EmployeeDB already exists.'
END
GO

USE UAE_EmployeeDB
GO 