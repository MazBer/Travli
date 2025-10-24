# Known Issues

## 1. Search System Shows "No Cities Found" on Real Device

**Status:** 🔴 CRITICAL - Needs Fix

**Date Reported:** 2025-10-24

### Problem Description
The city search doesn't work on real devices (APK build), always showing "No cities found" even with valid queries.

### Root Cause
- Search relies on Nominatim API (https://nominatim.openstreetmap.org)
- API may be rate-limited or blocked
- No offline fallback for popular cities
- Network timeout issues on mobile data

### Solution Required
1. Add offline database of popular tourist cities
2. Implement fallback mechanism when API fails
3. Add better error messages
4. Consider using local SQLite database with pre-populated cities

### Priority
**CRITICAL** - Breaks core functionality on real devices

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
