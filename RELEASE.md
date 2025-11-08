# 🚀 Release Guide

This guide explains how to create releases for Travli using automated scripts.

## 📋 Prerequisites

### 1. Install GitHub CLI
```powershell
# Using winget (recommended)
winget install --id GitHub.cli

# Or download from: https://cli.github.com/
```

### 2. Authenticate with GitHub
```powershell
gh auth login
```

Follow the prompts to authenticate with your GitHub account.

### 3. Verify Installation
```powershell
gh auth status
```

You should see: `✓ Logged in to github.com as YourUsername`

---

## 🎯 Quick Start

### Option 1: Build Only (No Release)
```powershell
.\build_apk.ps1
# Choose option 1, 2, or 3
```

### Option 2: Build + GitHub Release (Recommended)
```powershell
.\build_apk.ps1
# Choose option 4
# Then select version bump type (patch/minor/major)
```

### Option 3: Direct Release Script
```powershell
# Patch version (0.0.1 -> 0.0.2)
.\create_release.ps1

# Minor version (0.1.0 -> 0.2.0)
.\create_release.ps1 -VersionType minor

# Major version (1.0.0 -> 2.0.0)
.\create_release.ps1 -VersionType major
```

---

## 📚 Semantic Versioning (SemVer)

Travli follows [Semantic Versioning 2.0.0](https://semver.org/):

```
MAJOR.MINOR.PATCH+BUILD

Example: 1.2.3+45
         │ │ │  │
         │ │ │  └─ Build number (auto-incremented)
         │ │ └──── Patch version (bug fixes)
         │ └─────── Minor version (new features, backward compatible)
         └────────── Major version (breaking changes)
```

### When to Bump Each Version:

#### **Patch (0.0.X)**
- Bug fixes
- Performance improvements
- Minor UI tweaks
- Documentation updates

**Example:** `0.0.1` → `0.0.2`

#### **Minor (0.X.0)**
- New features (backward compatible)
- New screens or functionality
- API additions
- Significant UI improvements

**Example:** `0.1.0` → `0.2.0`

#### **Major (X.0.0)**
- Breaking changes
- Complete redesign
- Major architecture changes
- Incompatible API changes

**Example:** `1.0.0` → `2.0.0`

---

## 🔄 Release Workflow

### Automated Process (Option 4)

When you choose **Option 4** in `build_apk.ps1`:

```
1. Select version bump type (patch/minor/major)
   ↓
2. Update version in pubspec.yaml
   ↓
3. Run flutter pub get
   ↓
4. Clean previous build
   ↓
5. Build release APK
   ↓
6. Commit version changes
   ↓
7. Create Git tag (e.g., v0.0.2)
   ↓
8. Push to GitHub (code + tag)
   ↓
9. Create GitHub Release with APK
   ↓
10. Success! Release is live
```

### What Gets Created:

1. **Git Tag:** `v0.0.2`
2. **GitHub Release:** With title, notes, and APK
3. **APK Asset:** `app-release.apk` attached to release
4. **Release Notes:** Auto-generated with version info

---

## 📝 Example Usage

### Scenario 1: Bug Fix Release
```powershell
PS> .\build_apk.ps1

=== Travli APK Build Script ===

Select build type:
  1. Release APK
  2. Debug APK
  3. Both (Release + Debug)
  4. Release APK + GitHub Release

Enter your choice (1-4): 4

Select version bump type:
  1. Patch (0.0.1 -> 0.0.2)
  2. Minor (0.1.0 -> 0.2.0)
  3. Major (1.0.0 -> 2.0.0)

Enter your choice (1-3): 1

[1/6] Version Update
  Type: patch
  Old: 0.0.1+12
  New: 0.0.2+13

[2/6] Building Release APK...
[OK] APK built successfully

[3/6] APK Information
  Location: build\app\outputs\flutter-apk\app-release.apk
  Size: 45.23 MB

[4/6] Committing changes...
[OK] Changes committed

[5/6] Creating Git tag...
[OK] Tag created: v0.0.2

[6/6] Pushing to GitHub...
[OK] Pushed to GitHub

[7/7] Creating GitHub Release...
[OK] GitHub release created!

=== Release Complete! ===

Release Details:
  Version: v0.0.2
  Build: 13
  Tag: v0.0.2
  APK Size: 45.23 MB

View release at:
  https://github.com/MazBer/Travli/releases/tag/v0.0.2

Download APK at:
  https://github.com/MazBer/Travli/releases/download/v0.0.2/app-release.apk
```

### Scenario 2: New Feature Release
```powershell
PS> .\create_release.ps1 -VersionType minor

# This will bump from 0.1.0 to 0.2.0
```

### Scenario 3: Major Version Release
```powershell
PS> .\create_release.ps1 -VersionType major

# This will bump from 1.0.0 to 2.0.0
```

---

## 🎨 Customizing Release Notes

After creating a release, you can edit it on GitHub:

1. Go to: https://github.com/MazBer/Travli/releases
2. Click "Edit" on your release
3. Update the "What's New" section
4. Add screenshots or additional info
5. Click "Update release"

### Example Release Notes:

```markdown
## 🚀 Travli v0.2.0

### ✨ What's New
- 🖼️ Wikipedia integration with place images
- 📝 Detailed place descriptions
- 🚶 Transport mode selection (Walk/Drive/Transit/Bike)
- 📍 Custom starting location support

### 🐛 Bug Fixes
- Fixed thumbnail loading for newly loaded places
- Improved loading performance
- Fixed transit mode limitations

### 🔧 Technical
- Added Wikipedia API service
- Implemented on-demand data loading
- Build automation scripts
```

---

## 🛠️ Troubleshooting

### Error: "GitHub CLI (gh) is not installed"
**Solution:**
```powershell
winget install --id GitHub.cli
```

### Error: "Not authenticated with GitHub CLI"
**Solution:**
```powershell
gh auth login
```

### Error: "Failed to push to GitHub"
**Solution:**
```powershell
# Check if you have push access
git remote -v

# Make sure you're on the right branch
git branch

# Try pushing manually
git push origin master
```

### Error: "Tag already exists"
**Solution:**
```powershell
# Delete the tag locally and remotely
git tag -d v0.0.2
git push origin :refs/tags/v0.0.2

# Then run the release script again
```

### Error: "Build failed"
**Solution:**
```powershell
# Clean and rebuild manually
flutter clean
flutter pub get
flutter build apk --release

# Check for errors in the output
```

---

## 📊 Version History

| Version | Type | Date | Description |
|---------|------|------|-------------|
| v0.0.1 | Initial | Oct 24, 2025 | Phase 1 MVP |
| v0.1.0 | Minor | Nov 8, 2025 | Phase 2 Features |
| v0.2.0 | Minor | TBD | Wikipedia Integration |

---

## 🔗 Useful Links

- **GitHub Releases:** https://github.com/MazBer/Travli/releases
- **GitHub CLI Docs:** https://cli.github.com/manual/
- **SemVer Spec:** https://semver.org/
- **Flutter Build Docs:** https://docs.flutter.dev/deployment/android

---

## 💡 Tips

1. **Always test before releasing:** Build and test the APK locally first
2. **Write good release notes:** Users appreciate knowing what changed
3. **Use patch for fixes:** Small bug fixes should be patch releases
4. **Use minor for features:** New features should be minor releases
5. **Save major for big changes:** Only use major when you have breaking changes
6. **Tag format:** Always use `v` prefix (e.g., `v0.0.2`, not `0.0.2`)
7. **Keep builds incremental:** Build number auto-increments, don't worry about it

---

## 📞 Support

If you encounter issues with the release scripts:

1. Check this guide first
2. Verify GitHub CLI is installed and authenticated
3. Check your internet connection
4. Ensure you have push access to the repository
5. Open an issue on GitHub if problems persist

---

**Happy Releasing! 🚀**
