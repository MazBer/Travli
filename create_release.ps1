# PowerShell script to create GitHub release with SemVer
# Usage: .\create_release.ps1 [patch|minor|major]
# Default: patch (0.0.1 -> 0.0.2)

param(
    [ValidateSet('patch', 'minor', 'major')]
    [string]$VersionType = 'patch',

    [ValidateSet('release', 'debug', 'both')]
    [string]$BuildType = 'release'
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

# Step 2: Build APK(s)
Write-Host "[2/6] Building APK(s)..." -ForegroundColor Yellow
flutter pub get | Out-Null
flutter clean | Out-Null

$releaseApkPath = "build\app\outputs\flutter-apk\app-release.apk"
$debugApkPath   = "build\app\outputs\flutter-apk\app-debug.apk"

if ($BuildType -eq 'release' -or $BuildType -eq 'both') {
    Write-Host "  - Building RELEASE APK..." -ForegroundColor Yellow
    flutter build apk --release
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[ERROR] Release build failed" -ForegroundColor Red
        exit 1
    }
}

if ($BuildType -eq 'debug' -or $BuildType -eq 'both') {
    Write-Host "  - Building DEBUG APK..." -ForegroundColor Yellow
    flutter build apk --debug
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[ERROR] Debug build failed" -ForegroundColor Red
        exit 1
    }
}

Write-Host "[OK] APK build step completed" -ForegroundColor Green
Write-Host ""

# Step 3: Get APK info (primary asset = release if available, else debug)
$primaryApkPath = if ($BuildType -eq 'debug') { $debugApkPath } else { $releaseApkPath }
if (-not (Test-Path $primaryApkPath)) {
    Write-Host "[ERROR] APK not found at $primaryApkPath" -ForegroundColor Red
    exit 1
}

$apkSize = (Get-Item $primaryApkPath).Length / 1MB
$apkSizeMB = [math]::Round($apkSize, 2)

Write-Host "[3/6] APK Information" -ForegroundColor Yellow
Write-Host "  Primary asset: $primaryApkPath" -ForegroundColor White
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

# Prepare default "What's new" text based on version type
switch ($VersionType) {
    'major' {
        $whatsNew = @(
            "- Major update with significant new features.",
            "- Includes breaking changes and large improvements."
        ) -join "`n"
    }
    'minor' {
        $whatsNew = @(
            "- New features and UX improvements.",
            "- Backward-compatible enhancements across the app."
        ) -join "`n"
    }
    'patch' {
        $whatsNew = @(
            "- Bug fixes and performance improvements.",
            "- Small stability and polish updates."
        ) -join "`n"
    }
}

# Generate release notes (short, English, focused on "What's new")
$releaseNotes = @"
Travli v$newVersion
Build: $build  |  APK size: $apkSizeMB MB  |  Date: $(Get-Date -Format "yyyy-MM-dd")

### What's new
$whatsNew

### Technical
- Flutter: 3.9.2
- Min Android: 5.0 (API 21)
- Target Android: 14 (API 34)$changelogLine
"@

# Write release notes to a temporary file to avoid quoting/escaping issues
$notesFile = Join-Path $env:TEMP "travli_release_notes_$newVersion.txt"
Set-Content -Path $notesFile -Value $releaseNotes -Encoding UTF8

# Decide which APK files to attach
$releaseAssets = @()
if ($BuildType -eq 'release' -or $BuildType -eq 'both') {
    if (Test-Path $releaseApkPath) {
        $releaseAssets += $releaseApkPath
    }
}
if ($BuildType -eq 'debug' -or $BuildType -eq 'both') {
    if (Test-Path $debugApkPath) {
        $releaseAssets += $debugApkPath
    }
}

try {
    # Create release with APK(s) using notes file
    gh release create $tagName `
        @releaseAssets `
        --title "v$newVersion" `
        --notes-file $notesFile `
        --latest
} finally {
    # Clean up temporary notes file if it exists
    if (Test-Path $notesFile) {
        Remove-Item $notesFile -ErrorAction SilentlyContinue
    }
}

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
