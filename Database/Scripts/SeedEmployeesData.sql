-- Seed Employees Table with Test Data
-- This script inserts realistic UAE employee data for testing search functionality

USE UAE_EmployeeDB
GO

-- Clear existing data (optional - uncomment if you want to start fresh)
-- DELETE FROM Employees WHERE EmployeeID > 0
-- DBCC CHECKIDENT ('Employees', RESEED, 0)

-- Insert test employees with realistic UAE data
INSERT INTO Employees (
    EmiratesID, PassportNumber, FirstName, LastName, Nationality, 
    DateOfBirth, Gender, WorkEmail, PersonalEmail, WorkPhone, PersonalPhone,
    Emirates, City, District, HireDate, ContractType, EmploymentStatus,
    DepartmentID, PositionID, ManagerID, SalaryGrade, IsActive, CreatedBy, CreatedDate
) VALUES
-- IT Department Employees
('7841985123456789', 'A12345678', 'Ahmed', 'Al Mansouri', 'UAE', '1985-03-15', 'Male', 'ahmed.mansouri@company.ae', 'ahmed.mansouri@gmail.com', '+971501234567', '+971501234568', 'Dubai', 'Dubai', 'Business Bay', '2020-01-15', 'Full-Time', 'Active', 1, 1, NULL, 'G5', 1, 1, GETDATE()),
('7841990123456789', 'B23456789', 'Fatima', 'Al Zaabi', 'UAE', '1990-07-22', 'Female', 'fatima.zaabi@company.ae', 'fatima.zaabi@hotmail.com', '+971502345678', '+971502345679', 'Abu Dhabi', 'Abu Dhabi', 'Al Reem Island', '2021-03-10', 'Full-Time', 'Active', 1, 2, 1, 'G4', 1, 1, GETDATE()),
('7841988123456789', 'C34567890', 'Omar', 'Al Qasimi', 'UAE', '1988-11-08', 'Male', 'omar.qasimi@company.ae', 'omar.qasimi@yahoo.com', '+971503456789', '+971503456790', 'Sharjah', 'Sharjah', 'Al Khan', '2019-08-20', 'Full-Time', 'Active', 1, 3, 1, 'G4', 1, 1, GETDATE()),
('7841992123456789', 'D45678901', 'Aisha', 'Al Falasi', 'UAE', '1992-04-12', 'Female', 'aisha.falasi@company.ae', 'aisha.falasi@outlook.com', '+971504567890', '+971504567891', 'Dubai', 'Dubai', 'Palm Jumeirah', '2022-01-05', 'Full-Time', 'Active', 1, 4, 1, 'G3', 1, 1, GETDATE()),

-- HR Department Employees
('7841986123456789', 'E56789012', 'Khalid', 'Al Suwaidi', 'UAE', '1986-09-30', 'Male', 'khalid.suwaidi@company.ae', 'khalid.suwaidi@gmail.com', '+971505678901', '+971505678902', 'Abu Dhabi', 'Abu Dhabi', 'Saadiyat Island', '2018-06-15', 'Full-Time', 'Active', 2, 5, NULL, 'G6', 1, 1, GETDATE()),
('7841993123456789', 'F67890123', 'Noor', 'Al Ameri', 'UAE', '1993-12-03', 'Female', 'noor.ameri@company.ae', 'noor.ameri@hotmail.com', '+971506789012', '+971506789013', 'Dubai', 'Dubai', 'Dubai Marina', '2021-09-12', 'Full-Time', 'Active', 2, 6, 5, 'G4', 1, 1, GETDATE()),
('7841989123456789', 'G78901234', 'Youssef', 'Al Mazrouei', 'UAE', '1989-05-18', 'Male', 'youssef.mazrouei@company.ae', 'youssef.mazrouei@yahoo.com', '+971507890123', '+971507890124', 'Sharjah', 'Sharjah', 'Al Majaz', '2020-11-08', 'Full-Time', 'Active', 2, 7, 5, 'G4', 1, 1, GETDATE()),

-- Finance Department Employees
('7841987123456789', 'H89012345', 'Layla', 'Al Dhahiri', 'UAE', '1987-01-25', 'Female', 'layla.dhahiri@company.ae', 'layla.dhahiri@gmail.com', '+971508901234', '+971508901235', 'Dubai', 'Dubai', 'JLT', '2019-04-22', 'Full-Time', 'Active', 3, 8, NULL, 'G6', 1, 1, GETDATE()),
('7841994123456789', 'I90123456', 'Hassan', 'Al Nuaimi', 'UAE', '1994-08-14', 'Male', 'hassan.nuaimi@company.ae', 'hassan.nuaimi@outlook.com', '+971509012345', '+971509012346', 'Abu Dhabi', 'Abu Dhabi', 'Al Maryah Island', '2022-03-18', 'Full-Time', 'Active', 3, 9, 8, 'G4', 1, 1, GETDATE()),
('7841991123456789', 'J01234567', 'Mariam', 'Al Ketbi', 'UAE', '1991-10-07', 'Female', 'mariam.ketbi@company.ae', 'mariam.ketbi@hotmail.com', '+971500123456', '+971500123457', 'Sharjah', 'Sharjah', 'Al Qasba', '2021-07-30', 'Full-Time', 'Active', 3, 10, 8, 'G4', 1, 1, GETDATE()),

-- Marketing Department Employees
('7841995123456789', 'K12345678', 'Abdullah', 'Al Hameli', 'UAE', '1995-02-28', 'Male', 'abdullah.hameli@company.ae', 'abdullah.hameli@gmail.com', '+971501234567', '+971501234568', 'Dubai', 'Dubai', 'Downtown', '2022-06-10', 'Full-Time', 'Active', 4, 11, NULL, 'G5', 1, 1, GETDATE()),
('7841996123456789', 'L23456789', 'Reem', 'Al Shamsi', 'UAE', '1996-06-20', 'Female', 'reem.shamsi@company.ae', 'reem.shamsi@yahoo.com', '+971502345678', '+971502345679', 'Abu Dhabi', 'Abu Dhabi', 'Al Raha Beach', '2022-08-15', 'Full-Time', 'Active', 4, 12, 11, 'G3', 1, 1, GETDATE()),
('7841997123456789', 'M34567890', 'Saeed', 'Al Qubaisi', 'UAE', '1993-11-11', 'Male', 'saeed.qubaisi@company.ae', 'saeed.qubaisi@outlook.com', '+971503456789', '+971503456790', 'Sharjah', 'Sharjah', 'Al Nahda', '2021-12-03', 'Full-Time', 'Active', 4, 13, 11, 'G4', 1, 1, GETDATE()),

-- Operations Department Employees
('7841998123456789', 'N45678901', 'Hessa', 'Al Romaithi', 'UAE', '1994-04-05', 'Female', 'hessa.romaithi@company.ae', 'hessa.romaithi@gmail.com', '+971504567890', '+971504567891', 'Dubai', 'Dubai', 'Al Barsha', '2022-02-28', 'Full-Time', 'Active', 5, 14, NULL, 'G5', 1, 1, GETDATE()),
('7841999123456789', 'O56789012', 'Mohammed', 'Al Dhaheri', 'UAE', '1990-12-15', 'Male', 'mohammed.dhaheri@company.ae', 'mohammed.dhaheri@hotmail.com', '+971505678901', '+971505678902', 'Abu Dhabi', 'Abu Dhabi', 'Al Bateen', '2020-05-12', 'Full-Time', 'Active', 5, 15, 14, 'G4', 1, 1, GETDATE()),
('7842000123456789', 'P67890123', 'Salama', 'Al Mehairi', 'UAE', '1997-09-08', 'Female', 'salama.mehairi@company.ae', 'salama.mehairi@yahoo.com', '+971506789012', '+971506789013', 'Sharjah', 'Sharjah', 'Al Mamzar', '2022-10-20', 'Full-Time', 'Active', 5, 16, 14, 'G3', 1, 1, GETDATE()),

-- Inactive Employees (for testing status filter)
('7842001123456789', 'Q78901234', 'Zayed', 'Al Nahyan', 'UAE', '1985-08-22', 'Male', 'zayed.nahyan@company.ae', 'zayed.nahyan@gmail.com', '+971507890123', '+971507890124', 'Dubai', 'Dubai', 'Emirates Hills', '2018-03-15', 'Full-Time', 'Inactive', 1, 1, NULL, 'G5', 0, 1, GETDATE()),
('7842002123456789', 'R89012345', 'Shamsa', 'Al Maktoum', 'UAE', '1992-01-30', 'Female', 'shamsa.maktoum@company.ae', 'shamsa.maktoum@hotmail.com', '+971508901234', '+971508901235', 'Abu Dhabi', 'Abu Dhabi', 'Al Khalidiyah', '2020-07-08', 'Full-Time', 'Inactive', 2, 5, NULL, 'G4', 0, 1, GETDATE()),

-- Part-time Employees
('7842003123456789', 'S90123456', 'Rashid', 'Al Falahi', 'UAE', '1996-03-12', 'Male', 'rashid.falahi@company.ae', 'rashid.falahi@outlook.com', '+971509012345', '+971509012346', 'Sharjah', 'Sharjah', 'Al Taawun', '2022-01-10', 'Part-Time', 'Active', 3, 8, NULL, 'G3', 1, 1, GETDATE()),
('7842004123456789', 'T01234567', 'Alya', 'Al Saadi', 'UAE', '1998-07-25', 'Female', 'alya.saadi@company.ae', 'alya.saadi@gmail.com', '+971500123456', '+971500123457', 'Dubai', 'Dubai', 'Al Sufouh', '2022-04-18', 'Part-Time', 'Active', 4, 11, NULL, 'G3', 1, 1, GETDATE()),

-- Contract Employees
('7842005123456789', 'U12345678', 'Hamdan', 'Al Qubaisi', 'UAE', '1991-05-14', 'Male', 'hamdan.qubaisi@company.ae', 'hamdan.qubaisi@yahoo.com', '+971501234567', '+971501234568', 'Abu Dhabi', 'Abu Dhabi', 'Al Mushrif', '2021-11-05', 'Contract', 'Active', 5, 14, NULL, 'G4', 1, 1, GETDATE()),
('7842006123456789', 'V23456789', 'Dana', 'Al Mansouri', 'UAE', '1995-12-03', 'Female', 'dana.mansouri@company.ae', 'dana.mansouri@hotmail.com', '+971502345678', '+971502345679', 'Sharjah', 'Sharjah', 'Al Qasimiya', '2022-09-12', 'Contract', 'Active', 1, 2, NULL, 'G4', 1, 1, GETDATE())

GO

-- Verify the data was inserted
SELECT 
    EmployeeID,
    EmiratesID,
    FirstName + ' ' + LastName as FullName,
    WorkEmail,
    PersonalEmail,
    DepartmentID,
    EmploymentStatus,
    ContractType,
    IsActive
FROM Employees 
ORDER BY EmployeeID

GO

PRINT 'Employee data seeded successfully!'
PRINT 'Total employees inserted: ' + CAST(@@ROWCOUNT AS VARCHAR(10))
PRINT ''
PRINT 'Test the search functionality with:'
PRINT '1. Search by name: EXEC sp_Employee_Search @SearchTerm = ''Ahmed'''
PRINT '2. Search by email: EXEC sp_Employee_Search @SearchTerm = ''@company.ae'''
PRINT '3. Search by Emirates ID: EXEC sp_Employee_Search @SearchTerm = ''784'''
PRINT '4. Filter by department: EXEC sp_Employee_Search @DepartmentID = 1'
PRINT '5. Filter by status: EXEC sp_Employee_Search @EmploymentStatus = ''Active'''
PRINT '6. Combined filters: EXEC sp_Employee_Search @DepartmentID = 1, @EmploymentStatus = ''Active'''
