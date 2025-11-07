# PowerShell script to automatically increment build number in pubspec.yaml
# Usage: .\increment_version.ps1

$pubspecPath = "pubspec.yaml"

# Read the pubspec.yaml file
$content = Get-Content $pubspecPath -Raw

# Extract current version (format: major.minor.patch+build)
if ($content -match 'version:\s*(\d+)\.(\d+)\.(\d+)\+(\d+)') {
    $major = [int]$matches[1]
    $minor = [int]$matches[2]
    $patch = [int]$matches[3]
    $build = [int]$matches[4]
    
    # Increment build number
    $newBuild = $build + 1
    
    # Create new version string
    $oldVersion = "$major.$minor.$patch+$build"
    $newVersion = "$major.$minor.$patch+$newBuild"
    
    # Update the content
    $newContent = $content -replace "version:\s*$major\.$minor\.$patch\+$build", "version: $newVersion"
    
    # Write back to file
    Set-Content -Path $pubspecPath -Value $newContent -NoNewline
    
    Write-Host "✓ Version updated: $oldVersion → $newVersion" -ForegroundColor Green
    Write-Host "  Build number: $build → $newBuild" -ForegroundColor Cyan
} else {
    Write-Host "✗ Could not find version in pubspec.yaml" -ForegroundColor Red
    exit 1
}
