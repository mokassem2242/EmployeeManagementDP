-- Check if data exists and insert sample data if it doesn't

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