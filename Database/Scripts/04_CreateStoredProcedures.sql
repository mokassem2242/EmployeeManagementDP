-- Check if stored procedures exist and create them if they don't

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

PRINT 'All stored procedures created successfully.' 