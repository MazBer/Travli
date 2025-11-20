# PowerShell script to build APK with automatic version increment
# Usage: .\build_apk.ps1

Write-Host "`n=== Travli APK Build Script ===" -ForegroundColor Cyan
Write-Host ""

# Ask user for build type
Write-Host "Select build type:" -ForegroundColor Yellow
Write-Host "  1. Release APK" -ForegroundColor White
Write-Host "  2. Debug APK" -ForegroundColor White
Write-Host "  3. Both (Release + Debug)" -ForegroundColor White
Write-Host "  4. Release APK + GitHub Release" -ForegroundColor Green
Write-Host "  5. Debug APK + GitHub Release" -ForegroundColor Green
Write-Host "  6. Both (Release + Debug) + GitHub Release" -ForegroundColor Green
Write-Host ""
$choice = Read-Host "Enter your choice (1-6)"

$buildRelease = $false
$buildDebug = $false

function Select-VersionType {
    Write-Host "" 
    Write-Host "Select version bump type:" -ForegroundColor Yellow
    Write-Host "  1. Patch (0.0.1 -> 0.0.2)" -ForegroundColor White
    Write-Host "  2. Minor (0.1.0 -> 0.2.0)" -ForegroundColor White
    Write-Host "  3. Major (1.0.0 -> 2.0.0)" -ForegroundColor White
    Write-Host ""
    $versionChoice = Read-Host "Enter your choice (1-3)"

    $versionType = switch ($versionChoice) {
        "1" { "patch" }
        "2" { "minor" }
        "3" { "major" }
        default {
            Write-Host "[ERROR] Invalid choice. Using 'patch' as default." -ForegroundColor Yellow
            "patch"
        }
    }
    return $versionType
}

switch ($choice) {
    "1" { $buildRelease = $true }
    "2" { $buildDebug = $true }
    "3" { 
        $buildRelease = $true
        $buildDebug = $true
    }
    "4" {
        $versionType = Select-VersionType
        Write-Host "" 
        Write-Host "[INFO] Will create GitHub release (RELEASE) with version type: $versionType" -ForegroundColor Cyan
        Write-Host "" 
        & .\create_release.ps1 -VersionType $versionType -BuildType release
        exit $LASTEXITCODE
    }
    "5" {
        $versionType = Select-VersionType
        Write-Host "" 
        Write-Host "[INFO] Will create GitHub release (DEBUG) with version type: $versionType" -ForegroundColor Cyan
        Write-Host "" 
        & .\create_release.ps1 -VersionType $versionType -BuildType debug
        exit $LASTEXITCODE
    }
    "6" {
        $versionType = Select-VersionType
        Write-Host "" 
        Write-Host "[INFO] Will create GitHub release (BOTH) with version type: $versionType" -ForegroundColor Cyan
        Write-Host "" 
        & .\create_release.ps1 -VersionType $versionType -BuildType both
        exit $LASTEXITCODE
    }
    default {
        Write-Host "[ERROR] Invalid choice. Please enter a number between 1 and 6." -ForegroundColor Red
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
