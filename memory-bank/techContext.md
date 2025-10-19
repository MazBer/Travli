# Technical Context: Travli

## Technology Stack (Recommended)

### Mobile Framework
**Flutter** (Primary Recommendation)
- **Language**: Dart
- **Why**: 
  - Similar to C# (statically typed, object-oriented)
  - Excellent performance
  - Beautiful UI components out of the box
  - Single codebase for iOS and Android
  - Hot reload for fast development

**Alternative**: React Native
- **Language**: JavaScript/TypeScript
- **Why**: Large ecosystem, familiar web technologies

### UI Framework & Styling
**Flutter Material Design + Custom Components**
- Material 3 design system
- Custom widgets matching provided design samples
- Tailwind-inspired spacing and colors

**Design Tokens** (from provided samples):
```dart
// Colors
primary: #111817 (dark text)
secondary: #618983 (muted green)
background: #FFFFFF (white)
surface: #f0f4f4 (light gray)

// Typography
fontFamily: "Plus Jakarta Sans", "Noto Sans"
```

### Local Database
**SQLite** via `sqflite` package (Flutter)
- Stores places, routes, user preferences
- Offline-first data access
- Lightweight and fast

### State Management
**Riverpod** (Flutter) or **Provider**
- Reactive state management
- Dependency injection
- Easy testing

### API Integration
**HTTP Client**: `dio` package (Flutter)
- RESTful API calls
- Interceptors for auth
- Error handling

### External APIs (To Be Integrated)
1. **Google Places API** (or alternative)
   - Place search
   - Place details
   - Place photos
   
2. **OpenStreetMap Nominatim** (Free alternative)
   - Geocoding
   - Place search
   
3. **Google Maps API** or **Mapbox**
   - Distance matrix
   - Directions
   - Map display

4. **Unsplash API** (Optional)
   - High-quality place images

### Authentication
**Firebase Authentication** (Optional for Phase 2+)
- Google Sign-In
- Anonymous auth for offline users
- User profile management

### Storage & Caching
- **SharedPreferences**: User settings, preferences
- **Hive**: Fast key-value storage for cache
- **Cached Network Image**: Image caching

### Navigation
**go_router** package
- Declarative routing
- Deep linking support
- Type-safe navigation

## Development Setup

### Prerequisites
```bash
# Flutter SDK
- Flutter 3.x or later
- Dart 3.x or later

# IDE
- VS Code with Flutter extension
- OR Android Studio with Flutter plugin

# Platform SDKs
- Android SDK (for Android development)
- Xcode (for iOS development, macOS only)
```

### Project Structure
```
travli/
├── lib/
│   ├── main.dart
│   ├── core/
│   │   ├── constants/
│   │   ├── theme/
│   │   ├── utils/
│   │   └── services/
│   ├── features/
│   │   ├── home/
│   │   ├── search/
│   │   ├── route/
│   │   └── settings/
│   ├── models/
│   ├── repositories/
│   └── widgets/
├── assets/
│   ├── images/
│   └── fonts/
├── test/
└── pubspec.yaml
```

### Key Dependencies (Flutter)
```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  flutter_riverpod: ^2.4.0
  
  # Database
  sqflite: ^2.3.0
  path: ^1.8.3
  
  # HTTP & API
  dio: ^5.4.0
  
  # Local Storage
  shared_preferences: ^2.2.2
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  
  # Image Caching
  cached_network_image: ^3.3.0
  
  # Navigation
  go_router: ^13.0.0
  
  # UI Components
  google_fonts: ^6.1.0
  
  # Maps (TBD)
  # google_maps_flutter: ^2.5.0
  # OR flutter_map: ^6.1.0
  
  # Auth (Phase 2+)
  # firebase_auth: ^4.15.0
  # google_sign_in: ^6.2.0
```

## Technical Constraints

### Performance
- Route optimization must complete in < 2 seconds for up to 20 destinations
- App startup time < 3 seconds
- Smooth 60fps UI animations

### Storage
- Local database size limit: ~100MB for cached data
- Image cache: ~50MB
- Total app size target: < 30MB (excluding cached data)

### Network
- Must handle offline mode gracefully
- API rate limiting considerations
- Efficient data synchronization

### Platform Support
- **Android**: Minimum SDK 21 (Android 5.0)
- **iOS**: Minimum iOS 12.0

## Development Workflow

### Phase 0: Setup
1. Initialize Flutter project
2. Set up project structure
3. Configure dependencies
4. Create design system/theme
5. Set up local database schema

### Development Practices
- Feature-based folder structure
- Widget composition over inheritance
- Immutable state
- Unit tests for business logic
- Widget tests for UI components

### Build & Deployment
- **Development**: Debug builds with hot reload
- **Testing**: Profile builds for performance testing
- **Production**: Release builds with obfuscation

## Tool Usage Patterns

### Version Control
- Git for source control
- Feature branch workflow
- Conventional commits

### Testing
- Unit tests: Business logic, algorithms
- Widget tests: UI components
- Integration tests: User flows

### CI/CD (Future)
- GitHub Actions or similar
- Automated testing
- Build automation

## API Key Management
- Environment variables for API keys
- Never commit keys to repository
- Use `.env` files (gitignored)
- Different keys for dev/prod

## Ant Colony Optimization Implementation
- Custom Dart implementation
- Parameters:
  - Number of ants: 10-20
  - Iterations: 50-100
  - Alpha (pheromone importance): 1.0
  - Beta (heuristic importance): 2.0
  - Evaporation rate: 0.5
- Distance matrix from Maps API
- Heuristic: 1/distance or 1/time
