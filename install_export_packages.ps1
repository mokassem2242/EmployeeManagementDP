# PowerShell script to install NuGet packages for export functionality
# Run this script from the project root directory

Write-Host "Installing NuGet packages for export functionality..." -ForegroundColor Green

# Install iTextSharp for PDF generation
nuget install iTextSharp -Version 5.5.13.3 -OutputDirectory packages

# Install EPPlus for Excel generation (older version for .NET Framework compatibility)
nuget install EPPlus -Version 4.5.3.3 -OutputDirectory packages

# Install ClosedXML as alternative for Excel (if EPPlus has licensing issues)
nuget install ClosedXML -Version 0.95.4 -OutputDirectory packages

Write-Host "NuGet packages installed successfully!" -ForegroundColor Green
Write-Host "Please ensure the packages are properly referenced in your project." -ForegroundColor Yellow 