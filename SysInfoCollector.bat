@echo off
setlocal
set "USERNAME=%USERNAME%"
set "OUTPUT=PC_%USERNAME%.txt"

echo ********************************************************
echo Collecte des informations du PC en cours...
echo ********************************************************

powershell -Command "$line = 'Hostname: ' + (hostname); Add-Content -Path '%OUTPUT%' -Value $line -Encoding UTF8"
echo Hostname ... Done
powershell -Command "$sys = Get-CimInstance Win32_ComputerSystem; Add-Content -Path '%OUTPUT%' -Value ('Model: ' + $sys.Manufacturer + ' ' + $sys.Model) -Encoding UTF8"
echo Constructeur ... Done
powershell -Command "$os = Get-CimInstance Win32_OperatingSystem; Add-Content -Path '%OUTPUT%' -Value ('OS : ' + $os.Caption + ' (' + $os.Version + ')') -Encoding UTF8"
echo OS ... Done
powershell -Command "$mac = cmd /c getmac /v; Add-Content -Path '%OUTPUT%' -Value 'Adresse MAC :' -Encoding UTF8; Add-Content -Path '%OUTPUT%' -Value $mac -Encoding UTF8"
powershell -Command "Get-NetAdapter | Select-Object Name, InterfaceDescription, MacAddress | Format-Table -AutoSize | Out-File -Append -Encoding UTF8 '%OUTPUT%'"
echo Mac ... Done
powershell -Command "$ip = cmd /c ipconfig; Add-Content -Path '%OUTPUT%' -Value 'Configuration IP :' -Encoding UTF8; Add-Content -Path '%OUTPUT%' -Value $ip -Encoding UTF8"
echo IP ... Done

echo ********************************************************
echo Fichier genere : %OUTPUT%
echo ********************************************************
pause
