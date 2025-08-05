@echo off
echo Setting up UAE Employee Database...
echo.

REM Check if sqlcmd is available
sqlcmd -? >nul 2>&1
if %errorlevel% neq 0 (
    echo SQLCMD not found. Please run the script manually in SQL Server Management Studio.
    echo Open SQL Server Management Studio and run the script: Database\Scripts\00_SetupDatabase.sql
    echo.
    pause
    exit /b 1
)

REM Run the database setup script
echo Running database setup script...
sqlcmd -S . -E -i "Database\Scripts\00_SetupDatabase.sql"

if %errorlevel% equ 0 (
    echo.
    echo Database setup completed successfully!
    echo You can now run the application.
) else (
    echo.
    echo Database setup failed. Please check the error messages above.
    echo.
    echo Alternative: Open SQL Server Management Studio and run the script manually:
    echo Database\Scripts\00_SetupDatabase.sql
)

echo.
pause 