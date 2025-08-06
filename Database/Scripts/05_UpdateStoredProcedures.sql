-- Update Stored Procedures for UAE Employee Database
-- This script updates the employee stored procedures to include FullName computed column

USE UAE_EmployeeDB
GO

-- Update sp_Employee_GetAll stored procedure
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Employee_GetAll]') AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE sp_Employee_GetAll
END
GO

CREATE PROCEDURE sp_Employee_GetAll
AS
BEGIN
    SELECT e.*, d.DepartmentName, p.PositionTitle, 
           e.FirstName + ' ' + e.LastName as FullName,
           m.FirstName + ' ' + m.LastName as ManagerName,
           u.Username, r.RoleName
    FROM Employees e
    LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID
    LEFT JOIN Positions p ON e.PositionID = p.PositionID
    LEFT JOIN Employees m ON e.ManagerID = m.EmployeeID
    LEFT JOIN Users u ON e.UserID = u.UserID
    LEFT JOIN Roles r ON u.RoleID = r.RoleID
    ORDER BY e.EmployeeID DESC
END
GO

-- Update sp_Employee_GetById stored procedure
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Employee_GetById]') AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE sp_Employee_GetById
END
GO

CREATE PROCEDURE sp_Employee_GetById
    @EmployeeID INT
AS
BEGIN
    SELECT e.*, d.DepartmentName, p.PositionTitle, 
           e.FirstName + ' ' + e.LastName as FullName,
           m.FirstName + ' ' + m.LastName as ManagerName,
           u.Username, r.RoleName
    FROM Employees e
    LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID
    LEFT JOIN Positions p ON e.PositionID = p.PositionID
    LEFT JOIN Employees m ON e.ManagerID = m.EmployeeID
    LEFT JOIN Users u ON e.UserID = u.UserID
    LEFT JOIN Roles r ON u.RoleID = r.RoleID
    WHERE e.EmployeeID = @EmployeeID
END
GO

-- Update sp_Employee_GetByUserId stored procedure
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Employee_GetByUserId]') AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE sp_Employee_GetByUserId
END
GO

CREATE PROCEDURE sp_Employee_GetByUserId
    @UserID INT
AS
BEGIN
    SELECT e.*, d.DepartmentName, p.PositionTitle, 
           e.FirstName + ' ' + e.LastName as FullName,
           m.FirstName + ' ' + m.LastName as ManagerName,
           u.Username, r.RoleName
    FROM Employees e
    LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID
    LEFT JOIN Positions p ON e.PositionID = p.PositionID
    LEFT JOIN Employees m ON e.ManagerID = m.EmployeeID
    LEFT JOIN Users u ON e.UserID = u.UserID
    LEFT JOIN Roles r ON u.RoleID = r.RoleID
    WHERE e.UserID = @UserID
END
GO

-- Update sp_Employee_Search stored procedure
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
    SELECT e.*, d.DepartmentName, p.PositionTitle, 
           e.FirstName + ' ' + e.LastName as FullName,
           m.FirstName + ' ' + m.LastName as ManagerName,
           u.Username, r.RoleName
    FROM Employees e
    LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID
    LEFT JOIN Positions p ON e.PositionID = p.PositionID
    LEFT JOIN Employees m ON e.ManagerID = m.EmployeeID
    LEFT JOIN Users u ON e.UserID = u.UserID
    LEFT JOIN Roles r ON u.RoleID = r.RoleID
    WHERE (@SearchTerm IS NULL OR 
           e.FirstName LIKE '%' + @SearchTerm + '%' OR 
           e.LastName LIKE '%' + @SearchTerm + '%' OR 
           e.EmiratesID LIKE '%' + @SearchTerm + '%' OR
           e.FirstName + ' ' + e.LastName LIKE '%' + @SearchTerm + '%')
    AND (@DepartmentID IS NULL OR e.DepartmentID = @DepartmentID)
    AND (@EmploymentStatus IS NULL OR e.EmploymentStatus = @EmploymentStatus)
    ORDER BY e.EmployeeID DESC
END
GO

PRINT 'All employee stored procedures updated successfully!'
PRINT 'FullName computed column has been added to all employee queries.'
PRINT 'The GridView should now work without the DataBinding error.'
GO 