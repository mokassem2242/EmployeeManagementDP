-- Check if tables exist and create them if they don't

-- Users table (for authentication)
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

-- Roles table
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

-- Departments table
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

-- Positions table
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

-- Employees table (main table)
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

-- Audit Logs table
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