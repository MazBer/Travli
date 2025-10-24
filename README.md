# Travli 🌍

**Smart Travel Route Planner - Visit more, travel less**

An intelligent mobile app that optimizes your travel routes using Ant Colony Optimization algorithm. Select places you want to visit in a city, and Travli calculates the most efficient route to save time and maximize your experience.

[![Flutter](https://img.shields.io/badge/Flutter-3.9.2-blue.svg)](https://flutter.dev/)
[![Material 3](https://img.shields.io/badge/Material-3-green.svg)](https://m3.material.io/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## ✨ Features

### 🎯 Core Features (Phase 1 - ✅ Completed)
- **Smart City Search** - Find cities worldwide with Nominatim API
- **Place Discovery** - Browse tourist attractions, museums, landmarks
- **Route Optimization** - Ant Colony Optimization algorithm for efficient routes
- **Offline Support** - Works without internet for 10 major cities
- **Google Maps Integration** - Open optimized routes directly in Maps
- **Search History** - Quick access to recent searches
- **Multi-language** - 5 languages (EN, TR, DE, ES, FR)

### 🎨 Design
- **Material You** - Dynamic color theming from wallpaper (Android 12+)
- **10 Color Themes** - Choose your preferred color scheme
- **Dark Mode** - Light, Dark, and System themes
- **Modern UI** - Material 3 components and smooth animations
- **Responsive** - Adapts to different screen sizes

### 🌍 Localization
- 🇬🇧 English
- 🇹🇷 Türkçe
- 🇩🇪 Deutsch
- 🇪🇸 Español
- 🇫🇷 Français

### 🔥 Coming Soon (Phase 2)
- **Starting Location Options** - Choose current location or custom address
- **Route Type Selection** - Walking 🚶, Driving 🚗, Transit 🚌, Cycling 🚴
- **Save Routes** - Save favorite routes for later
- **Share Routes** - Share with friends and family
- **Expanded Offline** - 50+ cities available offline

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.9.2 or higher
- Dart SDK 3.0.0 or higher
- Android Studio / VS Code
- Android SDK (for Android) or Xcode (for iOS)

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/travli.git
cd travli
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Generate localization files**
```bash
flutter gen-l10n
```

4. **Run the app**
```bash
flutter run
```

### Build for Production

**Android:**
```bash
flutter build apk --release
# or for app bundle
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

## 📱 Screenshots

*Coming soon*

## 🏗️ Architecture

### Tech Stack
- **Framework:** Flutter 3.9.2
- **State Management:** Riverpod 2.6.1
- **Database:** SQLite (sqflite)
- **HTTP Client:** Dio 5.4.0
- **Localization:** Flutter i18n (intl)
- **Theming:** Material 3 + Dynamic Color

### Project Structure
```
lib/
├── core/
│   ├── constants/       # App constants (colors, spacing, etc.)
│   ├── navigation/      # Navigation logic
│   ├── providers/       # Riverpod providers
│   ├── services/        # Business logic services
│   └── theme/          # Theme configuration
├── features/
│   ├── home/           # Home screen
│   ├── search/         # City search
│   ├── places/         # Places display
│   └── settings/       # App settings
├── models/             # Data models
├── repositories/       # Data access layer
├── l10n/              # Localization files
└── main.dart          # App entry point
```

### APIs Used
- **Nominatim (OpenStreetMap)** - City search and geocoding
- **Overpass API** - Places and POI data (3 fallback servers)
- **Google Maps** - Route visualization and navigation

### Network Resilience
- Multiple API fallback servers
- Offline database for major cities
- Graceful degradation when APIs unavailable
- DNS error handling

## 🎨 Theming

Travli supports Material You dynamic theming:

1. **Material You (Android 12+)** - Colors from wallpaper
2. **Color Seeds** - 10 predefined color themes:
   - Travli Teal (default)
   - M3 Baseline Purple
   - Indigo, Blue, Teal, Green
   - Yellow, Orange, Deep Orange, Pink

## 🌐 Localization

Add new languages:

1. Create `lib/l10n/app_[locale].arb`
2. Add translations
3. Run `flutter gen-l10n`
4. Add locale to `supportedLocales` in `main.dart`

## 📋 Roadmap

### Phase 1: Core Features ✅ COMPLETED (Oct 24, 2025)
- [x] Home screen with navigation
- [x] City search (online + offline)
- [x] Place discovery and selection
- [x] Route optimization (ACO algorithm)
- [x] Google Maps integration
- [x] Multi-language support (5 languages)
- [x] Material 3 theming with 10 color options
- [x] Offline places database (10 cities)
- [x] Settings with app info

### Phase 2: Enhanced Features 🔄 IN PROGRESS
- [ ] **Starting location options** (GPS/custom address)
- [ ] **Route type selection** (walk/drive/transit/bike)
- [ ] Adjust optimization based on transport mode
- [ ] Save and share routes
- [ ] Expand offline database (50+ cities)
- [ ] Recent history tracking
- [ ] Performance optimization

### Phase 3: Advanced Features ⏳ PLANNED
- [ ] Place filtering by category/rating
- [ ] Route editing (reorder, add/remove)
- [ ] Multi-day trip planning
- [ ] Real-time traffic integration
- [ ] User accounts and sync
- [ ] Route recommendations

See [changelog](changelog/) for detailed progress.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Mazhar Berk**
- GitHub: [@MazBer](https://github.com/MazBer)

## 🙏 Acknowledgments

- [Flutter](https://flutter.dev/) - UI framework
- [Material Design 3](https://m3.material.io/) - Design system
- [OpenStreetMap](https://www.openstreetmap.org/) - Map data
- [Nominatim](https://nominatim.org/) - Geocoding API
- [Overpass API](https://overpass-api.de/) - POI data

## 📞 Support

For support, email mazharberkaydogdu@gmail.com or open an issue on GitHub.

---

**Made with ❤️ using Flutter**
