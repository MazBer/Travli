# PowerShell script to update version and build date before building
# Usage: .\update_version.ps1

$pubspecPath = "pubspec.yaml"
$buildDate = Get-Date -Format "yyyy-MM-dd"

Write-Host "Updating build information..." -ForegroundColor Green
Write-Host "Build Date: $buildDate" -ForegroundColor Cyan

# Read pubspec.yaml
$content = Get-Content $pubspecPath -Raw

# Update description with build date
$content = $content -replace 'description: ".*"', "description: `"Smart Travel Route Planner - Visit more, travel less | Build: $buildDate`""

# Write back
Set-Content -Path $pubspecPath -Value $content

Write-Host "✓ Updated pubspec.yaml with build date" -ForegroundColor Green
Write-Host ""
Write-Host "Now run: flutter build apk --release" -ForegroundColor Yellow
