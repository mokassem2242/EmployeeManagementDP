# Employee Service Management System

A comprehensive ASP.NET Web Forms application for managing employee data, departments, and positions. This system provides a complete solution for HR departments to maintain employee records, search and filter employees, and export data in various formats.

## 🚀 Features

### Core Functionality
- **Employee Management**: Add, edit, view, and delete employee records
- **Department Management**: Organize employees by departments
- **Position Management**: Track employee positions and roles
- **Advanced Search & Filtering**: Search by name, filter by department and status
- **Data Export**: Export employee data in Excel, CSV, and PDF formats
- **User Authentication**: Secure login system with role-based access
- **Responsive Design**: Modern UI with Bootstrap framework

### Search & Filter Capabilities
- **Text Search**: Search employees by name, email, or other text fields
- **Department Filter**: Filter employees by specific departments
- **Status Filter**: Filter by employment status (Active/Inactive)
- **Combined Filters**: Use multiple filters simultaneously
- **Real-time Search**: Instant search results as you type

### Export Features
- **Multiple Formats**: Export to Excel (.xlsx), CSV, and PDF
- **Export Scope**: Export all employees, current page, search results, or selected employees
- **Bulk Export**: Select multiple employees for targeted export
- **Customizable**: Choose export format and scope based on needs

### User Interface
- **Modern Design**: Clean, responsive interface using Bootstrap
- **Modal Dialogs**: Inline editing without page navigation
- **Real-time Updates**: AJAX-powered updates for smooth user experience
- **Alert System**: User-friendly notifications and error messages
- **Grid View**: Sortable and paginated employee grid

## 🛠 Technology Stack

### Backend
- **ASP.NET Web Forms**: Main application framework
- **C#**: Programming language
- **ADO.NET**: Data access layer
- **SQL Server**: Database management system

### Frontend
- **HTML5/CSS3**: Markup and styling
- **Bootstrap 5**: Responsive UI framework
- **JavaScript/jQuery**: Client-side interactions
- **AJAX**: Asynchronous data updates

### Data Access
- **Data Access Layer (DAL)**: Structured data access patterns
- **Stored Procedures**: Database operations
- **Connection Pooling**: Optimized database connections

### Export Services
- **EPPlus**: Excel file generation
- **iTextSharp**: PDF generation
- **CSV Helper**: CSV file creation

## 📋 Prerequisites

Before running this application, ensure you have:

- **Visual Studio 2019/2022** or **Visual Studio Code**
- **.NET Framework 4.7.2** or higher
- **SQL Server 2016** or higher (Express edition is sufficient)
- **IIS Express** (included with Visual Studio)

## 🚀 Installation & Setup

### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/EmployeeService.git
cd EmployeeService
```

### 2. Database Setup
1. Open SQL Server Management Studio
2. Create a new database named `EmployeeServiceDB`
3. Run the database scripts in the `Database` folder:
   - `CreateTables.sql`
   - `InsertSampleData.sql`

### 3. Configure Connection String
1. Open `Web.config`
2. Update the connection string in the `<connectionStrings>` section:
```xml
<connectionStrings>
  <add name="EmployeeServiceConnection" 
       connectionString="Data Source=YOUR_SERVER;Initial Catalog=EmployeeServiceDB;Integrated Security=True;" 
       providerName="System.Data.SqlClient" />
</connectionStrings>
```

### 4. Build and Run
1. Open the solution in Visual Studio
2. Restore NuGet packages (if needed)
3. Build the solution (Ctrl+Shift+B)
4. Press F5 to run the application

## 👥 User Roles

### Admin User
- Full access to all features
- Can manage employees, departments, and positions
- Can export data in all formats
- Can view system logs and reports

### Regular User
- View-only access to employee data
- Limited search and filter capabilities
- No export permissions

## 📊 Database Schema

### Main Tables
- **Employees**: Core employee information
- **Departments**: Department definitions
- **Positions**: Job position definitions
- **Users**: System user accounts
- **AuditLog**: Change tracking and history

### Key Fields
- **EmployeeID**: Primary key for employees
- **DepartmentID**: Foreign key to departments
- **PositionID**: Foreign key to positions
- **EmploymentStatus**: Active/Inactive status
- **CreatedBy/ModifiedBy**: Audit trail fields

## 🔧 Configuration

### Web.config Settings
```xml
<appSettings>
  <add key="ExportPath" value="~/Exports/" />
  <add key="MaxFileSize" value="10485760" />
  <add key="AllowedFileTypes" value=".xlsx,.csv,.pdf" />
</appSettings>
```

### Session Management
- Session timeout: 30 minutes
- Authentication cookies enabled
- Secure session storage

## 📁 Project Structure

```
EmployeeService/
├── AdminEmployeeManagement.aspx    # Main employee management page
├── Login.aspx                     # User authentication
├── Dashboard.aspx                 # User dashboard
├── App_Code/
│   ├── DataAccess/               # Data access layer
│   ├── Models/                   # Entity models
│   └── Services/                 # Business logic services
├── Database/                     # SQL scripts
├── Exports/                      # Generated export files
└── Web.config                    # Application configuration
```

## 🔍 Usage Examples

### Adding a New Employee
1. Click "Add New Employee" button
2. Fill in required fields (Emirates ID, Name, Department, Position)
3. Complete optional fields as needed
4. Click "Save" to create the employee record

### Searching Employees
1. Use the search box for text-based searches
2. Select a department from the dropdown to filter by department
3. Choose status (Active/Inactive) to filter by employment status
4. Combine multiple filters for precise results

### Exporting Data
1. Select export format (Excel, CSV, PDF)
2. Choose export scope (All, Current Page, Search Results, Selected)
3. Click "Export" to generate and download the file

## 🐛 Troubleshooting

### Common Issues

**Database Connection Error**
- Verify SQL Server is running
- Check connection string in Web.config
- Ensure database exists and is accessible

**Export File Not Generated**
- Check folder permissions for Exports directory
- Verify sufficient disk space
- Ensure required NuGet packages are installed

**Search Not Working**
- Clear browser cache
- Check JavaScript console for errors
- Verify AJAX UpdatePanel configuration

### Debug Mode
Enable debug logging by adding to Web.config:
```xml
<system.web>
  <compilation debug="true" />
</system.web>
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Authors

- **Your Name** - *Initial work* - [YourGitHub](https://github.com/yourusername)

## 🙏 Acknowledgments

- Bootstrap team for the responsive UI framework
- EPPlus developers for Excel export functionality
- iTextSharp team for PDF generation capabilities
- Microsoft for ASP.NET Web Forms framework

## 📞 Support

For support and questions:
- Create an issue in the GitHub repository
- Contact: your.email@example.com
- Documentation: [Wiki Link]

---

**Note**: This application is designed for internal HR use and should be deployed in a secure environment with proper authentication and authorization controls.
