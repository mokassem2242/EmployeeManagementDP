-- =============================================
-- Create stored procedure for getting employees by IDs
-- =============================================
USE [UAE_EmployeeDB]
GO

-- Create user-defined table type for employee IDs
IF NOT EXISTS (SELECT * FROM sys.types WHERE name = 'IntList')
BEGIN
    CREATE TYPE IntList AS TABLE
    (
        EmployeeID INT
    )
END
GO

-- Drop the stored procedure if it exists
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Employee_GetByIds]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_Employee_GetByIds]
GO

-- Create the stored procedure
CREATE PROCEDURE [dbo].[sp_Employee_GetByIds]
    @EmployeeIDs IntList READONLY
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        e.EmployeeID,
        e.EmiratesID,
        e.PassportNumber,
        e.FirstName,
        e.LastName,
        e.Nationality,
        e.DateOfBirth,
        e.Gender,
        e.WorkEmail,
        e.PersonalEmail,
        e.WorkPhone,
        e.PersonalPhone,
        e.Emirates,
        e.City,
        e.District,
        e.HireDate,
        e.ContractType,
        e.EmploymentStatus,
        e.SalaryGrade,
        e.CreatedDate,
        e.ModifiedDate,
        d.DepartmentName,
        p.PositionTitle,
        CONCAT(e.FirstName, ' ', e.LastName) AS FullName
    FROM Employees e
    LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID
    LEFT JOIN Positions p ON e.PositionID = p.PositionID
    WHERE e.EmployeeID IN (SELECT EmployeeID FROM @EmployeeIDs)
    ORDER BY e.FirstName, e.LastName;
END
GO

PRINT 'Export stored procedures created successfully!'
GO 