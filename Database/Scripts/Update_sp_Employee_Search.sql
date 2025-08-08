-- Update sp_Employee_Search Stored Procedure
-- This script updates the existing sp_Employee_Search stored procedure with enhanced functionality

USE UAE_EmployeeDB
GO

-- Drop the existing stored procedure
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Employee_Search]') AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE sp_Employee_Search
    PRINT 'Existing sp_Employee_Search procedure dropped.'
END
GO

-- Create the updated stored procedure with enhanced search functionality
CREATE PROCEDURE sp_Employee_Search
    @SearchTerm NVARCHAR(100) = NULL,
    @DepartmentID INT = NULL,
    @PositionID INT = NULL,
    @EmploymentStatus NVARCHAR(20) = NULL,
    @Emirates NVARCHAR(50) = NULL,
    @City NVARCHAR(50) = NULL,
    @ContractType NVARCHAR(50) = NULL,
    @HireDateFrom DATE = NULL,
    @HireDateTo DATE = NULL,
    @HasUserAccount BIT = NULL,
    @PageNumber INT = 1,
    @PageSize INT = 20,
    @SortBy NVARCHAR(50) = 'EmployeeID',
    @SortOrder NVARCHAR(4) = 'DESC'
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Input validation
    IF @PageNumber < 1 SET @PageNumber = 1
    IF @PageSize < 1 OR @PageSize > 100 SET @PageSize = 20
    IF @SortOrder NOT IN ('ASC', 'DESC') SET @SortOrder = 'DESC'
    
    -- Build dynamic SQL for flexible sorting
    DECLARE @SQL NVARCHAR(MAX)
    DECLARE @WhereClause NVARCHAR(MAX) = ''
    DECLARE @OrderByClause NVARCHAR(MAX)
    
    -- Build WHERE clause
    IF @SearchTerm IS NOT NULL AND LEN(TRIM(@SearchTerm)) > 0
    BEGIN
        SET @WhereClause = @WhereClause + ' AND (e.FirstName LIKE ''%' + @SearchTerm + '%'' OR 
                                                    e.LastName LIKE ''%' + @SearchTerm + '%'' OR 
                                                    e.EmiratesID LIKE ''%' + @SearchTerm + '%'' OR
                                                    e.WorkEmail LIKE ''%' + @SearchTerm + '%'' OR
                                                    e.PersonalEmail LIKE ''%' + @SearchTerm + '%'' OR
                                                    e.WorkPhone LIKE ''%' + @SearchTerm + '%'' OR
                                                    e.PersonalPhone LIKE ''%' + @SearchTerm + '%'' OR
                                                    e.FirstName + '' '' + e.LastName LIKE ''%' + @SearchTerm + '%'')'
    END
    
    IF @DepartmentID IS NOT NULL
        SET @WhereClause = @WhereClause + ' AND e.DepartmentID = ' + CAST(@DepartmentID AS NVARCHAR(10))
    
    IF @PositionID IS NOT NULL
        SET @WhereClause = @WhereClause + ' AND e.PositionID = ' + CAST(@PositionID AS NVARCHAR(10))
    
    IF @EmploymentStatus IS NOT NULL
        SET @WhereClause = @WhereClause + ' AND e.EmploymentStatus = ''' + @EmploymentStatus + ''''
    
    IF @Emirates IS NOT NULL
        SET @WhereClause = @WhereClause + ' AND e.Emirates = ''' + @Emirates + ''''
    
    IF @City IS NOT NULL
        SET @WhereClause = @WhereClause + ' AND e.City = ''' + @City + ''''
    
    IF @ContractType IS NOT NULL
        SET @WhereClause = @WhereClause + ' AND e.ContractType = ''' + @ContractType + ''''
    
    IF @HireDateFrom IS NOT NULL
        SET @WhereClause = @WhereClause + ' AND e.HireDate >= ''' + CAST(@HireDateFrom AS NVARCHAR(10)) + ''''
    
    IF @HireDateTo IS NOT NULL
        SET @WhereClause = @WhereClause + ' AND e.HireDate <= ''' + CAST(@HireDateTo AS NVARCHAR(10)) + ''''
    
    IF @HasUserAccount IS NOT NULL
    BEGIN
        IF @HasUserAccount = 1
            SET @WhereClause = @WhereClause + ' AND e.UserID IS NOT NULL'
        ELSE
            SET @WhereClause = @WhereClause + ' AND e.UserID IS NULL'
    END
    
    -- Remove leading ' AND ' if exists
    IF LEN(@WhereClause) > 0 AND LEFT(@WhereClause, 5) = ' AND '
        SET @WhereClause = SUBSTRING(@WhereClause, 6, LEN(@WhereClause))
    
    -- Build ORDER BY clause
    SET @OrderByClause = ' ORDER BY ' + 
        CASE @SortBy
            WHEN 'FirstName' THEN 'e.FirstName'
            WHEN 'LastName' THEN 'e.LastName'
            WHEN 'EmiratesID' THEN 'e.EmiratesID'
            WHEN 'DepartmentName' THEN 'd.DepartmentName'
            WHEN 'PositionTitle' THEN 'p.PositionTitle'
            WHEN 'HireDate' THEN 'e.HireDate'
            WHEN 'EmploymentStatus' THEN 'e.EmploymentStatus'
            WHEN 'CreatedDate' THEN 'e.CreatedDate'
            ELSE 'e.EmployeeID'
        END + ' ' + @SortOrder
    
    -- Build the complete SQL query
    SET @SQL = '
    WITH EmployeeData AS (
        SELECT e.*, 
               d.DepartmentName, 
               p.PositionTitle, 
               e.FirstName + '' '' + e.LastName as FullName,
               m.FirstName + '' '' + m.LastName as ManagerName,
               u.Username, 
               r.RoleName,
               ROW_NUMBER() OVER(' + @OrderByClause + ') as RowNum,
               COUNT(*) OVER() as TotalCount
        FROM Employees e
        LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID
        LEFT JOIN Positions p ON e.PositionID = p.PositionID
        LEFT JOIN Employees m ON e.ManagerID = m.EmployeeID
        LEFT JOIN Users u ON e.UserID = u.UserID
        LEFT JOIN Roles r ON u.RoleID = r.RoleID
        WHERE 1=1 ' + 
        CASE WHEN LEN(@WhereClause) > 0 THEN 'AND ' + @WhereClause ELSE '' END + '
    )
    SELECT * FROM EmployeeData 
    WHERE RowNum BETWEEN ' + CAST((@PageNumber - 1) * @PageSize + 1 AS NVARCHAR(10)) + 
    ' AND ' + CAST(@PageNumber * @PageSize AS NVARCHAR(10)) + '
    ORDER BY RowNum'
    
    -- Execute the dynamic SQL
    EXEC sp_executesql @SQL
    
    -- Return total count for pagination
    SET @SQL = '
    SELECT COUNT(*) as TotalCount
    FROM Employees e
    LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID
    LEFT JOIN Positions p ON e.PositionID = p.PositionID
    LEFT JOIN Employees m ON e.ManagerID = m.EmployeeID
    LEFT JOIN Users u ON e.UserID = u.UserID
    LEFT JOIN Roles r ON u.RoleID = r.RoleID
    WHERE 1=1 ' + 
    CASE WHEN LEN(@WhereClause) > 0 THEN 'AND ' + @WhereClause ELSE '' END
    
    EXEC sp_executesql @SQL
END
GO

PRINT 'sp_Employee_Search stored procedure updated successfully with enhanced functionality!'
PRINT 'New features include:'
PRINT '- Advanced search filters (Department, Position, Employment Status, Emirates, City, Contract Type)'
PRINT '- Date range filtering for hire dates'
PRINT '- Filter by whether employee has user account'
PRINT '- Pagination support with configurable page size'
PRINT '- Flexible sorting by multiple fields'
PRINT '- Total count returned for pagination'
GO
