using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web;

namespace EmployeService
{
    public static class DatabaseInitializer
    {
        private static bool _isInitialized = false;
        private static readonly object _lock = new object();

        public static void InitializeDatabase()
        {
            lock (_lock)
            {
                if (_isInitialized) return;

                try
                {
                    // Get connection string
                    string connectionString = ConfigurationManager.ConnectionStrings["UAE_EmployeeDB"] != null ? ConfigurationManager.ConnectionStrings["UAE_EmployeeDB"].ConnectionString : null;
                    if (string.IsNullOrEmpty(connectionString))
                    {
                        throw new Exception("Connection string 'UAE_EmployeeDB' not found in Web.config");
                    }

                    // First, check if database exists
                    if (!DatabaseExists())
                    {
                        System.Diagnostics.Debug.WriteLine("Database does not exist. Creating database...");
                        CreateDatabase();
                    }

                    // Now run the setup script
                    string setupScriptPath = HttpContext.Current.Server.MapPath("~/Database/Scripts/00_SetupDatabase.sql");
                    if (File.Exists(setupScriptPath))
                    {
                        try
                        {
                            ExecuteScriptWithDatabase(setupScriptPath);
                            _isInitialized = true;
                            System.Diagnostics.Debug.WriteLine("Database initialized successfully using setup script.");
                            return;
                        }
                        catch (Exception ex)
                        {
                            System.Diagnostics.Debug.WriteLine(string.Format("Setup script failed, trying individual scripts: {0}", ex.Message));
                        }
                    }

                    // Fallback to individual scripts if setup script fails
                    string scriptsPath = HttpContext.Current.Server.MapPath("~/Database/Scripts/");
                    
                    // Run scripts in order (these scripts should work with the database connection)
                    ExecuteScriptWithDatabase(Path.Combine(scriptsPath, "02_CreateTables.sql"));
                    ExecuteScriptWithDatabase(Path.Combine(scriptsPath, "03_InsertSampleData.sql"));
                    ExecuteScriptWithDatabase(Path.Combine(scriptsPath, "04_CreateStoredProcedures.sql"));

                    _isInitialized = true;
                    System.Diagnostics.Debug.WriteLine("Database initialized successfully using individual scripts.");
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine(string.Format("Database initialization failed: {0}", ex.Message));
                    
                    // Final fallback: Create database structure inline
                    try
                    {
                        System.Diagnostics.Debug.WriteLine("Attempting inline database creation...");
                        CreateDatabaseInline();
                        _isInitialized = true;
                        System.Diagnostics.Debug.WriteLine("Database initialized successfully using inline creation.");
                    }
                    catch (Exception inlineEx)
                    {
                        System.Diagnostics.Debug.WriteLine(string.Format("Inline database creation failed: {0}", inlineEx.Message));
                        // Don't throw the exception to prevent application startup failure
                    }
                }
            }
        }

        private static bool DatabaseExists()
        {
            try
            {
                // Connect to master database to check if our database exists
                string masterConnectionString = "Data Source=.;Initial Catalog=master;Integrated Security=True;";
                using (SqlConnection connection = new SqlConnection(masterConnectionString))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand(
                        "SELECT COUNT(*) FROM sys.databases WHERE name = 'UAE_EmployeeDB'", connection))
                    {
                        int count = (int)command.ExecuteScalar();
                        return count > 0;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(string.Format("Error checking if database exists: {0}", ex.Message));
                return false;
            }
        }

        private static void CreateDatabase()
        {
            try
            {
                // Connect to master database to create our database
                string masterConnectionString = "Data Source=.;Initial Catalog=master;Integrated Security=True;";
                using (SqlConnection connection = new SqlConnection(masterConnectionString))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand("CREATE DATABASE UAE_EmployeeDB", connection))
                    {
                        command.ExecuteNonQuery();
                        System.Diagnostics.Debug.WriteLine("Database UAE_EmployeeDB created successfully.");
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(string.Format("Error creating database: {0}", ex.Message));
                throw;
            }
        }

        private static void CreateDatabaseInline()
        {
            string dbConnectionString = "Data Source=.;Initial Catalog=UAE_EmployeeDB;Integrated Security=True;";
            using (SqlConnection connection = new SqlConnection(dbConnectionString))
            {
                connection.Open();

                // Create tables
                string[] createTableCommands = {
                    @"IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Departments]') AND type in (N'U'))
                    BEGIN
                        CREATE TABLE Departments (
                            DepartmentID INT IDENTITY(1,1) PRIMARY KEY,
                            DepartmentName NVARCHAR(100) NOT NULL,
                            DepartmentCode NVARCHAR(20),
                            Description NVARCHAR(500),
                            IsActive BIT DEFAULT 1,
                            CreatedDate DATETIME DEFAULT GETDATE(),
                            ModifiedDate DATETIME DEFAULT GETDATE()
                        )
                    END",
                    
                    @"IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Positions]') AND type in (N'U'))
                    BEGIN
                        CREATE TABLE Positions (
                            PositionID INT IDENTITY(1,1) PRIMARY KEY,
                            PositionTitle NVARCHAR(100) NOT NULL,
                            PositionCode NVARCHAR(20),
                            Description NVARCHAR(500),
                            IsActive BIT DEFAULT 1,
                            CreatedDate DATETIME DEFAULT GETDATE(),
                            ModifiedDate DATETIME DEFAULT GETDATE()
                        )
                    END",
                    
                    @"IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND type in (N'U'))
                    BEGIN
                        CREATE TABLE Users (
                            UserID INT IDENTITY(1,1) PRIMARY KEY,
                            Username NVARCHAR(50) NOT NULL UNIQUE,
                            PasswordHash NVARCHAR(255) NOT NULL,
                            Email NVARCHAR(100),
                            IsActive BIT DEFAULT 1,
                            CreatedDate DATETIME DEFAULT GETDATE(),
                            ModifiedDate DATETIME DEFAULT GETDATE()
                        )
                    END",
                    
                    @"IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Employees]') AND type in (N'U'))
                    BEGIN
                        CREATE TABLE Employees (
                            EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
                            EmiratesID NVARCHAR(20) UNIQUE,
                            PassportNumber NVARCHAR(20),
                            FirstName NVARCHAR(50) NOT NULL,
                            LastName NVARCHAR(50) NOT NULL,
                            Nationality NVARCHAR(50),
                            DateOfBirth DATE,
                            Gender NVARCHAR(10),
                            WorkEmail NVARCHAR(100),
                            PersonalEmail NVARCHAR(100),
                            WorkPhone NVARCHAR(20),
                            PersonalPhone NVARCHAR(20),
                            Emirates NVARCHAR(50),
                            City NVARCHAR(50),
                            District NVARCHAR(50),
                            HireDate DATE,
                            ContractType NVARCHAR(50),
                            EmploymentStatus NVARCHAR(20),
                            DepartmentID INT,
                            PositionID INT,
                            ManagerID INT,
                            SalaryGrade NVARCHAR(20),
                            IsActive BIT DEFAULT 1,
                            CreatedBy INT,
                            CreatedDate DATETIME DEFAULT GETDATE(),
                            ModifiedBy INT,
                            ModifiedDate DATETIME DEFAULT GETDATE(),
                            FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID),
                            FOREIGN KEY (PositionID) REFERENCES Positions(PositionID),
                            FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID),
                            FOREIGN KEY (CreatedBy) REFERENCES Users(UserID),
                            FOREIGN KEY (ModifiedBy) REFERENCES Users(UserID)
                        )
                    END"
                };

                // Execute create table commands
                foreach (string command in createTableCommands)
                {
                    using (SqlCommand sqlCommand = new SqlCommand(command, connection))
                    {
                        sqlCommand.ExecuteNonQuery();
                    }
                }

                // Insert sample data
                string[] insertCommands = {
                    @"IF NOT EXISTS (SELECT * FROM Departments WHERE DepartmentName = 'Information Technology')
                    BEGIN
                        INSERT INTO Departments (DepartmentName, DepartmentCode, Description) VALUES
                        ('Information Technology', 'IT', 'IT Department for UAE Government'),
                        ('Human Resources', 'HR', 'Human Resources Department'),
                        ('Finance', 'FIN', 'Finance and Accounting Department'),
                        ('Operations', 'OPS', 'Operations Department'),
                        ('Marketing', 'MKT', 'Marketing and Communications Department')
                    END",
                    
                    @"IF NOT EXISTS (SELECT * FROM Positions WHERE PositionTitle = 'Software Developer')
                    BEGIN
                        INSERT INTO Positions (PositionTitle, PositionCode, Description) VALUES
                        ('Software Developer', 'SD001', 'Software Development Position'),
                        ('Senior Developer', 'SD002', 'Senior Software Development Position'),
                        ('Project Manager', 'PM001', 'Project Management Position'),
                        ('HR Manager', 'HR001', 'Human Resources Management Position'),
                        ('Finance Analyst', 'FA001', 'Financial Analysis Position'),
                        ('Operations Manager', 'OM001', 'Operations Management Position'),
                        ('Marketing Specialist', 'MS001', 'Marketing and Communications Position')
                    END",
                    
                    @"IF NOT EXISTS (SELECT * FROM Users WHERE Username = 'admin')
                    BEGIN
                        INSERT INTO Users (Username, PasswordHash, Email) VALUES
                        ('admin', 'admin123', 'admin@uae.gov.ae'),
                        ('user1', 'user123', 'user1@uae.gov.ae'),
                        ('user2', 'user123', 'user2@uae.gov.ae')
                    END"
                };

                // Execute insert commands
                foreach (string command in insertCommands)
                {
                    using (SqlCommand sqlCommand = new SqlCommand(command, connection))
                    {
                        sqlCommand.ExecuteNonQuery();
                    }
                }

                // Create stored procedures
                string[] storedProcedureCommands = {
                    @"IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Department_GetAll]') AND type in (N'P', N'PC'))
                    BEGIN
                        EXEC('CREATE PROCEDURE sp_Department_GetAll AS BEGIN SELECT 1 END')
                    END",
                    
                    @"IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Department_GetAll]') AND type in (N'P', N'PC'))
                    BEGIN
                        DROP PROCEDURE sp_Department_GetAll
                    END",
                    
                    @"CREATE PROCEDURE sp_Department_GetAll
                    AS
                    BEGIN
                        SELECT DepartmentID, DepartmentName, DepartmentCode, Description, IsActive
                        FROM Departments
                        WHERE IsActive = 1
                        ORDER BY DepartmentName
                    END",
                    
                    @"IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Position_GetAll]') AND type in (N'P', N'PC'))
                    BEGIN
                        EXEC('CREATE PROCEDURE sp_Position_GetAll AS BEGIN SELECT 1 END')
                    END",
                    
                    @"IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Position_GetAll]') AND type in (N'P', N'PC'))
                    BEGIN
                        DROP PROCEDURE sp_Position_GetAll
                    END",
                    
                    @"CREATE PROCEDURE sp_Position_GetAll
                    AS
                    BEGIN
                        SELECT PositionID, PositionTitle, PositionCode, Description, IsActive
                        FROM Positions
                        WHERE IsActive = 1
                        ORDER BY PositionTitle
                    END",
                    
                    @"IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Employee_GetAll]') AND type in (N'P', N'PC'))
                    BEGIN
                        EXEC('CREATE PROCEDURE sp_Employee_GetAll AS BEGIN SELECT 1 END')
                    END",
                    
                    @"IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Employee_GetAll]') AND type in (N'P', N'PC'))
                    BEGIN
                        DROP PROCEDURE sp_Employee_GetAll
                    END",
                    
                    @"CREATE PROCEDURE sp_Employee_GetAll
                    AS
                    BEGIN
                        SELECT e.*, d.DepartmentName, p.PositionTitle, m.FirstName + ' ' + m.LastName as ManagerName
                        FROM Employees e
                        LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID
                        LEFT JOIN Positions p ON e.PositionID = p.PositionID
                        LEFT JOIN Employees m ON e.ManagerID = m.EmployeeID
                        WHERE e.IsActive = 1
                        ORDER BY e.EmployeeID DESC
                    END"
                };

                // Execute stored procedure commands
                foreach (string command in storedProcedureCommands)
                {
                    using (SqlCommand sqlCommand = new SqlCommand(command, connection))
                    {
                        sqlCommand.ExecuteNonQuery();
                    }
                }
            }
        }

        private static void ExecuteScript(string connectionString, string scriptPath)
        {
            if (!File.Exists(scriptPath))
            {
                throw new FileNotFoundException(string.Format("Script file not found: {0}", scriptPath));
            }

            string scriptContent = File.ReadAllText(scriptPath);
            
            // Split the script into individual commands
            string[] commands = scriptContent.Split(new[] { "GO" }, StringSplitOptions.RemoveEmptyEntries);

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                foreach (string command in commands)
                {
                    string trimmedCommand = command.Trim();
                    if (!string.IsNullOrEmpty(trimmedCommand))
                    {
                        using (SqlCommand sqlCommand = new SqlCommand(trimmedCommand, connection))
                        {
                            try
                            {
                                sqlCommand.ExecuteNonQuery();
                            }
                            catch (Exception ex)
                            {
                                // Log the error but continue with other commands
                                System.Diagnostics.Debug.WriteLine(string.Format("Error executing command: {0}", ex.Message));
                                System.Diagnostics.Debug.WriteLine(string.Format("Command: {0}", trimmedCommand));
                            }
                        }
                    }
                }
            }
        }

        private static void ExecuteScriptWithDatabase(string scriptPath)
        {
            if (!File.Exists(scriptPath))
            {
                throw new FileNotFoundException(string.Format("Script file not found: {0}", scriptPath));
            }

            string scriptContent = File.ReadAllText(scriptPath);
            
            // Split the script into individual commands
            string[] commands = scriptContent.Split(new[] { "GO" }, StringSplitOptions.RemoveEmptyEntries);

            // Connect to the specific database
            string dbConnectionString = "Data Source=.;Initial Catalog=UAE_EmployeeDB;Integrated Security=True;";
            using (SqlConnection connection = new SqlConnection(dbConnectionString))
            {
                connection.Open();

                foreach (string command in commands)
                {
                    string trimmedCommand = command.Trim();
                    if (!string.IsNullOrEmpty(trimmedCommand))
                    {
                        using (SqlCommand sqlCommand = new SqlCommand(trimmedCommand, connection))
                        {
                            try
                            {
                                sqlCommand.ExecuteNonQuery();
                            }
                            catch (Exception ex)
                            {
                                // Log the error but continue with other commands
                                System.Diagnostics.Debug.WriteLine(string.Format("Error executing command: {0}", ex.Message));
                                System.Diagnostics.Debug.WriteLine(string.Format("Command: {0}", trimmedCommand));
                            }
                        }
                    }
                }
            }
        }

        public static bool IsDatabaseInitialized()
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["UAE_EmployeeDB"] != null ? ConfigurationManager.ConnectionStrings["UAE_EmployeeDB"].ConnectionString : null;
                if (string.IsNullOrEmpty(connectionString))
                    return false;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    
                    // Check if the Employees table exists
                    using (SqlCommand command = new SqlCommand(
                        "SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Employees'", connection))
                    {
                        int count = (int)command.ExecuteScalar();
                        return count > 0;
                    }
                }
            }
            catch
            {
                return false;
            }
        }
    }
} 