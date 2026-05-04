#Requires -Version 5.1
$ErrorActionPreference = "Stop"

$python = Get-Command python -ErrorAction SilentlyContinue
if (-not $python) { $python = Get-Command python3 -ErrorAction SilentlyContinue }
if (-not $python) {
  Write-Host "Error: Python not found. Install from https://python.org" -ForegroundColor Red
  exit 1
}

Set-Location $PSScriptRoot

Write-Host "Starting Rewst JSON Formatter on http://localhost:8080" -ForegroundColor Cyan
Write-Host "Press Ctrl+C to stop."
Write-Host ""

& $python.Source -m http.server 8080 --bind 127.0.0.1
