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
-- Create Users table (for authentication)
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND type in (N'U'))
BEGIN
    CREATE TABLE Users (
        UserID INT IDENTITY(1,1) PRIMARY KEY,
        Username NVARCHAR(50) UNIQUE NOT NULL,
        PasswordHash NVARCHAR(255) NOT NULL,
        Email NVARCHAR(100),
        RoleID INT,
        IsActive BIT DEFAULT 1,
        LastLoginDate DATETIME,
        CreatedDate DATETIME DEFAULT GETDATE()
    )
    PRINT 'Table Users created successfully.'
END
ELSE
BEGIN
    PRINT 'Table Users already exists.'
END
GO

-- Create Roles table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Roles]') AND type in (N'U'))
BEGIN
    CREATE TABLE Roles (
        RoleID INT IDENTITY(1,1) PRIMARY KEY,
        RoleName NVARCHAR(50) NOT NULL,
        Description NVARCHAR(255)
    )
    PRINT 'Table Roles created successfully.'
END
ELSE
BEGIN
    PRINT 'Table Roles already exists.'
END
GO

-- Create Departments table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Departments]') AND type in (N'U'))
BEGIN
    CREATE TABLE Departments (
        DepartmentID INT IDENTITY(1,1) PRIMARY KEY,
        DepartmentName NVARCHAR(100) NOT NULL,
        DepartmentCode NVARCHAR(20) UNIQUE,
        Description NVARCHAR(255),
        IsActive BIT DEFAULT 1
    )
    PRINT 'Table Departments created successfully.'
END
ELSE
BEGIN
    PRINT 'Table Departments already exists.'
END
GO

-- Create Positions table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Positions]') AND type in (N'U'))
BEGIN
    CREATE TABLE Positions (
        PositionID INT IDENTITY(1,1) PRIMARY KEY,
        PositionTitle NVARCHAR(100) NOT NULL,
        PositionCode NVARCHAR(20) UNIQUE,
        Description NVARCHAR(255),
        IsActive BIT DEFAULT 1
    )
    PRINT 'Table Positions created successfully.'
END
ELSE
BEGIN
    PRINT 'Table Positions already exists.'
END
GO

-- Create Employees table (main table)
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Employees]') AND type in (N'U'))
BEGIN
    CREATE TABLE Employees (
        EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
        EmiratesID NVARCHAR(20) UNIQUE NOT NULL,
        PassportNumber NVARCHAR(20),
        FirstName NVARCHAR(50) NOT NULL,
        LastName NVARCHAR(50) NOT NULL,
        FullName AS (FirstName + ' ' + LastName),
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
        EmploymentStatus NVARCHAR(20) DEFAULT 'Active',
        DepartmentID INT,
        PositionID INT,
        ManagerID INT,
        SalaryGrade NVARCHAR(20),
        CreatedDate DATETIME DEFAULT GETDATE(),
        ModifiedDate DATETIME,
        CreatedBy INT,
        ModifiedBy INT,
        FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID),
        FOREIGN KEY (PositionID) REFERENCES Positions(PositionID),
        FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID),
        FOREIGN KEY (CreatedBy) REFERENCES Users(UserID),
        FOREIGN KEY (ModifiedBy) REFERENCES Users(UserID)
    )
    PRINT 'Table Employees created successfully.'
END
ELSE
BEGIN
    PRINT 'Table Employees already exists.'
END
GO

-- Create Audit Logs table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AuditLogs]') AND type in (N'U'))
BEGIN
    CREATE TABLE AuditLogs (
        LogID INT IDENTITY(1,1) PRIMARY KEY,
        TableName NVARCHAR(50) NOT NULL,
        RecordID INT NOT NULL,
        Action NVARCHAR(20) NOT NULL, -- INSERT, UPDATE, DELETE
        OldValues NVARCHAR(MAX),
        NewValues NVARCHAR(MAX),
        UserID INT,
        Timestamp DATETIME DEFAULT GETDATE(),
        FOREIGN KEY (UserID) REFERENCES Users(UserID)
    )
    PRINT 'Table AuditLogs created successfully.'
END
ELSE
BEGIN
    PRINT 'Table AuditLogs already exists.'
END
GO

-- Step 4: Insert Sample Data
-- Insert sample roles (only if not exists)
IF NOT EXISTS (SELECT * FROM Roles WHERE RoleName = 'Admin')
BEGIN
    INSERT INTO Roles (RoleName, Description) VALUES 
    ('Admin', 'System Administrator'),
    ('Manager', 'Department Manager'),
    ('User', 'Regular User')
    PRINT 'Sample roles inserted successfully.'
END
ELSE
BEGIN
    PRINT 'Sample roles already exist.'
END
GO

-- Insert sample departments (only if not exists)
IF NOT EXISTS (SELECT * FROM Departments WHERE DepartmentCode = 'IT')
BEGIN
    INSERT INTO Departments (DepartmentName, DepartmentCode, Description) VALUES 
    ('Information Technology', 'IT', 'IT Department'),
    ('Human Resources', 'HR', 'HR Department'),
    ('Finance', 'FIN', 'Finance Department'),
    ('Operations', 'OPS', 'Operations Department'),
    ('Legal Affairs', 'LEGAL', 'Legal Affairs Department'),
    ('Public Relations', 'PR', 'Public Relations Department')
    PRINT 'Sample departments inserted successfully.'
END
ELSE
BEGIN
    PRINT 'Sample departments already exist.'
END
GO

-- Insert sample positions (only if not exists)
IF NOT EXISTS (SELECT * FROM Positions WHERE PositionCode = 'DEV')
BEGIN
    INSERT INTO Positions (PositionTitle, PositionCode, Description) VALUES 
    ('Software Developer', 'DEV', 'Software Development'),
    ('System Analyst', 'ANALYST', 'System Analysis'),
    ('Manager', 'MGR', 'Department Manager'),
    ('Senior Developer', 'SENIOR_DEV', 'Senior Software Developer'),
    ('HR Specialist', 'HR_SPEC', 'Human Resources Specialist'),
    ('Finance Officer', 'FIN_OFF', 'Finance Officer'),
    ('Legal Advisor', 'LEGAL_ADV', 'Legal Advisor'),
    ('Public Relations Officer', 'PR_OFF', 'Public Relations Officer')
    PRINT 'Sample positions inserted successfully.'
END
ELSE
BEGIN
    PRINT 'Sample positions already exist.'
END
GO

-- Insert sample user (only if not exists)
IF NOT EXISTS (SELECT * FROM Users WHERE Username = 'admin')
BEGIN
    INSERT INTO Users (Username, PasswordHash, Email, RoleID) VALUES 
    ('admin', 'hashed_password_here', 'admin@uae.gov.ae', 1)
    PRINT 'Sample admin user created successfully.'
END
ELSE
BEGIN
    PRINT 'Sample admin user already exists.'
END
GO

-- Step 5: Create Stored Procedures
-- User authentication stored procedures
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_User_Authenticate]') AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE sp_User_Authenticate
END
GO

CREATE PROCEDURE sp_User_Authenticate
    @Username NVARCHAR(50),
    @Password NVARCHAR(255)
AS
BEGIN
    SELECT u.*, r.RoleName
    FROM Users u
    LEFT JOIN Roles r ON u.RoleID = r.RoleID
    WHERE u.Username = @Username 
    AND u.PasswordHash = @Password 
    AND u.IsActive = 1
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_User_GetById]') AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE sp_User_GetById
END
GO

CREATE PROCEDURE sp_User_GetById
    @UserID INT
AS
BEGIN
    SELECT u.*, r.RoleName
    FROM Users u
    LEFT JOIN Roles r ON u.RoleID = r.RoleID
    WHERE u.UserID = @UserID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_User_Insert]') AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE sp_User_Insert
END
GO

CREATE PROCEDURE sp_User_Insert
    @Username NVARCHAR(50),
    @PasswordHash NVARCHAR(255),
    @Email NVARCHAR(100),
    @RoleID INT,
    @IsActive BIT
AS
BEGIN
    -- Check if username already exists
    IF EXISTS (SELECT 1 FROM Users WHERE Username = @Username)
    BEGIN
        RAISERROR('Username already exists', 16, 1)
        RETURN
    END
    
    -- Check if email already exists (if email is provided)
    IF @Email IS NOT NULL AND EXISTS (SELECT 1 FROM Users WHERE Email = @Email)
    BEGIN
        RAISERROR('Email address already exists', 16, 1)
        RETURN
    END
    
    INSERT INTO Users (Username, PasswordHash, Email, RoleID, IsActive)
    VALUES (@Username, @PasswordHash, @Email, @RoleID, @IsActive)
    
    SELECT SCOPE_IDENTITY() as UserID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_User_Update]') AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE sp_User_Update
END
GO

CREATE PROCEDURE sp_User_Update
    @UserID INT,
    @Username NVARCHAR(50),
    @PasswordHash NVARCHAR(255),
    @Email NVARCHAR(100),
    @RoleID INT,
    @IsActive BIT
AS
BEGIN
    -- Check if username already exists for other users
    IF EXISTS (SELECT 1 FROM Users WHERE Username = @Username AND UserID != @UserID)
    BEGIN
        RAISERROR('Username already exists', 16, 1)
        RETURN
    END
    
    -- Check if email already exists for other users (if email is provided)
    IF @Email IS NOT NULL AND EXISTS (SELECT 1 FROM Users WHERE Email = @Email AND UserID != @UserID)
    BEGIN
        RAISERROR('Email address already exists', 16, 1)
        RETURN
    END
    
    UPDATE Users SET
        Username = @Username,
        PasswordHash = @PasswordHash,
        Email = @Email,
        RoleID = @RoleID,
        IsActive = @IsActive
    WHERE UserID = @UserID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_User_UpdateLastLogin]') AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE sp_User_UpdateLastLogin
END
GO

CREATE PROCEDURE sp_User_UpdateLastLogin
    @UserID INT
AS
BEGIN
    UPDATE Users SET LastLoginDate = GETDATE()
    WHERE UserID = @UserID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Role_GetAll]') AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE sp_Role_GetAll
END
GO

CREATE PROCEDURE sp_Role_GetAll
AS
BEGIN
    SELECT * FROM Roles ORDER BY RoleName
END
GO

-- Employee stored procedures
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
    ORDER BY e.EmployeeID DESC
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Employee_GetById]') AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE sp_Employee_GetById
END
GO

CREATE PROCEDURE sp_Employee_GetById
    @EmployeeID INT
AS
BEGIN
    SELECT e.*, d.DepartmentName, p.PositionTitle, m.FirstName + ' ' + m.LastName as ManagerName
    FROM Employees e
    LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID
    LEFT JOIN Positions p ON e.PositionID = p.PositionID
    LEFT JOIN Employees m ON e.ManagerID = m.EmployeeID
    WHERE e.EmployeeID = @EmployeeID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Employee_Insert]') AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE sp_Employee_Insert
END
GO

CREATE PROCEDURE sp_Employee_Insert
    @EmiratesID NVARCHAR(20),
    @PassportNumber NVARCHAR(20),
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Nationality NVARCHAR(50),
    @DateOfBirth DATE,
    @Gender NVARCHAR(10),
    @WorkEmail NVARCHAR(100),
    @PersonalEmail NVARCHAR(100),
    @WorkPhone NVARCHAR(20),
    @PersonalPhone NVARCHAR(20),
    @Emirates NVARCHAR(50),
    @City NVARCHAR(50),
    @District NVARCHAR(50),
    @HireDate DATE,
    @ContractType NVARCHAR(50),
    @EmploymentStatus NVARCHAR(20),
    @DepartmentID INT,
    @PositionID INT,
    @ManagerID INT,
    @SalaryGrade NVARCHAR(20),
    @CreatedBy INT
AS
BEGIN
    INSERT INTO Employees (
        EmiratesID, PassportNumber, FirstName, LastName, Nationality,
        DateOfBirth, Gender, WorkEmail, PersonalEmail, WorkPhone,
        PersonalPhone, Emirates, City, District, HireDate,
        ContractType, EmploymentStatus, DepartmentID, PositionID,
        ManagerID, SalaryGrade, CreatedBy
    )
    VALUES (
        @EmiratesID, @PassportNumber, @FirstName, @LastName, @Nationality,
        @DateOfBirth, @Gender, @WorkEmail, @PersonalEmail, @WorkPhone,
        @PersonalPhone, @Emirates, @City, @District, @HireDate,
        @ContractType, @EmploymentStatus, @DepartmentID, @PositionID,
        @ManagerID, @SalaryGrade, @CreatedBy
    )
    
    SELECT SCOPE_IDENTITY() as EmployeeID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Employee_Update]') AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE sp_Employee_Update
END
GO

CREATE PROCEDURE sp_Employee_Update
    @EmployeeID INT,
    @EmiratesID NVARCHAR(20),
    @PassportNumber NVARCHAR(20),
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Nationality NVARCHAR(50),
    @DateOfBirth DATE,
    @Gender NVARCHAR(10),
    @WorkEmail NVARCHAR(100),
    @PersonalEmail NVARCHAR(100),
    @WorkPhone NVARCHAR(20),
    @PersonalPhone NVARCHAR(20),
    @Emirates NVARCHAR(50),
    @City NVARCHAR(50),
    @District NVARCHAR(50),
    @HireDate DATE,
    @ContractType NVARCHAR(50),
    @EmploymentStatus NVARCHAR(20),
    @DepartmentID INT,
    @PositionID INT,
    @ManagerID INT,
    @SalaryGrade NVARCHAR(20),
    @ModifiedBy INT
AS
BEGIN
    UPDATE Employees SET
        EmiratesID = @EmiratesID,
        PassportNumber = @PassportNumber,
        FirstName = @FirstName,
        LastName = @LastName,
        Nationality = @Nationality,
        DateOfBirth = @DateOfBirth,
        Gender = @Gender,
        WorkEmail = @WorkEmail,
        PersonalEmail = @PersonalEmail,
        WorkPhone = @WorkPhone,
        PersonalPhone = @PersonalPhone,
        Emirates = @Emirates,
        City = @City,
        District = @District,
        HireDate = @HireDate,
        ContractType = @ContractType,
        EmploymentStatus = @EmploymentStatus,
        DepartmentID = @DepartmentID,
        PositionID = @PositionID,
        ManagerID = @ManagerID,
        SalaryGrade = @SalaryGrade,
        ModifiedDate = GETDATE(),
        ModifiedBy = @ModifiedBy
    WHERE EmployeeID = @EmployeeID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Employee_Delete]') AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE sp_Employee_Delete
END
GO

CREATE PROCEDURE sp_Employee_Delete
    @EmployeeID INT
AS
BEGIN
    DELETE FROM Employees WHERE EmployeeID = @EmployeeID
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Employee_Search]') AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE sp_Employee_Search
END
GO

CREATE PROCEDURE sp_Employee_Search
    @SearchTerm NVARCHAR(100) = NULL,
    @DepartmentID INT = NULL,
    @EmploymentStatus NVARCHAR(20) = NULL
AS
BEGIN
    SELECT e.*, d.DepartmentName, p.PositionTitle, m.FirstName + ' ' + m.LastName as ManagerName
    FROM Employees e
    LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID
    LEFT JOIN Positions p ON e.PositionID = p.PositionID
    LEFT JOIN Employees m ON e.ManagerID = m.EmployeeID
    WHERE (@SearchTerm IS NULL OR 
           e.FirstName LIKE '%' + @SearchTerm + '%' OR 
           e.LastName LIKE '%' + @SearchTerm + '%' OR 
           e.EmiratesID LIKE '%' + @SearchTerm + '%' OR
           e.FullName LIKE '%' + @SearchTerm + '%')
    AND (@DepartmentID IS NULL OR e.DepartmentID = @DepartmentID)
    AND (@EmploymentStatus IS NULL OR e.EmploymentStatus = @EmploymentStatus)
    ORDER BY e.EmployeeID DESC
END
GO

-- Department stored procedures
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Department_GetAll]') AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE sp_Department_GetAll
END
GO

CREATE PROCEDURE sp_Department_GetAll
AS
BEGIN
    SELECT * FROM Departments WHERE IsActive = 1 ORDER BY DepartmentName
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Department_GetById]') AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE sp_Department_GetById
END
GO

CREATE PROCEDURE sp_Department_GetById
    @DepartmentID INT
AS
BEGIN
    SELECT * FROM Departments WHERE DepartmentID = @DepartmentID
END
GO

-- Position stored procedures
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Position_GetAll]') AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE sp_Position_GetAll
END
GO

CREATE PROCEDURE sp_Position_GetAll
AS
BEGIN
    SELECT * FROM Positions WHERE IsActive = 1 ORDER BY PositionTitle
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Position_GetById]') AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE sp_Position_GetById
END
GO

CREATE PROCEDURE sp_Position_GetById
    @PositionID INT
AS
BEGIN
    SELECT * FROM Positions WHERE PositionID = @PositionID
END
GO

-- Audit log stored procedure
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_AuditLog_Insert]') AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE sp_AuditLog_Insert
END
GO

CREATE PROCEDURE sp_AuditLog_Insert
    @TableName NVARCHAR(50),
    @RecordID INT,
    @Action NVARCHAR(20),
    @OldValues NVARCHAR(MAX),
    @NewValues NVARCHAR(MAX),
    @UserID INT
AS
BEGIN
    INSERT INTO AuditLogs (TableName, RecordID, Action, OldValues, NewValues, UserID)
    VALUES (@TableName, @RecordID, @Action, @OldValues, @NewValues, @UserID)
END
GO

PRINT 'Database setup completed successfully!'
PRINT 'You can now run the application.'
GO 