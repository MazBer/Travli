# PowerShell script to create GitHub release with SemVer
# Usage: .\create_release.ps1 [patch|minor|major]
# Default: patch (0.0.1 -> 0.0.2)

param(
    [ValidateSet('patch', 'minor', 'major')]
    [string]$VersionType = 'patch'
)

Write-Host "`n=== Travli GitHub Release Creator ===" -ForegroundColor Cyan
Write-Host ""

# Check if gh CLI is installed
$ghInstalled = Get-Command gh -ErrorAction SilentlyContinue
if (-not $ghInstalled) {
    Write-Host "[ERROR] GitHub CLI (gh) is not installed." -ForegroundColor Red
    Write-Host "Install it from: https://cli.github.com/" -ForegroundColor Yellow
    Write-Host "Or run: winget install --id GitHub.cli" -ForegroundColor Yellow
    exit 1
}

# Check if user is authenticated
$authStatus = gh auth status 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Not authenticated with GitHub CLI" -ForegroundColor Red
    Write-Host "Run: gh auth login" -ForegroundColor Yellow
    exit 1
}

# Read current version from pubspec.yaml
$pubspecPath = "pubspec.yaml"
$content = Get-Content $pubspecPath -Raw

if ($content -match 'version:\s*(\d+)\.(\d+)\.(\d+)\+(\d+)') {
    $major = [int]$matches[1]
    $minor = [int]$matches[2]
    $patch = [int]$matches[3]
    $build = [int]$matches[4]
    
    $oldVersion = "$major.$minor.$patch"
    
    # Increment version based on type
    switch ($VersionType) {
        'major' {
            $major++
            $minor = 0
            $patch = 0
        }
        'minor' {
            $minor++
            $patch = 0
        }
        'patch' {
            $patch++
        }
    }
    
    # Always increment build number
    $build++
    
    $newVersion = "$major.$minor.$patch"
    $newFullVersion = "$newVersion+$build"
    
    Write-Host "[1/6] Version Update" -ForegroundColor Yellow
    Write-Host "  Type: $VersionType" -ForegroundColor Cyan
    Write-Host "  Old: $oldVersion+$($build-1)" -ForegroundColor White
    Write-Host "  New: $newFullVersion" -ForegroundColor Green
    Write-Host ""
    
    # Update pubspec.yaml
    $newContent = $content -replace "version:\s*\d+\.\d+\.\d+\+\d+", "version: $newFullVersion"
    Set-Content -Path $pubspecPath -Value $newContent -NoNewline
    
    Write-Host "[OK] Version updated in pubspec.yaml" -ForegroundColor Green
    Write-Host ""
    
} else {
    Write-Host "[ERROR] Could not parse version from pubspec.yaml" -ForegroundColor Red
    exit 1
}

# Step 2: Build APK
Write-Host "[2/6] Building Release APK..." -ForegroundColor Yellow
flutter pub get | Out-Null
flutter clean | Out-Null
flutter build apk --release

if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Build failed" -ForegroundColor Red
    exit 1
}

Write-Host "[OK] APK built successfully" -ForegroundColor Green
Write-Host ""

# Step 3: Get APK info
$apkPath = "build\app\outputs\flutter-apk\app-release.apk"
if (-not (Test-Path $apkPath)) {
    Write-Host "[ERROR] APK not found at $apkPath" -ForegroundColor Red
    exit 1
}

$apkSize = (Get-Item $apkPath).Length / 1MB
$apkSizeMB = [math]::Round($apkSize, 2)

Write-Host "[3/6] APK Information" -ForegroundColor Yellow
Write-Host "  Location: $apkPath" -ForegroundColor White
Write-Host "  Size: $apkSizeMB MB" -ForegroundColor Cyan
Write-Host ""

# Step 4: Commit changes
Write-Host "[4/6] Committing changes..." -ForegroundColor Yellow
git add pubspec.yaml pubspec.lock
git commit -m "chore: bump version to v$newVersion (build $build)"

if ($LASTEXITCODE -ne 0) {
    Write-Host "[WARNING] Nothing to commit or commit failed" -ForegroundColor Yellow
}

Write-Host "[OK] Changes committed" -ForegroundColor Green
Write-Host ""

# Step 5: Create Git tag
Write-Host "[5/6] Creating Git tag..." -ForegroundColor Yellow
$tagName = "v$newVersion"
git tag -a $tagName -m "Release version $newVersion (build $build)"

if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Failed to create tag" -ForegroundColor Red
    exit 1
}

Write-Host "[OK] Tag created: $tagName" -ForegroundColor Green
Write-Host ""

# Step 6: Push to GitHub
Write-Host "[6/6] Pushing to GitHub..." -ForegroundColor Yellow
git push origin master
git push origin $tagName

if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Failed to push to GitHub" -ForegroundColor Red
    exit 1
}

Write-Host "[OK] Pushed to GitHub" -ForegroundColor Green
Write-Host ""

# Step 7: Create GitHub Release
Write-Host "[7/7] Creating GitHub Release..." -ForegroundColor Yellow

# Check if previous version tag exists
$previousTag = "v$oldVersion"
$tagExists = git tag -l $previousTag
$changelogLine = ""

if ($tagExists) {
    $changelogLine = "`n---`n**Full Changelog**: https://github.com/MazBer/Travli/compare/$previousTag...$tagName"
}

# Generate release notes
$releaseNotes = @"
## 🚀 Travli v$newVersion

**Build Number:** $build
**APK Size:** $apkSizeMB MB
**Release Date:** $(Get-Date -Format "MMMM dd, yyyy")

### 📦 Download
Download the APK file below and install on your Android device.

### ✨ What's New
<!-- Add release notes here -->

### 📱 Installation
1. Download ``app-release.apk``
2. Enable "Install from Unknown Sources" in Android settings
3. Open the APK file and install

### 🔧 Technical Details
- **Version:** $newVersion
- **Build:** $build
- **Flutter:** 3.9.2
- **Minimum Android:** 5.0 (API 21)
- **Target Android:** 14 (API 34)$changelogLine
"@

# Create release with APK
gh release create $tagName `
    $apkPath `
    --title "v$newVersion" `
    --notes $releaseNotes `
    --latest

if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Failed to create GitHub release" -ForegroundColor Red
    exit 1
}

Write-Host "[OK] GitHub release created!" -ForegroundColor Green
Write-Host ""

# Success summary
Write-Host "=== Release Complete! ===" -ForegroundColor Green
Write-Host ""
Write-Host "Release Details:" -ForegroundColor Cyan
Write-Host "  Version: v$newVersion" -ForegroundColor White
Write-Host "  Build: $build" -ForegroundColor White
Write-Host "  Tag: $tagName" -ForegroundColor White
Write-Host "  APK Size: $apkSizeMB MB" -ForegroundColor White
Write-Host ""
Write-Host "View release at:" -ForegroundColor Yellow
Write-Host "  https://github.com/MazBer/Travli/releases/tag/$tagName" -ForegroundColor Cyan
Write-Host ""
Write-Host "Download APK at:" -ForegroundColor Yellow
Write-Host "  https://github.com/MazBer/Travli/releases/download/$tagName/app-release.apk" -ForegroundColor Cyan
Write-Host ""

exit 0
