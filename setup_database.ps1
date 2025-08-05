# UAE Employee Database Setup Script
Write-Host "Setting up UAE Employee Database..." -ForegroundColor Green
Write-Host ""

# Check if SQL Server is available
try {
    $connection = New-Object System.Data.SqlClient.SqlConnection
    $connection.ConnectionString = "Data Source=.;Integrated Security=True;"
    $connection.Open()
    $connection.Close()
    Write-Host "SQL Server connection successful." -ForegroundColor Green
}
catch {
    Write-Host "Error connecting to SQL Server: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Please ensure SQL Server is running and accessible." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Alternative: Open SQL Server Management Studio and run the script manually:" -ForegroundColor Yellow
    Write-Host "Database\Scripts\00_SetupDatabase.sql" -ForegroundColor Cyan
    Read-Host "Press Enter to exit"
    exit 1
}

# Read the SQL script
$scriptPath = "Database\Scripts\00_SetupDatabase.sql"
if (-not (Test-Path $scriptPath)) {
    Write-Host "Error: SQL script not found at $scriptPath" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

$sqlScript = Get-Content $scriptPath -Raw

try {
    # Execute the SQL script
    Write-Host "Executing database setup script..." -ForegroundColor Yellow
    
    $connection = New-Object System.Data.SqlClient.SqlConnection
    $connection.ConnectionString = "Data Source=.;Integrated Security=True;"
    $connection.Open()
    
    $command = New-Object System.Data.SqlClient.SqlCommand
    $command.Connection = $connection
    $command.CommandText = $sqlScript
    $command.CommandTimeout = 300  # 5 minutes timeout
    
    $result = $command.ExecuteNonQuery()
    
    $connection.Close()
    
    Write-Host ""
    Write-Host "Database setup completed successfully!" -ForegroundColor Green
    Write-Host "You can now run the application." -ForegroundColor Green
}
catch {
    Write-Host ""
    Write-Host "Error setting up database: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host ""
    Write-Host "Alternative: Open SQL Server Management Studio and run the script manually:" -ForegroundColor Yellow
    Write-Host "Database\Scripts\00_SetupDatabase.sql" -ForegroundColor Cyan
}

Write-Host ""
Read-Host "Press Enter to exit" 