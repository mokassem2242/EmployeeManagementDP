# Export Feature Installation Guide

## Overview
The export feature has been implemented but requires NuGet packages to be installed for full functionality. Currently, the export buttons will show placeholder messages until the packages are installed.

## Required Packages
1. **iTextSharp** (v5.5.13.3) - For PDF export
2. **EPPlus** (v4.5.3.3) - For Excel export
3. **ClosedXML** (v0.95.4) - Alternative Excel library (backup)

## Installation Methods

### Method 1: Using Visual Studio Package Manager Console
1. Open the project in Visual Studio
2. Go to **Tools** > **NuGet Package Manager** > **Package Manager Console**
3. Run the following commands:
   ```
   Install-Package iTextSharp -Version 5.5.13.3
   Install-Package EPPlus -Version 4.5.3.3
   Install-Package ClosedXML -Version 0.95.4
   ```

### Method 2: Using Visual Studio NuGet Package Manager UI
1. Right-click on the project in Solution Explorer
2. Select **Manage NuGet Packages**
3. Go to **Browse** tab
4. Search and install each package:
   - Search for "iTextSharp" and install version 5.5.13.3
   - Search for "EPPlus" and install version 4.5.3.3
   - Search for "ClosedXML" and install version 0.95.4

### Method 3: Manual Download (if NuGet is not available)
1. Download the packages manually from NuGet.org:
   - [iTextSharp 5.5.13.3](https://www.nuget.org/packages/iTextSharp/5.5.13.3)
   - [EPPlus 4.5.3.3](https://www.nuget.org/packages/EPPlus/4.5.3.3)
   - [ClosedXML 0.95.4](https://www.nuget.org/packages/ClosedXML/0.95.4)
2. Extract the .nupkg files
3. Copy the DLL files to your project's `packages` folder
4. Ensure the references in `EmployeService.csproj` point to the correct paths

## After Installation

### 1. Update ExportService.cs
Once the packages are installed, you need to uncomment the full implementation in `App_Code/Services/ExportService.cs`:

1. Open `App_Code/Services/ExportService.cs`
2. Find the `ExportToPdf` method
3. Remove the temporary implementation and uncomment the full iTextSharp implementation
4. Find the `ExportToExcel` method
5. Remove the temporary implementation and uncomment the full EPPlus implementation

### 2. Add Required Using Statements
Add these using statements at the top of `ExportService.cs`:
```csharp
using iTextSharp.text;
using iTextSharp.text.pdf;
using OfficeOpenXml;
using System.Linq;
```

### 3. Build the Project
1. Build the project in Visual Studio
2. Ensure there are no compilation errors
3. Test the export functionality

## Database Setup
Make sure to run the database script to create the required stored procedure:
1. Open `Database/Scripts/07_CreateExportStoredProcedures.sql`
2. Execute the script in SQL Server Management Studio
3. This creates the `IntList` user-defined table type and `sp_Employee_GetByIds` stored procedure

## Testing the Export Feature
1. Log in as an administrator
2. Navigate to AdminEmployeeManagement.aspx
3. Try the export functionality:
   - Select "PDF" or "Excel" from the dropdown
   - Choose export scope (All, Current Page, Search Results, Selected)
   - Click "Export" or "Export Selected"

## Troubleshooting

### Common Issues:
1. **"Type 'iTextSharp' could not be found"** - Package not installed properly
2. **"Type 'OfficeOpenXml' could not be found"** - EPPlus package not installed
3. **Database errors** - Make sure the stored procedure script was executed
4. **Build errors** - Ensure all package references are correct in the .csproj file

### Solutions:
1. Reinstall the packages using one of the methods above
2. Clean and rebuild the solution
3. Check that the package references in `EmployeService.csproj` are correct
4. Verify the database script was executed successfully

## Current Status
- ✅ UI implementation complete
- ✅ Backend logic complete
- ✅ Database scripts ready
- ⏳ Package installation required
- ⏳ Full export implementation (currently showing placeholder messages)

## Next Steps
1. Install the required NuGet packages
2. Uncomment the full implementation in ExportService.cs
3. Build and test the project
4. Verify export functionality works as expected

## Support
If you encounter any issues during installation, please:
1. Check the troubleshooting section above
2. Verify all package references are correct
3. Ensure the database script was executed
4. Clean and rebuild the solution 