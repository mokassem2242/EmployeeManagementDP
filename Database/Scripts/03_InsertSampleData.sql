-- Insert Sample Data for UAE Employee Database
USE UAE_EmployeeDB
GO

-- Insert only the two required roles
DELETE FROM Roles
GO

INSERT INTO Roles (RoleName, Description) VALUES 
('Admin', 'System Administrator - can manage employees (CRUD)'),
('Employee', 'Employee - can view own details')
PRINT 'Roles (Admin and Employee) inserted successfully.'
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

-- Insert sample admin user (only if not exists)
IF NOT EXISTS (SELECT * FROM Users WHERE Username = 'admin')
BEGIN
    INSERT INTO Users (Username, PasswordHash, Email, RoleID) VALUES 
    ('admin', 'admin123', 'admin@uae.gov.ae', 1)
    PRINT 'Sample admin user created successfully.'
END
ELSE
BEGIN
    PRINT 'Sample admin user already exists.'
    -- Update existing admin user to have Admin role
    UPDATE Users SET RoleID = 1 WHERE Username = 'admin'
END
GO

PRINT 'Sample data inserted successfully!'
PRINT 'Roles: Admin (can manage employees) and Employee (can view own details)'
GO 