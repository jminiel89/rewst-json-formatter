# -----------------------------------------------------------------------------
# install.ps1 — Installer for Jinja JSON Formatter (Windows)
#
# Downloads and sets up the tool in %USERPROFILE%\jinja-json-formatter.
# Re-running this script updates an existing installation.
#
# One-liner install (run in PowerShell):
#   irm https://raw.githubusercontent.com/jminiel89/jinja-json-formatter/main/install.ps1 | iex
# -----------------------------------------------------------------------------
#Requires -Version 5.1
$ErrorActionPreference = "Stop"

$repo       = "https://github.com/jminiel89/jinja-json-formatter"
$rawBase    = "$repo/raw/main"
$installDir = "$env:USERPROFILE\jinja-json-formatter"

Write-Host "Jinja JSON Formatter -- Installer" -ForegroundColor Cyan
Write-Host "----------------------------------"

# ── Step 1: Verify Python 3 is available ─────────────────────────────────────
# The tool uses Python's built-in HTTP server. No packages or pip needed.
# Try 'python' first (standard on most Windows installs), then 'python3'
# (used on some systems or when installed from the Microsoft Store).
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

# ── Step 2: Download or update the tool ──────────────────────────────────────
# Prefer git clone so future updates can be pulled with the same install command.
# Fall back to Invoke-WebRequest if git is not available.
$git = Get-Command git -ErrorAction SilentlyContinue

if (Test-Path "$installDir\.git") {
  # Already installed — pull latest changes only (fast-forward, no merges)
  Write-Host "Existing install found -- updating..."
  & git -C $installDir pull --ff-only

} elseif ($git) {
  # Git is available — clone the full repository
  Write-Host "Cloning repo..."
  & git clone "$repo.git" $installDir

} else {
  # Git not found — download only the required files via Invoke-WebRequest
  Write-Host "git not found -- downloading files directly..."
  New-Item -ItemType Directory -Force -Path $installDir | Out-Null
  $files = @("index.html", "template.json", "start.ps1")
  foreach ($file in $files) {
    Write-Host "  Downloading $file..."
    Invoke-WebRequest "$rawBase/$file" -OutFile "$installDir\$file"
  }
}

# ── Done ─────────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "Done. Installed to: $installDir" -ForegroundColor Green
Write-Host ""
Write-Host "To run:"
Write-Host "  powershell -File `"$installDir\start.ps1`""
Write-Host ""
Write-Host "Then open: http://localhost:8080"
