# ASMX Web Services Documentation

## Overview
This document describes the ASMX Web Services implementation for the UAE Employee Management System. All services use the ADO.NET Data Access Layer for database operations.

## Service Endpoints

### 1. EmployeeService.asmx
**Namespace**: `http://uae.gov.ae/EmployeeService/`
**Purpose**: Main employee management operations

#### Available Methods:

##### `GetAllEmployees()`
- **Purpose**: Retrieves all employees with department and position information
- **Returns**: DataTable with employee data
- **Usage**: `GET /Services/EmployeeService.asmx/GetAllEmployees`

##### `GetEmployeeById(int employeeId)`
- **Purpose**: Gets specific employee by ID
- **Parameters**: 
  - `employeeId` (int): Employee ID
- **Returns**: DataTable with employee data
- **Usage**: `GET /Services/EmployeeService.asmx/GetEmployeeById?employeeId=1`

##### `InsertEmployee(...)`
- **Purpose**: Creates new employee
- **Parameters**:
  - `emiratesId` (string): UAE Emirates ID (required)
  - `passportNumber` (string): Passport number
  - `firstName` (string): First name (required)
  - `lastName` (string): Last name (required)
  - `nationality` (string): Nationality
  - `dateOfBirth` (DateTime?): Date of birth
  - `gender` (string): Gender
  - `workEmail` (string): Work email
  - `personalEmail` (string): Personal email
  - `workPhone` (string): Work phone
  - `personalPhone` (string): Personal phone
  - `emirates` (string): UAE emirate
  - `city` (string): City
  - `district` (string): District
  - `hireDate` (DateTime?): Hire date
  - `contractType` (string): Contract type
  - `employmentStatus` (string): Employment status (default: "Active")
  - `departmentId` (int?): Department ID
  - `positionId` (int?): Position ID
  - `managerId` (int?): Manager ID
  - `salaryGrade` (string): Salary grade
  - `createdBy` (int): User ID who created the record
- **Returns**: int (new employee ID)
- **Usage**: `POST /Services/EmployeeService.asmx/InsertEmployee`

##### `UpdateEmployee(...)`
- **Purpose**: Updates existing employee
- **Parameters**: Same as InsertEmployee plus `employeeId` and `modifiedBy`
- **Returns**: bool (success status)
- **Usage**: `POST /Services/EmployeeService.asmx/UpdateEmployee`

##### `DeleteEmployee(int employeeId)`
- **Purpose**: Deletes employee by ID
- **Parameters**: 
  - `employeeId` (int): Employee ID to delete
- **Returns**: bool (success status)
- **Usage**: `POST /Services/EmployeeService.asmx/DeleteEmployee`

##### `SearchEmployees(string searchTerm, int? departmentId, string employmentStatus)`
- **Purpose**: Advanced search with filters
- **Parameters**:
  - `searchTerm` (string): Search in name, Emirates ID
  - `departmentId` (int?): Filter by department
  - `employmentStatus` (string): Filter by status
- **Returns**: DataTable with filtered results
- **Usage**: `GET /Services/EmployeeService.asmx/SearchEmployees`

##### `GetEmployeesByDepartment(int departmentId)`
- **Purpose**: Get employees by department
- **Parameters**: 
  - `departmentId` (int): Department ID
- **Returns**: DataTable with employees
- **Usage**: `GET /Services/EmployeeService.asmx/GetEmployeesByDepartment`

##### `GetEmployeesByStatus(string employmentStatus)`
- **Purpose**: Get employees by employment status
- **Parameters**: 
  - `employmentStatus` (string): Status (Active, Retired, etc.)
- **Returns**: DataTable with employees
- **Usage**: `GET /Services/EmployeeService.asmx/GetEmployeesByStatus`

##### `GetAllDepartments()`
- **Purpose**: Get all departments for dropdown
- **Returns**: DataTable with departments
- **Usage**: `GET /Services/EmployeeService.asmx/GetAllDepartments`

##### `GetAllPositions()`
- **Purpose**: Get all positions for dropdown
- **Returns**: DataTable with positions
- **Usage**: `GET /Services/EmployeeService.asmx/GetAllPositions`

### 2. AuthService.asmx
**Namespace**: `http://uae.gov.ae/AuthService/`
**Purpose**: User authentication and management

#### Available Methods:

##### `AuthenticateUser(string username, string password)`
- **Purpose**: Authenticates user login
- **Parameters**:
  - `username` (string): Username
  - `password` (string): Password (will be hashed)
- **Returns**: DataTable with user data if successful
- **Usage**: `POST /Services/AuthService.asmx/AuthenticateUser`

##### `GetUserById(int userId)`
- **Purpose**: Gets user by ID
- **Parameters**: 
  - `userId` (int): User ID
- **Returns**: DataTable with user data
- **Usage**: `GET /Services/AuthService.asmx/GetUserById`

##### `CreateUser(string username, string password, string email, int roleId)`
- **Purpose**: Creates new user
- **Parameters**:
  - `username` (string): Username
  - `password` (string): Password (will be hashed)
  - `email` (string): Email address
  - `roleId` (int): Role ID
- **Returns**: int (new user ID)
- **Usage**: `POST /Services/AuthService.asmx/CreateUser`

##### `UpdateUserPassword(int userId, string newPassword)`
- **Purpose**: Updates user password
- **Parameters**:
  - `userId` (int): User ID
  - `newPassword` (string): New password (will be hashed)
- **Returns**: bool (success status)
- **Usage**: `POST /Services/AuthService.asmx/UpdateUserPassword`

##### `UpdateLastLoginDate(int userId)`
- **Purpose**: Updates user's last login timestamp
- **Parameters**: 
  - `userId` (int): User ID
- **Returns**: bool (success status)
- **Usage**: `POST /Services/AuthService.asmx/UpdateLastLoginDate`

##### `GetAllRoles()`
- **Purpose**: Gets all user roles
- **Returns**: DataTable with roles
- **Usage**: `GET /Services/AuthService.asmx/GetAllRoles`

##### `IsPasswordStrong(string password)`
- **Purpose**: Validates password strength
- **Parameters**: 
  - `password` (string): Password to validate
- **Returns**: bool (true if strong)
- **Usage**: `POST /Services/AuthService.asmx/IsPasswordStrong`

##### `GenerateRandomPassword(int length)`
- **Purpose**: Generates random password
- **Parameters**: 
  - `length` (int): Password length (6-20, default 8)
- **Returns**: string (random password)
- **Usage**: `GET /Services/AuthService.asmx/GenerateRandomPassword`

### 3. DepartmentService.asmx
**Namespace**: `http://uae.gov.ae/DepartmentService/`
**Purpose**: Department management

#### Available Methods:

##### `GetAllDepartments()`
- **Purpose**: Gets all active departments
- **Returns**: DataTable with departments
- **Usage**: `GET /Services/DepartmentService.asmx/GetAllDepartments`

##### `GetDepartmentById(int departmentId)`
- **Purpose**: Gets department by ID
- **Parameters**: 
  - `departmentId` (int): Department ID
- **Returns**: DataTable with department data
- **Usage**: `GET /Services/DepartmentService.asmx/GetDepartmentById`

##### `CreateDepartment(string departmentName, string departmentCode, string description)`
- **Purpose**: Creates new department
- **Parameters**:
  - `departmentName` (string): Department name (required)
  - `departmentCode` (string): Department code
  - `description` (string): Description
- **Returns**: int (new department ID)
- **Usage**: `POST /Services/DepartmentService.asmx/CreateDepartment`

##### `UpdateDepartment(int departmentId, string departmentName, string departmentCode, string description, bool isActive)`
- **Purpose**: Updates existing department
- **Parameters**: Same as CreateDepartment plus `departmentId` and `isActive`
- **Returns**: bool (success status)
- **Usage**: `POST /Services/DepartmentService.asmx/UpdateDepartment`

##### `DeleteDepartment(int departmentId)`
- **Purpose**: Deletes department by ID
- **Parameters**: 
  - `departmentId` (int): Department ID to delete
- **Returns**: bool (success status)
- **Usage**: `POST /Services/DepartmentService.asmx/DeleteDepartment`

### 4. PositionService.asmx
**Namespace**: `http://uae.gov.ae/PositionService/`
**Purpose**: Position management

#### Available Methods:

##### `GetAllPositions()`
- **Purpose**: Gets all active positions
- **Returns**: DataTable with positions
- **Usage**: `GET /Services/PositionService.asmx/GetAllPositions`

##### `GetPositionById(int positionId)`
- **Purpose**: Gets position by ID
- **Parameters**: 
  - `positionId` (int): Position ID
- **Returns**: DataTable with position data
- **Usage**: `GET /Services/PositionService.asmx/GetPositionById`

##### `CreatePosition(string positionTitle, string positionCode, string description)`
- **Purpose**: Creates new position
- **Parameters**:
  - `positionTitle` (string): Position title (required)
  - `positionCode` (string): Position code
  - `description` (string): Description
- **Returns**: int (new position ID)
- **Usage**: `POST /Services/PositionService.asmx/CreatePosition`

##### `UpdatePosition(int positionId, string positionTitle, string positionCode, string description, bool isActive)`
- **Purpose**: Updates existing position
- **Parameters**: Same as CreatePosition plus `positionId` and `isActive`
- **Returns**: bool (success status)
- **Usage**: `POST /Services/PositionService.asmx/UpdatePosition`

##### `DeletePosition(int positionId)`
- **Purpose**: Deletes position by ID
- **Parameters**: 
  - `positionId` (int): Position ID to delete
- **Returns**: bool (success status)
- **Usage**: `POST /Services/PositionService.asmx/DeletePosition`

## Service URLs

### Development Environment
- **EmployeeService**: `http://localhost:44312/Services/EmployeeService.asmx`
- **AuthService**: `http://localhost:44312/Services/AuthService.asmx`
- **DepartmentService**: `http://localhost:44312/Services/DepartmentService.asmx`
- **PositionService**: `http://localhost:44312/Services/PositionService.asmx`

### Production Environment
- **EmployeeService**: `https://your-domain.com/Services/EmployeeService.asmx`
- **AuthService**: `https://your-domain.com/Services/AuthService.asmx`
- **DepartmentService**: `https://your-domain.com/Services/DepartmentService.asmx`
- **PositionService**: `https://your-domain.com/Services/PositionService.asmx`

## Testing the Services

### Using Browser
1. Navigate to the service URL (e.g., `http://localhost:44312/Services/EmployeeService.asmx`)
2. You'll see the service test page
3. Click on any method to test it

### Using SOAP UI
1. Import the WSDL URL: `http://localhost:44312/Services/EmployeeService.asmx?WSDL`
2. Create requests for each method
3. Test with sample data

### Using jQuery AJAX
```javascript
// Example: Get all employees
$.ajax({
    type: "POST",
    url: "Services/EmployeeService.asmx/GetAllEmployees",
    contentType: "application/json; charset=utf-8",
    dataType: "json",
    success: function(data) {
        console.log("Employees:", data);
    },
    error: function(xhr, status, error) {
        console.error("Error:", error);
    }
});

// Example: Search employees
$.ajax({
    type: "POST",
    url: "Services/EmployeeService.asmx/SearchEmployees",
    contentType: "application/json; charset=utf-8",
    dataType: "json",
    data: JSON.stringify({
        searchTerm: "Ahmed",
        departmentId: 1,
        employmentStatus: "Active"
    }),
    success: function(data) {
        console.log("Search results:", data);
    },
    error: function(xhr, status, error) {
        console.error("Error:", error);
    }
});
```

## Error Handling

All services use `SoapException` for error handling:

```csharp
throw new SoapException("Error message", SoapException.ServerFaultCode);
```

### Common Error Scenarios:
1. **Validation Errors**: Missing required parameters
2. **Database Errors**: Connection issues, stored procedure errors
3. **Authentication Errors**: Invalid credentials
4. **Authorization Errors**: Insufficient permissions

## Security Features

### 1. Input Validation
- All parameters are validated before processing
- Required fields are checked
- Data types are validated

### 2. Password Security
- Passwords are hashed using SHA256
- Password strength validation
- Secure password generation

### 3. Error Information
- Detailed error messages for debugging
- No sensitive information exposed in errors

## Performance Considerations

### 1. Connection Management
- Uses connection pooling
- Proper resource disposal
- Efficient data access patterns

### 2. Data Transfer
- Returns DataTable for easy binding
- Minimal data transfer
- Efficient parameter handling

### 3. Caching
- Consider implementing caching for frequently accessed data
- Cache department and position lists
- Cache user roles

## Integration Examples

### Web Forms Integration
```csharp
// In Web Forms page
protected void btnGetEmployees_Click(object sender, EventArgs e)
{
    var service = new EmployeeService();
    DataTable employees = service.GetAllEmployees();
    GridView1.DataSource = employees;
    GridView1.DataBind();
}
```

### JavaScript Integration
```javascript
// Call service from JavaScript
function getEmployees() {
    $.ajax({
        type: "POST",
        url: "Services/EmployeeService.asmx/GetAllEmployees",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function(data) {
            displayEmployees(data.d);
        }
    });
}
```

## Next Steps

1. **Web Forms UI**: Create ASPX pages that consume these services
2. **Error Logging**: Implement comprehensive logging
3. **Caching**: Add caching for performance
4. **Security**: Implement additional security measures
5. **Documentation**: Create API documentation for external consumers

## Notes

- All services are automatically initialized when the application starts
- Database scripts run automatically on first startup
- Services use the ADO.NET DAL for data access
- All operations are logged for audit purposes
- Services are designed for UAE government requirements 