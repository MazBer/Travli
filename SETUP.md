# Travli - Setup Guide

## Prerequisites
- ✅ Flutter SDK 3.35.6 installed
- ✅ Dart 3.9.2 installed
- ⚠️ Developer Mode required for Windows

## Enable Developer Mode (Windows)

To run the app on Windows, you need to enable Developer Mode:

1. Press `Windows + I` to open Settings
2. Go to **Privacy & Security** → **For developers**
3. Turn on **Developer Mode**
4. Restart your terminal/IDE

**OR** run this command:
```powershell
start ms-settings:developers
```

## Running the App

### On Windows
```bash
flutter run -d windows
```

### On Android Emulator
```bash
flutter run -d android
```

### On Chrome (Web)
```bash
flutter run -d chrome
```

## Project Structure

```
lib/
├── core/
│   ├── constants/        # App colors, spacing, routes
│   ├── theme/            # App theme configuration
│   ├── navigation/       # Navigation logic
│   ├── services/         # Business logic services
│   └── utils/            # Utility functions
├── features/
│   ├── home/             # Home screen
│   ├── search/           # Search screen
│   ├── route/            # Route optimization
│   └── settings/         # Settings screen
├── models/               # Data models
├── repositories/         # Data layer
├── widgets/              # Reusable widgets
└── main.dart             # App entry point
```

## Dependencies

- **flutter_riverpod**: State management
- **go_router**: Navigation
- **sqflite**: Local database
- **dio**: HTTP client
- **google_fonts**: Typography
- **cached_network_image**: Image caching
- **hive**: Key-value storage
- **shared_preferences**: User preferences

## Next Steps

1. Enable Developer Mode
2. Run `flutter run -d windows`
3. Start implementing Phase 1 features

## Troubleshooting

### "Building with plugins requires symlink support"
- Enable Developer Mode in Windows Settings

### "No devices found"
- Make sure you have an emulator running or device connected
- Run `flutter devices` to see available devices

### Package errors
- Run `flutter pub get` to reinstall dependencies
- Run `flutter clean` then `flutter pub get`

## Development Commands

```bash
# Get dependencies
flutter pub get

# Run app
flutter run

# Run tests
flutter test

# Build release
flutter build windows

# Analyze code
flutter analyze

# Format code
dart format lib/
```
