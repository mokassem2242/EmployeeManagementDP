@echo off
echo Fixing Search Stored Procedure...
echo.

REM Check if SQL Server is available
sqlcmd -S localhost -E -Q "SELECT @@VERSION" >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: SQL Server is not accessible. Please make sure SQL Server is running.
    echo You can also try running the script manually in SQL Server Management Studio.
    pause
    exit /b 1
)

REM Run the fix script
echo Running database fix script...
sqlcmd -S localhost -E -i "Database\Scripts\06_FixSearchStoredProcedure.sql"

if %errorlevel% equ 0 (
    echo.
    echo Search functionality has been fixed successfully!
    echo The search now supports:
    echo - Employee Name (First Name, Last Name, Full Name)
    echo - Emirates ID
    echo - Work Email
    echo - Personal Email
    echo.
    echo You can now test the search functionality in the AdminEmployeeManagement.aspx page.
) else (
    echo.
    echo Error: Failed to update the stored procedure.
    echo Please check the error message above and try again.
)

pause 