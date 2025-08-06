-- Create Tables for UAE Employee Database
USE UAE_EmployeeDB
GO

-- Create Roles table first (needed for foreign key)
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

-- Create Users table (for authentication) with proper foreign key
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND type in (N'U'))
BEGIN
    CREATE TABLE Users (
        UserID INT IDENTITY(1,1) PRIMARY KEY,
        Username NVARCHAR(50) UNIQUE NOT NULL,
        PasswordHash NVARCHAR(255) NOT NULL,
        Email NVARCHAR(100),
        RoleID INT NOT NULL,
        IsActive BIT DEFAULT 1,
        LastLoginDate DATETIME,
        CreatedDate DATETIME DEFAULT GETDATE(),
        FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
    )
    PRINT 'Table Users created successfully.'
END
ELSE
BEGIN
    PRINT 'Table Users already exists.'
    -- Add foreign key if it doesn't exist
    IF NOT EXISTS (
        SELECT 1 FROM sys.foreign_keys 
        WHERE parent_object_id = OBJECT_ID('Users') 
          AND referenced_object_id = OBJECT_ID('Roles')
    )
    BEGIN
        -- Add RoleID column if it doesn't exist
        IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Users') AND name = 'RoleID')
        BEGIN
            ALTER TABLE Users ADD RoleID INT
        END
        
        -- Add foreign key constraint
        ALTER TABLE Users
        ADD CONSTRAINT FK_Users_Roles
        FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
        PRINT 'Foreign key constraint added to Users table.'
    END
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

-- Create Employees table (main table) with optional UserID foreign key
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
        UserID INT NULL, -- Optional foreign key to Users table
        CreatedDate DATETIME DEFAULT GETDATE(),
        ModifiedDate DATETIME,
        CreatedBy INT,
        ModifiedBy INT,
        FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID),
        FOREIGN KEY (PositionID) REFERENCES Positions(PositionID),
        FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID),
        FOREIGN KEY (UserID) REFERENCES Users(UserID), -- Connect to Users table (optional)
        FOREIGN KEY (CreatedBy) REFERENCES Users(UserID),
        FOREIGN KEY (ModifiedBy) REFERENCES Users(UserID)
    )
    PRINT 'Table Employees created successfully.'
END
ELSE
BEGIN
    PRINT 'Table Employees already exists.'
    -- Add UserID column if it doesn't exist
    IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Employees') AND name = 'UserID')
    BEGIN
        ALTER TABLE Employees ADD UserID INT NULL
        PRINT 'UserID column added to Employees table.'
    END
    
    -- Add foreign key constraint if it doesn't exist
    IF NOT EXISTS (
        SELECT 1 FROM sys.foreign_keys 
        WHERE parent_object_id = OBJECT_ID('Employees') 
          AND referenced_object_id = OBJECT_ID('Users')
          AND name = 'FK_Employees_Users'
    )
    BEGIN
        ALTER TABLE Employees
        ADD CONSTRAINT FK_Employees_Users
        FOREIGN KEY (UserID) REFERENCES Users(UserID)
        PRINT 'Foreign key constraint added to Employees table.'
    END
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

PRINT 'All tables created successfully!'
PRINT 'Users and Employees tables are now connected via UserID foreign key'
GO 