$ErrorActionPreference = "Stop"
$downloadUrl = "https://github.com/Kezzxx/procesador-albaranes-data/releases/download/v1.0.0/ProcesadorDeAlbaranes-v2.0.10.zip"
$installDir = Join-Path $env:LOCALAPPDATA "ProcesadorDeAlbaranes"
$tempZip = Join-Path $env:TEMP "ProcesadorDeAlbaranes-v2.0.10.zip"
Write-Host "Descargando Procesador de Albaranes..."
Invoke-WebRequest -Uri $downloadUrl -OutFile $tempZip
if (Test-Path $installDir) { Remove-Item $installDir -Recurse -Force }
New-Item -Path $installDir -ItemType Directory -Force | Out-Null
Expand-Archive -Path $tempZip -DestinationPath $installDir -Force
Remove-Item $tempZip -Force -ErrorAction SilentlyContinue
foreach ($brand in @("ASLYX", "AUTODOC", "COMLINE", "JBM", "LAUSAN", "NTY", "SKV")) { New-Item -Path (Join-Path $installDir "Albaranes para procesar\$brand") -ItemType Directory -Force | Out-Null; New-Item -Path (Join-Path $installDir "Albaranes procesados\$brand") -ItemType Directory -Force | Out-Null }
New-Item -Path (Join-Path $installDir "data") -ItemType Directory -Force | Out-Null
$desktop = [Environment]::GetFolderPath("Desktop")
$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut((Join-Path $desktop "Procesador de Albaranes.lnk"))
$shortcut.TargetPath = Join-Path $installDir "ProcesadorDeAlbaranes.exe"
$shortcut.WorkingDirectory = $installDir
$shortcut.IconLocation = Join-Path $installDir "icon.ico"
$shortcut.Description = "Procesador de Albaranes"
$shortcut.Save()
Start-Process (Join-Path $installDir "ProcesadorDeAlbaranes.exe")
