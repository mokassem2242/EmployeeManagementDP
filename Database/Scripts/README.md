# Database Setup Instructions

## Prerequisites
- SQL Server 2019 or later
- SQL Server Management Studio (SSMS) or Azure Data Studio

## Setup Steps

### 1. Create Database
Run the script: `01_CreateDatabase.sql`
- This creates the UAE_EmployeeDB database
- Sets the context to the new database

### 2. Create Tables
Run the script: `02_CreateTables.sql`
- Creates all required tables:
  - Users (for authentication)
  - Roles (user roles)
  - Departments (employee departments)
  - Positions (job positions)
  - Employees (main employee data)
  - AuditLogs (audit trail)

### 3. Insert Sample Data
Run the script: `03_InsertSampleData.sql`
- Inserts sample roles (Admin, Manager, User)
- Inserts sample departments (IT, HR, Finance, etc.)
- Inserts sample positions (Developer, Analyst, Manager, etc.)
- Creates default admin user

### 4. Create Stored Procedures
Run the script: `04_CreateStoredProcedures.sql`
- Creates all CRUD stored procedures for employees
- Creates procedures for departments and positions
- Creates authentication procedures
- Creates audit logging procedures

## Database Schema

### Employees Table
- **EmployeeID**: Primary key
- **EmiratesID**: Unique UAE Emirates ID
- **PassportNumber**: Passport number
- **FirstName, LastName**: Employee names
- **Nationality**: Employee nationality
- **DateOfBirth**: Birth date
- **Gender**: Male/Female
- **WorkEmail, PersonalEmail**: Email addresses
- **WorkPhone, PersonalPhone**: Phone numbers
- **Emirates, City, District**: Address information
- **HireDate**: Employment start date
- **ContractType**: Type of employment contract
- **EmploymentStatus**: Active, Retired, Resigned, Terminated
- **DepartmentID, PositionID**: Foreign keys to departments and positions
- **ManagerID**: Self-referencing foreign key for hierarchy
- **SalaryGrade**: Salary grade information
- **CreatedDate, ModifiedDate**: Audit timestamps
- **CreatedBy, ModifiedBy**: User audit information

### Supporting Tables
- **Departments**: Department information
- **Positions**: Job position information
- **Users**: User authentication
- **Roles**: User role definitions
- **AuditLogs**: Audit trail for all changes

## Connection String
Add this to your Web.config:
```xml
<connectionStrings>
  <add name="UAE_EmployeeDB" 
       connectionString="Data Source=YOUR_SERVER;Initial Catalog=UAE_EmployeeDB;Integrated Security=True;" 
       providerName="System.Data.SqlClient" />
</connectionStrings>
```

## Testing the Setup
After running all scripts, you can test with:
```sql
-- Test employee retrieval
EXEC sp_Employee_GetAll

-- Test department retrieval
EXEC sp_Department_GetAll

-- Test position retrieval
EXEC sp_Position_GetAll
```

## Notes
- All stored procedures use parameterized queries for security
- Foreign key constraints ensure data integrity
- Audit logging is available for all employee operations
- Sample data includes UAE government departments and positions 