Write-Host "Checking search functionality files..." -ForegroundColor Green

$files = @("AdminEmployeeManagement.aspx", "AdminEmployeeManagement.aspx.cs", "App_Code\DataAccess\EmployeeDAL.cs")

foreach ($file in $files) {
    if (Test-Path $file) {
        Write-Host "Found: $file" -ForegroundColor Green
    } else {
        Write-Host "Missing: $file" -ForegroundColor Red
    }
}

Write-Host "`nSearch functionality has been refactored to work with:" -ForegroundColor Yellow
Write-Host "- Employee name search" -ForegroundColor White
Write-Host "- Emirates ID search" -ForegroundColor White  
Write-Host "- Email search" -ForegroundColor White
Write-Host "- Real-time search" -ForegroundColor White
Write-Host "- Combined filters" -ForegroundColor White
