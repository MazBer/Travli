# Known Issues

## Multilingual Place Names Not Displaying Correctly

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
