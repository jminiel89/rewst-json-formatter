#Requires -Version 5.1
$ErrorActionPreference = "Stop"

$repo      = "https://github.com/jminiel89/rewst-json-formatter"
$rawBase   = "$repo/raw/main"
$installDir = "$env:USERPROFILE\rewst-json-formatter"

Write-Host "Rewst JSON Formatter -- Installer" -ForegroundColor Cyan
Write-Host "----------------------------------"

# Check Python
$python = Get-Command python -ErrorAction SilentlyContinue
if (-not $python) {
  $python = Get-Command python3 -ErrorAction SilentlyContinue
}
if (-not $python) {
  Write-Host ""
  Write-Host "Error: Python not found." -ForegroundColor Red
  Write-Host "Install Python 3 from https://python.org"
  Write-Host "  or run: winget install Python.Python.3.12"
  exit 1
}

$pythonExe = $python.Source
Write-Host "Found: $(&$pythonExe --version)"

# Clone or update
$git = Get-Command git -ErrorAction SilentlyContinue

if (Test-Path "$installDir\.git") {
  Write-Host "Existing install found -- updating..."
  & git -C $installDir pull --ff-only
} elseif ($git) {
  Write-Host "Cloning repo..."
  & git clone "$repo.git" $installDir
} else {
  Write-Host "git not found -- downloading files directly..."
  New-Item -ItemType Directory -Force -Path $installDir | Out-Null
  $files = @("index.html", "rewst-http-template.json", "start.ps1")
  foreach ($file in $files) {
    Write-Host "  Downloading $file..."
    Invoke-WebRequest "$rawBase/$file" -OutFile "$installDir\$file"
  }
}

Write-Host ""
Write-Host "Done. Installed to: $installDir" -ForegroundColor Green
Write-Host ""
Write-Host "To run:"
Write-Host "  powershell -File `"$installDir\start.ps1`""
Write-Host ""
Write-Host "Then open: http://localhost:8080"
