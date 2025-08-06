-- Fix Search Stored Procedure to include email search
USE UAE_EmployeeDB
GO

-- Drop and recreate the search stored procedure with email search functionality
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
           e.WorkEmail LIKE '%' + @SearchTerm + '%' OR
           e.PersonalEmail LIKE '%' + @SearchTerm + '%' OR
           e.FirstName + ' ' + e.LastName LIKE '%' + @SearchTerm + '%')
    AND (@DepartmentID IS NULL OR e.DepartmentID = @DepartmentID)
    AND (@EmploymentStatus IS NULL OR e.EmploymentStatus = @EmploymentStatus)
    ORDER BY e.EmployeeID DESC
END
GO

PRINT 'Search stored procedure updated successfully with email search functionality!'
GO 