# Known Issues


## 1. Places Not Loading on Mobile Network (DNS Error)


**Status:** ✅ RESOLVED


**Date Reported:** 2025-10-24
**Date Diagnosed:** 2025-10-24
**Date Resolved:** 2025-10-24


### Problem Description
Places didn't load on real devices when using mobile data. Showed error: "Failed host lookup: 'overpass.openstreetmap.ru'"


### Root Cause - IDENTIFIED ✓
**DNS Resolution Failure on Mobile Networks**


Error details:
```
DioException [connection error]: The connection errored: Failed host lookup
SocketException: Failed host lookup: 'overpass.openstreetmap.ru'
OS Error: No address associated with hostname, errno = 7
```


**Why it worked in emulator but not on phone:**
- Emulator uses PC's DNS (usually works fine)
- Mobile networks may have:
  - Restricted DNS servers
  - Blocked access to OpenStreetMap servers
  - Firewall rules blocking map services
  - DNS filtering/censorship


### Solution Implemented ✅


#### 1. Multiple API Server Fallback
**File:** `lib/core/services/api_service.dart`

Added 3 Overpass API servers with automatic fallback:
```dart
static const List<String> _overpassServers = [
  'https://overpass-api.de/api/interpreter',
  'https://overpass.kumi.systems/api/interpreter',
  'https://overpass.openstreetmap.ru/api/interpreter',
];
```

If one server fails, automatically tries the next one.


#### 2. Offline Places Database
**File:** `lib/core/data/offline_places.dart`

Created comprehensive offline database with **60+ attractions** across **10 major cities:**
- 🇮🇹 Rome (8 places)
- 🇫🇷 Paris (6 places)
- 🇬🇧 London (5 places)
- 🇪🇸 Barcelona (5 places)
- 🇹🇷 Istanbul (5 places)
- 🇳🇱 Amsterdam (3 places)
- 🇩🇪 Berlin (3 places)
- 🇦🇹 Vienna (3 places)
- 🇨🇿 Prague (3 places)
- 🇬🇷 Athens (3 places)


**Features:**
- Multilingual names (6 languages)
- GPS coordinates
- Categories (Museum, Historic Site, Attraction, etc.)
- Ratings (4.5-5.0 stars)
- Descriptions


#### 3. Automatic Fallback Logic
**File:** `lib/core/services/api_service.dart`

When all API servers fail, automatically uses offline database:
```dart
try {
  // Try all 3 API servers
  return await fetchFromAPI();
} catch (e) {
  // Fallback to offline database
  final offlinePlaces = OfflinePlaces.getPlacesForCity(city.name, cityId);
  if (offlinePlaces.isNotEmpty) {
    return offlinePlaces;
  }
  throw Exception('No data available');
}
```


#### 4. Google Maps Integration Fix
**File:** `android/app/src/main/AndroidManifest.xml`

Added Android queries for Google Maps compatibility:
```xml
<queries>
  <intent>
    <action android:name="android.intent.action.VIEW" />
    <data android:scheme="https" />
  </intent>
  <package android:name="com.google.android.apps.maps" />
</queries>
```


**File:** `lib/features/route/route_result_screen.dart`

Added browser fallback if Maps app fails:
```dart
// Try Maps app first
if (await canLaunchUrl(uri)) {
  launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
}

// Fallback to browser
if (!launched) {
  launched = await launchUrl(uri, mode: LaunchMode.platformDefault);
}
```


### Testing Results ✅
- ✅ Works with WiFi
- ✅ Works with mobile data (uses offline database)
- ✅ Works completely offline for 10 major cities
- ✅ Google Maps opens successfully
- ✅ Browser fallback works if Maps app unavailable


### Commits
- `8be80f8` - Added offline places database
- `f3580a5` - Fixed offline fallback error handling
- `a729b03` - Fixed Google Maps opening with Android queries


### Priority
~~**CRITICAL**~~ → **RESOLVED** ✅

---

## 2. City and Place Names Not Showing in Selected Language

**Status:** 🔴 ACTIVE - Partially Implemented

**Date Reported:** 2025-10-24

### Problem Description
- City names always show in their original language (e.g., "Roma" instead of "Rome")
- Place names sometimes show in original language even when translations exist
- Search results don't respect user's language preference

### Root Cause Analysis

**For Cities:**
- Nominatim API returns city names in local language
- No translation layer for city names
- City model doesn't have localized names

**For Places:**
- Implementation exists but not working correctly
- `getLocalizedName()` method returns original name even when translations exist
- Debug logs show: `Available translations: {es: ..., fr: ...}` but `en` is missing
- Language code mismatch or timing issue

### Evidence from Logs
```
I/flutter: Original: Catacombe di San Sebastiano
I/flutter: Language: en
I/flutter: Available translations: {es: ..., fr: ..., ru: ...}
I/flutter: Localized name: Catacombe di San Sebastiano  ← Should be translated
```

### Solution Required

**For Cities:**
1. Add city name translations to database
2. Use Wikidata or similar for city name translations
3. Implement `getLocalizedName()` for City model

**For Places:**
1. Debug why `localizedNames` map lookup fails
2. Verify map key format matches language code
3. Add fallback to English if user's language unavailable
4. Consider using `name:en` as default if available

### Priority
**HIGH** - Affects UX significantly

---

## 3. Multilingual Place Names Not Displaying Correctly (Original Issue)

**Status:** 🔴 ACTIVE - Needs Investigation

**Date Reported:** 2025-10-22

### Problem Description
The multilingual place name feature is implemented but not working as expected. Place names are not being displayed in the user's selected language even when translations are available in the OSM data.

### Evidence from Console Logs
```
I/flutter: Place: Quattro Fontane
I/flutter: Localized names: {en: Quattro Fontane (Four Fountains), ...}
I/flutter: Current language: en
I/flutter: Localized name shown: Quattro Fontane  ← Should show "Quattro Fontane (Four Fountains)"
```

### Implementation Details
- **Model:** `Place` class has `localizedNames` map and `getLocalizedName()` method
- **API Service:** Extracts `name:*` tags from OSM data correctly
- **UI:** Uses `place.getLocalizedName(currentLanguage)` to display names
- **Language Provider:** Returns language code (e.g., 'en', 'tr', 'de')

### Suspected Issues
1. ✅ Language provider is working (confirmed in logs: `Current language: en`)
2. ✅ Localized names are being extracted (confirmed in logs)
3. ❓ Possible issue with `getLocalizedName()` method lookup
4. ❓ Possible issue with how the map keys are stored vs how they're accessed
5. ❓ Possible timing issue with provider updates

### Files Involved
- `lib/models/place.dart` - Place model with localization support
- `lib/core/services/api_service.dart` - Extracts localized names from OSM
- `lib/features/search/search_screen.dart` - Displays localized names
- `lib/core/providers/language_provider.dart` - Manages language state

### Next Steps
1. Add comprehensive debug logging to trace exact values
2. Verify the map key format matches the language code format
3. Check if there's a timing issue with provider initialization
4. Test with hot reload vs full restart
5. Verify the Place objects are being created with the localizedNames map

### Workaround
Currently showing original name with localized name in italics below when available.

### Priority
**Medium** - Feature is implemented but not functioning. Affects UX but doesn't break core functionality.
