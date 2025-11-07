# PowerShell script to build APK with automatic version increment
# Usage: .\build_apk.ps1

Write-Host "`n=== Travli APK Build Script ===" -ForegroundColor Cyan
Write-Host ""

# Ask user for build type
Write-Host "Select build type:" -ForegroundColor Yellow
Write-Host "  1. Release APK" -ForegroundColor White
Write-Host "  2. Debug APK" -ForegroundColor White
Write-Host "  3. Both (Release + Debug)" -ForegroundColor White
Write-Host ""
$choice = Read-Host "Enter your choice (1-3)"

$buildRelease = $false
$buildDebug = $false

switch ($choice) {
    "1" { $buildRelease = $true }
    "2" { $buildDebug = $true }
    "3" { 
        $buildRelease = $true
        $buildDebug = $true
    }
    default {
        Write-Host "[ERROR] Invalid choice. Please enter 1, 2, or 3." -ForegroundColor Red
        exit 1
    }
}

Write-Host ""

# Step 1: Increment version
Write-Host "[1/5] Incrementing version..." -ForegroundColor Yellow
& .\increment_version.ps1
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Failed to increment version" -ForegroundColor Red
    exit 1
}
Write-Host ""

# Step 2: Get dependencies
Write-Host "[2/5] Getting Flutter dependencies..." -ForegroundColor Yellow
flutter pub get
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Failed to get dependencies" -ForegroundColor Red
    exit 1
}
Write-Host "[OK] Dependencies updated" -ForegroundColor Green
Write-Host ""

# Step 3: Clean build
Write-Host "[3/5] Cleaning previous build..." -ForegroundColor Yellow
flutter clean
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Failed to clean" -ForegroundColor Red
    exit 1
}
Write-Host "[OK] Build cleaned" -ForegroundColor Green
Write-Host ""

# Step 4: Build Release APK
if ($buildRelease) {
    Write-Host "[4/5] Building RELEASE APK..." -ForegroundColor Yellow
    flutter build apk --release
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[ERROR] Release build failed" -ForegroundColor Red
        exit 1
    }
    Write-Host "[OK] Release APK built successfully" -ForegroundColor Green
    Write-Host ""
}

# Step 5: Build Debug APK
if ($buildDebug) {
    Write-Host "[5/5] Building DEBUG APK..." -ForegroundColor Yellow
    flutter build apk --debug
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[ERROR] Debug build failed" -ForegroundColor Red
        exit 1
    }
    Write-Host "[OK] Debug APK built successfully" -ForegroundColor Green
    Write-Host ""
}

# Success message
Write-Host "=== Build Complete! ===" -ForegroundColor Green
Write-Host ""

# Show APK locations and sizes
if ($buildRelease) {
    Write-Host "RELEASE APK:" -ForegroundColor Cyan
    Write-Host "  Location: build\app\outputs\flutter-apk\app-release.apk" -ForegroundColor White
    $apkPath = "build\app\outputs\flutter-apk\app-release.apk"
    if (Test-Path $apkPath) {
        $size = (Get-Item $apkPath).Length / 1MB
        Write-Host "  Size: $([math]::Round($size, 2)) MB" -ForegroundColor White
    }
    Write-Host ""
}

if ($buildDebug) {
    Write-Host "DEBUG APK:" -ForegroundColor Cyan
    Write-Host "  Location: build\app\outputs\flutter-apk\app-debug.apk" -ForegroundColor White
    $apkPath = "build\app\outputs\flutter-apk\app-debug.apk"
    if (Test-Path $apkPath) {
        $size = (Get-Item $apkPath).Length / 1MB
        Write-Host "  Size: $([math]::Round($size, 2)) MB" -ForegroundColor White
    }
    Write-Host ""
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
