rem Post Steps for Boxstarter Bootstrap Windows 10
powershell.exe -ExecutionPolicy Bypass -Command ".\boxstarter\Complete-Bootstrap.ps1"
pause
powershell.exe -ExecutionPolicy Bypass -Command ".\boxstarter\Configure-SublimeConfig.ps1"
pause
powershell.exe -ExecutionPolicy Bypass -Command ".\boxstarter\Configure-PowerShellProfile.ps1"
pause
powershell.exe -ExecutionPolicy Bypass -Command ".\boxstarter\Install-Modules.ps1"
