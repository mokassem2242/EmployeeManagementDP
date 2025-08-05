# Database Setup Instructions

## Problem
You're getting the error: "Cannot open database 'UAE_EmployeeDB' requested by the login. The login failed."

This happens because the database doesn't exist yet. The application is trying to connect to a database that hasn't been created.

## Solution

### Option 1: Run the Setup Script (Recommended)

1. **Using the batch file:**
   - Double-click `setup_database.bat` in the project root
   - This will automatically create the database and all required tables

2. **Using PowerShell:**
   - Right-click `setup_database.ps1` and select "Run with PowerShell"
   - Or open PowerShell and run: `.\setup_database.ps1`

3. **Manual execution:**
   - Open SQL Server Management Studio
   - Connect to your local SQL Server instance
   - Open the file `Database\Scripts\00_SetupDatabase.sql`
   - Execute the script

### Option 2: Use SQL Server Management Studio

1. Open SQL Server Management Studio
2. Connect to your local SQL Server instance (usually `localhost` or `.`)
3. Open the file `Database\Scripts\00_SetupDatabase.sql`
4. Click "Execute" or press F5 to run the script

### Option 3: Use sqlcmd (Command Line)

1. Open Command Prompt as Administrator
2. Navigate to your project directory
3. Run: `sqlcmd -S . -E -i "Database\Scripts\00_SetupDatabase.sql"`

## What the Setup Script Does

The setup script (`00_SetupDatabase.sql`) will:

1. **Create the database** `UAE_EmployeeDB` if it doesn't exist
2. **Create all required tables:**
   - Departments
   - Positions
   - Users
   - Employees
3. **Insert sample data** for testing
4. **Create stored procedures** used by the application

## Verification

After running the setup script, you can verify the database was created by:

1. Opening SQL Server Management Studio
2. Expanding the Databases folder
3. You should see `UAE_EmployeeDB` listed
4. Expand it to see the tables: Departments, Positions, Users, Employees

## Troubleshooting

### If you get permission errors:
- Make sure you're running as Administrator
- Ensure your Windows account has SQL Server access
- Try using SQL Server Authentication instead of Windows Authentication

### If SQL Server is not running:
- Open Services (services.msc)
- Find "SQL Server" or "MSSQLSERVER"
- Start the service if it's stopped

### If you can't connect to SQL Server:
- Make sure SQL Server is installed
- Check if SQL Server Browser service is running
- Try connecting to `localhost` instead of `.`

## Connection String

The application uses this connection string in `Web.config`:
```xml
<add name="UAE_EmployeeDB" 
     connectionString="Data Source=.;Initial Catalog=UAE_EmployeeDB;Integrated Security=True;" 
     providerName="System.Data.SqlClient" />
```

- `Data Source=.` means local SQL Server instance
- `Initial Catalog=UAE_EmployeeDB` specifies the database name
- `Integrated Security=True` uses Windows Authentication

## After Setup

Once the database is created, restart your application and the error should be resolved. The application will be able to connect to the database and retrieve data from the tables. 