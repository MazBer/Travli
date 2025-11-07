# PowerShell script to build APK with automatic version increment
# Usage: .\build_apk.ps1

Write-Host "`n=== Travli APK Build Script ===" -ForegroundColor Cyan
Write-Host ""

# Step 1: Increment version
Write-Host "[1/4] Incrementing version..." -ForegroundColor Yellow
& .\increment_version.ps1
if ($LASTEXITCODE -ne 0) {
    Write-Host "✗ Failed to increment version" -ForegroundColor Red
    exit 1
}
Write-Host ""

# Step 2: Get dependencies
Write-Host "[2/4] Getting Flutter dependencies..." -ForegroundColor Yellow
flutter pub get
if ($LASTEXITCODE -ne 0) {
    Write-Host "✗ Failed to get dependencies" -ForegroundColor Red
    exit 1
}
Write-Host "✓ Dependencies updated" -ForegroundColor Green
Write-Host ""

# Step 3: Clean build
Write-Host "[3/4] Cleaning previous build..." -ForegroundColor Yellow
flutter clean
if ($LASTEXITCODE -ne 0) {
    Write-Host "✗ Failed to clean" -ForegroundColor Red
    exit 1
}
Write-Host "✓ Build cleaned" -ForegroundColor Green
Write-Host ""

# Step 4: Build APK
Write-Host "[4/4] Building release APK..." -ForegroundColor Yellow
flutter build apk --release
if ($LASTEXITCODE -ne 0) {
    Write-Host "✗ Build failed" -ForegroundColor Red
    exit 1
}
Write-Host ""

# Success message
Write-Host "=== Build Complete! ===" -ForegroundColor Green
Write-Host ""
Write-Host "APK Location:" -ForegroundColor Cyan
Write-Host "  build\app\outputs\flutter-apk\app-release.apk" -ForegroundColor White
Write-Host ""

# Get APK size
$apkPath = "build\app\outputs\flutter-apk\app-release.apk"
if (Test-Path $apkPath) {
    $size = (Get-Item $apkPath).Length / 1MB
    Write-Host "APK Size: $([math]::Round($size, 2)) MB" -ForegroundColor Cyan
}

# Get current version
$pubspecContent = Get-Content "pubspec.yaml" -Raw
if ($pubspecContent -match 'version:\s*([\d.+]+)') {
    Write-Host "Version: $($matches[1])" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "To install on device:" -ForegroundColor Yellow
Write-Host '  adb install "build\app\outputs\flutter-apk\app-release.apk"' -ForegroundColor White
Write-Host ""
