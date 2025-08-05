-- UAE Employee Database Setup Script
-- This script creates the complete database structure

-- Step 1: Create the database
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

-- Step 2: Use the database
USE UAE_EmployeeDB
GO

-- Step 3: Create Tables
-- Create Departments table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Departments]') AND type in (N'U'))
BEGIN
    CREATE TABLE Departments (
        DepartmentID INT IDENTITY(1,1) PRIMARY KEY,
        DepartmentName NVARCHAR(100) NOT NULL,
        DepartmentCode NVARCHAR(20),
        Description NVARCHAR(500),
        IsActive BIT DEFAULT 1,
        CreatedDate DATETIME DEFAULT GETDATE(),
        ModifiedDate DATETIME DEFAULT GETDATE()
    )
    PRINT 'Departments table created successfully.'
END
ELSE
BEGIN
    PRINT 'Departments table already exists.'
END
GO

-- Create Positions table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Positions]') AND type in (N'U'))
BEGIN
    CREATE TABLE Positions (
        PositionID INT IDENTITY(1,1) PRIMARY KEY,
        PositionTitle NVARCHAR(100) NOT NULL,
        PositionCode NVARCHAR(20),
        Description NVARCHAR(500),
        IsActive BIT DEFAULT 1,
        CreatedDate DATETIME DEFAULT GETDATE(),
        ModifiedDate DATETIME DEFAULT GETDATE()
    )
    PRINT 'Positions table created successfully.'
END
ELSE
BEGIN
    PRINT 'Positions table already exists.'
END
GO

-- Create Users table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND type in (N'U'))
BEGIN
    CREATE TABLE Users (
        UserID INT IDENTITY(1,1) PRIMARY KEY,
        Username NVARCHAR(50) NOT NULL UNIQUE,
        PasswordHash NVARCHAR(255) NOT NULL,
        Email NVARCHAR(100),
        IsActive BIT DEFAULT 1,
        CreatedDate DATETIME DEFAULT GETDATE(),
        ModifiedDate DATETIME DEFAULT GETDATE()
    )
    PRINT 'Users table created successfully.'
END
ELSE
BEGIN
    PRINT 'Users table already exists.'
END
GO

-- Create Employees table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Employees]') AND type in (N'U'))
BEGIN
    CREATE TABLE Employees (
        EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
        EmiratesID NVARCHAR(20) UNIQUE,
        PassportNumber NVARCHAR(20),
        FirstName NVARCHAR(50) NOT NULL,
        LastName NVARCHAR(50) NOT NULL,
        Nationality NVARCHAR(50),
        DateOfBirth DATE,
        Gender NVARCHAR(10),
        WorkEmail NVARCHAR(100),
        PersonalEmail NVARCHAR(100),
        WorkPhone NVARCHAR(20),
        PersonalPhone NVARCHAR(20),
        Emirates NVARCHAR(50),
        City NVARCHAR(50),
        District NVARCHAR(50),
        HireDate DATE,
        ContractType NVARCHAR(50),
        EmploymentStatus NVARCHAR(20),
        DepartmentID INT,
        PositionID INT,
        ManagerID INT,
        SalaryGrade NVARCHAR(20),
        IsActive BIT DEFAULT 1,
        CreatedBy INT,
        CreatedDate DATETIME DEFAULT GETDATE(),
        ModifiedBy INT,
        ModifiedDate DATETIME DEFAULT GETDATE(),
        FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID),
        FOREIGN KEY (PositionID) REFERENCES Positions(PositionID),
        FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID),
        FOREIGN KEY (CreatedBy) REFERENCES Users(UserID),
        FOREIGN KEY (ModifiedBy) REFERENCES Users(UserID)
    )
    PRINT 'Employees table created successfully.'
END
ELSE
BEGIN
    PRINT 'Employees table already exists.'
END
GO

-- Step 4: Insert Sample Data
-- Insert sample departments
IF NOT EXISTS (SELECT * FROM Departments WHERE DepartmentName = 'Information Technology')
BEGIN
    INSERT INTO Departments (DepartmentName, DepartmentCode, Description) VALUES
    ('Information Technology', 'IT', 'IT Department for UAE Government'),
    ('Human Resources', 'HR', 'Human Resources Department'),
    ('Finance', 'FIN', 'Finance and Accounting Department'),
    ('Operations', 'OPS', 'Operations Department'),
    ('Marketing', 'MKT', 'Marketing and Communications Department')
    PRINT 'Sample departments inserted successfully.'
END
ELSE
BEGIN
    PRINT 'Sample departments already exist.'
END
GO

-- Insert sample positions
IF NOT EXISTS (SELECT * FROM Positions WHERE PositionTitle = 'Software Developer')
BEGIN
    INSERT INTO Positions (PositionTitle, PositionCode, Description) VALUES
    ('Software Developer', 'SD001', 'Software Development Position'),
    ('Senior Developer', 'SD002', 'Senior Software Development Position'),
    ('Project Manager', 'PM001', 'Project Management Position'),
    ('HR Manager', 'HR001', 'Human Resources Management Position'),
    ('Finance Analyst', 'FA001', 'Financial Analysis Position'),
    ('Operations Manager', 'OM001', 'Operations Management Position'),
    ('Marketing Specialist', 'MS001', 'Marketing and Communications Position')
    PRINT 'Sample positions inserted successfully.'
END
ELSE
BEGIN
    PRINT 'Sample positions already exist.'
END
GO

-- Insert sample users
IF NOT EXISTS (SELECT * FROM Users WHERE Username = 'admin')
BEGIN
    INSERT INTO Users (Username, PasswordHash, Email) VALUES
    ('admin', 'admin123', 'admin@uae.gov.ae'),
    ('user1', 'user123', 'user1@uae.gov.ae'),
    ('user2', 'user123', 'user2@uae.gov.ae')
    PRINT 'Sample users inserted successfully.'
END
ELSE
BEGIN
    PRINT 'Sample users already exist.'
END
GO

-- Insert sample employees
IF NOT EXISTS (SELECT * FROM Employees WHERE FirstName = 'Ahmed')
BEGIN
    INSERT INTO Employees (
        EmiratesID, PassportNumber, FirstName, LastName, Nationality,
        DateOfBirth, Gender, WorkEmail, PersonalEmail, WorkPhone,
        PersonalPhone, Emirates, City, District, HireDate,
        ContractType, EmploymentStatus, DepartmentID, PositionID,
        ManagerID, SalaryGrade, CreatedBy
    ) VALUES
    ('784-1985-1234567-8', 'A12345678', 'Ahmed', 'Al Mansouri', 'UAE',
        '1985-03-15', 'Male', 'ahmed.al.mansouri@uae.gov.ae', 'ahmed@gmail.com',
        '+971-50-123-4567', '+971-50-123-4568', 'Dubai', 'Dubai', 'Downtown',
        '2020-01-15', 'Permanent', 'Active', 1, 1, NULL, 'G5', 1),
    ('784-1990-2345678-9', 'B23456789', 'Fatima', 'Al Zahra', 'UAE',
        '1990-07-22', 'Female', 'fatima.al.zahra@uae.gov.ae', 'fatima@gmail.com',
        '+971-50-234-5678', '+971-50-234-5679', 'Abu Dhabi', 'Abu Dhabi', 'Al Reem',
        '2021-03-10', 'Contract', 'Active', 2, 4, 1, 'G4', 1),
    ('784-1988-3456789-0', 'C34567890', 'Mohammed', 'Al Rashid', 'UAE',
        '1988-11-08', 'Male', 'mohammed.al.rashid@uae.gov.ae', 'mohammed@gmail.com',
        '+971-50-345-6789', '+971-50-345-6790', 'Sharjah', 'Sharjah', 'Al Majaz',
        '2019-08-20', 'Permanent', 'Active', 3, 5, 1, 'G6', 1)
    PRINT 'Sample employees inserted successfully.'
END
ELSE
BEGIN
    PRINT 'Sample employees already exist.'
END
GO

-- Step 5: Create Stored Procedures
-- Department stored procedures
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Department_GetAll]') AND type in (N'P', N'PC'))
BEGIN
    EXEC('CREATE PROCEDURE sp_Department_GetAll AS BEGIN SELECT 1 END')
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Department_GetAll]') AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE sp_Department_GetAll
END
GO

CREATE PROCEDURE sp_Department_GetAll
AS
BEGIN
    SELECT DepartmentID, DepartmentName, DepartmentCode, Description, IsActive
    FROM Departments
    WHERE IsActive = 1
    ORDER BY DepartmentName
END
GO

-- Position stored procedures
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Position_GetAll]') AND type in (N'P', N'PC'))
BEGIN
    EXEC('CREATE PROCEDURE sp_Position_GetAll AS BEGIN SELECT 1 END')
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Position_GetAll]') AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE sp_Position_GetAll
END
GO

CREATE PROCEDURE sp_Position_GetAll
AS
BEGIN
    SELECT PositionID, PositionTitle, PositionCode, Description, IsActive
    FROM Positions
    WHERE IsActive = 1
    ORDER BY PositionTitle
END
GO

-- Employee stored procedures
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Employee_GetAll]') AND type in (N'P', N'PC'))
BEGIN
    EXEC('CREATE PROCEDURE sp_Employee_GetAll AS BEGIN SELECT 1 END')
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Employee_GetAll]') AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE sp_Employee_GetAll
END
GO

CREATE PROCEDURE sp_Employee_GetAll
AS
BEGIN
    SELECT e.*, d.DepartmentName, p.PositionTitle, m.FirstName + ' ' + m.LastName as ManagerName
    FROM Employees e
    LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID
    LEFT JOIN Positions p ON e.PositionID = p.PositionID
    LEFT JOIN Employees m ON e.ManagerID = m.EmployeeID
    WHERE e.IsActive = 1
    ORDER BY e.EmployeeID DESC
END
GO

PRINT 'Database setup completed successfully!'
PRINT 'You can now run the application.'
GO 