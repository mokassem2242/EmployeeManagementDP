Write-Host "Fixing Search Stored Procedure..." -ForegroundColor Green
Write-Host ""

# Check if SQL Server is available
try {
    $result = sqlcmd -S localhost -E -Q "SELECT @@VERSION" 2>$null
    if ($LASTEXITCODE -ne 0) {
        throw "SQL Server not accessible"
    }
} catch {
    Write-Host "Error: SQL Server is not accessible. Please make sure SQL Server is running." -ForegroundColor Red
    Write-Host "You can also try running the script manually in SQL Server Management Studio." -ForegroundColor Yellow
    Read-Host "Press Enter to continue"
    exit 1
}

# Run the fix script
Write-Host "Running database fix script..." -ForegroundColor Yellow
$scriptPath = Join-Path $PSScriptRoot "Database\Scripts\06_FixSearchStoredProcedure.sql"
sqlcmd -S localhost -E -i $scriptPath

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "Search functionality has been fixed successfully!" -ForegroundColor Green
    Write-Host "The search now supports:" -ForegroundColor Cyan
    Write-Host "- Employee Name (First Name, Last Name, Full Name)" -ForegroundColor White
    Write-Host "- Emirates ID" -ForegroundColor White
    Write-Host "- Work Email" -ForegroundColor White
    Write-Host "- Personal Email" -ForegroundColor White
    Write-Host ""
    Write-Host "You can now test the search functionality in the AdminEmployeeManagement.aspx page." -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "Error: Failed to update the stored procedure." -ForegroundColor Red
    Write-Host "Please check the error message above and try again." -ForegroundColor Yellow
}

Read-Host "Press Enter to continue" 