-- Update sp_Employee_Search stored procedure
-- This script updates the search functionality with conditional logic

USE UAE_EmployeeDB
GO

-- Drop the existing stored procedure
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Employee_Search]') AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE sp_Employee_Search
    PRINT 'Existing sp_Employee_Search dropped.'
END
GO

-- Create the updated stored procedure
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
    WHERE 
        -- When SearchTerm is provided, it overrides department and employment status filters
        (@SearchTerm IS NOT NULL AND (
            ISNULL(e.FirstName, '') LIKE '%' + @SearchTerm + '%' OR 
            ISNULL(e.LastName, '') LIKE '%' + @SearchTerm + '%' OR 
            ISNULL(e.EmiratesID, '') LIKE '%' + @SearchTerm + '%' OR
            ISNULL(e.WorkEmail, '') LIKE '%' + @SearchTerm + '%' OR
            ISNULL(e.PersonalEmail, '') LIKE '%' + @SearchTerm + '%' OR
            (ISNULL(e.FirstName, '') + ' ' + ISNULL(e.LastName, '')) LIKE '%' + @SearchTerm + '%'
        ))
        OR
        -- When SearchTerm is NULL, apply department and employment status filters together
        (@SearchTerm IS NULL AND 
         (@DepartmentID IS NULL OR e.DepartmentID = @DepartmentID) AND
         (@EmploymentStatus IS NULL OR e.EmploymentStatus = @EmploymentStatus))
    ORDER BY e.EmployeeID DESC
END
GO

PRINT 'sp_Employee_Search stored procedure updated successfully!'
PRINT 'Search now includes:'
PRINT '- First Name'
PRINT '- Last Name'
PRINT '- Emirates ID'
PRINT '- Work Email'
PRINT '- Personal Email'
PRINT '- Full Name'
PRINT '- Conditional Logic:'
PRINT '  * When SearchTerm is provided: overrides department and status filters'
PRINT '  * When SearchTerm is NULL: applies department and status filters together'
PRINT '- Department and Employment Status filters work together when no search term is provided'
GO
