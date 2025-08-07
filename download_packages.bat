@echo off
echo Downloading NuGet packages for export functionality...

REM Create packages directory if it doesn't exist
if not exist "packages" mkdir packages

REM Download iTextSharp
if not exist "packages\iTextSharp.5.5.13.3" (
    echo Downloading iTextSharp...
    powershell -Command "Invoke-WebRequest -Uri 'https://www.nuget.org/api/v2/package/iTextSharp/5.5.13.3' -OutFile 'packages\iTextSharp.5.5.13.3.nupkg'"
    powershell -Command "Expand-Archive -Path 'packages\iTextSharp.5.5.13.3.nupkg' -DestinationPath 'packages\iTextSharp.5.5.13.3' -Force"
    del "packages\iTextSharp.5.5.13.3.nupkg"
)

REM Download EPPlus
if not exist "packages\EPPlus.4.5.3.3" (
    echo Downloading EPPlus...
    powershell -Command "Invoke-WebRequest -Uri 'https://www.nuget.org/api/v2/package/EPPlus/4.5.3.3' -OutFile 'packages\EPPlus.4.5.3.3.nupkg'"
    powershell -Command "Expand-Archive -Path 'packages\EPPlus.4.5.3.3.nupkg' -DestinationPath 'packages\EPPlus.4.5.3.3' -Force"
    del "packages\EPPlus.4.5.3.3.nupkg"
)

REM Download ClosedXML
if not exist "packages\ClosedXML.0.95.4" (
    echo Downloading ClosedXML...
    powershell -Command "Invoke-WebRequest -Uri 'https://www.nuget.org/api/v2/package/ClosedXML/0.95.4' -OutFile 'packages\ClosedXML.0.95.4.nupkg'"
    powershell -Command "Expand-Archive -Path 'packages\ClosedXML.0.95.4.nupkg' -DestinationPath 'packages\ClosedXML.0.95.4' -Force"
    del "packages\ClosedXML.0.95.4.nupkg"
)

echo Package download completed!
pause 