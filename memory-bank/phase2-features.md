# Phase 2: Advanced Route Options - Feature Specifications

## Overview
Phase 2 focuses on enhancing the route optimization experience by adding starting location options and transport mode selection. These features will make routes more practical and personalized for users.

---

## Feature 1: Starting Location Selector

### User Story
**As a traveler**, I want to choose where my route starts from, so that I can plan routes from my hotel, current location, or any custom address.

### Requirements

#### Functional Requirements
1. **Three Starting Location Options:**
   - **Current Location (GPS)** 🌍
     - Use device GPS to get current coordinates
     - Show accuracy indicator
     - Request location permission if not granted
     - Fallback to manual entry if GPS unavailable
   
   - **Custom Address** 📍
     - Text input for address/place name
     - Autocomplete suggestions using Nominatim
     - Geocode address to coordinates
     - Show selected location on mini-map preview
   
   - **Select from Places** 🏨
     - Choose from already selected places
     - Useful for starting from hotel/accommodation
     - Mark as "starting point" in place list

2. **Default Behavior:**
   - Default to first selected place if no starting point chosen
   - Remember last used starting location preference
   - Allow changing starting point before optimization

#### UI/UX Design

**Location Selector Card** (Before route generation):
```
┌─────────────────────────────────────┐
│ Starting Location                    │
├─────────────────────────────────────┤
│ ○ First selected place (default)    │
│ ○ Current location 🌍               │
│ ○ Custom address 📍                 │
│ ○ Select from places 🏨             │
└─────────────────────────────────────┘
```

**When "Current Location" selected:**
```
┌─────────────────────────────────────┐
│ ● Current location 🌍               │
│   Getting your location...          │
│   Accuracy: ±10m                    │
│   [Use this location]               │
└─────────────────────────────────────┘
```

**When "Custom Address" selected:**
```
┌─────────────────────────────────────┐
│ ● Custom address 📍                 │
│   ┌───────────────────────────────┐ │
│   │ Enter address or place name   │ │
│   └───────────────────────────────┘ │
│   Suggestions:                      │
│   • Hotel Marriott, Rome            │
│   • Roma Termini Station            │
│   [Confirm location]                │
└─────────────────────────────────────┘
```

#### Technical Implementation

**1. Location Permission Handling:**
```dart
// lib/core/services/location_service.dart
class LocationService {
  Future<Position?> getCurrentLocation() async {
    // Check permission
    // Request if needed
    // Get coordinates
    // Return Position or null
  }
}
```

**2. Geocoding Service:**
```dart
// lib/core/services/geocoding_service.dart
class GeocodingService {
  Future<List<Location>> searchAddress(String query) async {
    // Use Nominatim search API
    // Return list of matching locations
  }
  
  Future<Location> geocodeAddress(String address) async {
    // Convert address to coordinates
  }
}
```

**3. State Management:**
```dart
// lib/core/providers/route_providers.dart
final startingLocationProvider = StateProvider<StartingLocation?>((ref) => null);

class StartingLocation {
  final StartingLocationType type;
  final double? latitude;
  final double? longitude;
  final String? address;
  final int? placeId; // If starting from a place
}

enum StartingLocationType {
  firstPlace,
  currentLocation,
  customAddress,
  selectedPlace,
}
```

#### Dependencies
- **geolocator**: ^10.1.0 (GPS location)
- **geocoding**: ^2.1.1 (Address to coordinates)
- **permission_handler**: ^11.0.1 (Location permissions)

---

## Feature 2: Route Type Selector

### User Story
**As a traveler**, I want to choose my mode of transportation, so that the route is optimized for walking, driving, public transport, or cycling.

### Requirements

#### Functional Requirements
1. **Four Transport Modes:**
   - **Walking** 🚶
     - Shorter distances preferred
     - Pedestrian-friendly routes
     - Average speed: 5 km/h
     - Max reasonable distance: 5-10 km
   
   - **Driving** 🚗
     - Optimized for car travel
     - Can cover longer distances
     - Average speed: 40 km/h (city)
     - Considers parking availability
   
   - **Public Transport** 🚌
     - Transit-friendly routes
     - Near stations/stops
     - Average speed: 20 km/h
     - Consider transfer times
   
   - **Cycling** 🚴
     - Bike-friendly routes
     - Medium distances
     - Average speed: 15 km/h
     - Max reasonable distance: 15-20 km

2. **Optimization Adjustments:**
   - Adjust ACO parameters based on mode
   - Different distance/time weights
   - Filter places by accessibility
   - Show appropriate time estimates

3. **Default Behavior:**
   - Default to "Walking" mode
   - Remember last used transport mode
   - Show mode-specific tips/warnings

#### UI/UX Design

**Transport Mode Selector** (Horizontal chips):
```
┌─────────────────────────────────────┐
│ Route Type                          │
├─────────────────────────────────────┤
│  [🚶 Walk]  [🚗 Drive]              │
│  [🚌 Transit]  [🚴 Bike]            │
│                                     │
│  Estimated time: 2h 30m             │
│  Total distance: 8.5 km             │
└─────────────────────────────────────┘
```

**Selected Mode Details:**
```
┌─────────────────────────────────────┐
│ ● Walking 🚶                        │
│   Best for: Short distances         │
│   Avg speed: 5 km/h                 │
│   Recommended: < 10 km total        │
│                                     │
│   ⚠️ This route is 12 km            │
│   Consider using transit or bike    │
└─────────────────────────────────────┘
```

#### Technical Implementation

**1. Transport Mode Model:**
```dart
// lib/models/transport_mode.dart
enum TransportMode {
  walking,
  driving,
  publicTransport,
  cycling,
}

class TransportModeConfig {
  final TransportMode mode;
  final double averageSpeed; // km/h
  final double maxReasonableDistance; // km
  final String icon;
  final String googleMapsMode; // for URL
  
  // ACO parameters
  final double distanceWeight;
  final double timeWeight;
}
```

**2. Mode-Specific Optimization:**
```dart
// lib/core/services/route_optimizer.dart
class RouteOptimizer {
  List<Place> optimizeRoute(
    List<Place> places,
    StartingLocation? start,
    TransportMode mode,
  ) {
    final config = TransportModeConfig.forMode(mode);
    
    // Adjust ACO parameters
    final aco = AntColonyOptimization(
      distanceWeight: config.distanceWeight,
      timeWeight: config.timeWeight,
      averageSpeed: config.averageSpeed,
    );
    
    // Run optimization
    return aco.optimize(places, startLocation: start);
  }
}
```

**3. Google Maps Integration:**
```dart
// Update Google Maps URL with transport mode
String buildGoogleMapsUrl(
  List<Place> route,
  TransportMode mode,
) {
  final modeParam = mode.googleMapsMode; // 'walking', 'driving', 'transit', 'bicycling'
  return 'https://www.google.com/maps/dir/?api=1&...'
         '&travelmode=$modeParam';
}
```

**4. State Management:**
```dart
// lib/core/providers/route_providers.dart
final transportModeProvider = StateProvider<TransportMode>(
  (ref) => TransportMode.walking,
);
```

#### Transport Mode Configurations

| Mode | Avg Speed | Max Distance | Distance Weight | Time Weight | Google Maps Mode |
|------|-----------|--------------|-----------------|-------------|------------------|
| Walking 🚶 | 5 km/h | 10 km | 0.7 | 0.3 | walking |
| Driving 🚗 | 40 km/h | 100 km | 0.3 | 0.7 | driving |
| Transit 🚌 | 20 km/h | 50 km | 0.5 | 0.5 | transit |
| Cycling 🚴 | 15 km/h | 20 km | 0.6 | 0.4 | bicycling |

---

## Integration with Existing Features

### Place Selection Screen
Add transport mode selector before "Generate Route" button:
```
┌─────────────────────────────────────┐
│ Rome - 4 places selected            │
├─────────────────────────────────────┤
│ [Place 1] ✓                         │
│ [Place 2] ✓                         │
│ [Place 3] ✓                         │
│ [Place 4] ✓                         │
├─────────────────────────────────────┤
│ Starting from:                      │
│ ○ First place  ● Current location   │
├─────────────────────────────────────┤
│ Route type:                         │
│ ● Walk  ○ Drive  ○ Transit  ○ Bike  │
├─────────────────────────────────────┤
│        [Generate Route]              │
└─────────────────────────────────────┘
```

### Route Result Screen
Show mode-specific information:
```
┌─────────────────────────────────────┐
│ Optimized Route (Walking 🚶)        │
├─────────────────────────────────────┤
│ 1. Current Location                 │
│    ↓ 1.2 km • 15 min                │
│ 2. Colosseum                        │
│    ↓ 0.8 km • 10 min                │
│ 3. Roman Forum                      │
│    ↓ 1.5 km • 18 min                │
│ 4. Trevi Fountain                   │
├─────────────────────────────────────┤
│ Total: 3.5 km • 43 minutes          │
│                                     │
│ [Open in Google Maps]               │
│ [Change Route Type]                 │
└─────────────────────────────────────┘
```

---

## Localization Keys

Add to `lib/l10n/app_en.arb`:
```json
{
  "startingLocation": "Starting Location",
  "firstPlace": "First selected place",
  "currentLocation": "Current location",
  "customAddress": "Custom address",
  "selectFromPlaces": "Select from places",
  "gettingLocation": "Getting your location...",
  "locationAccuracy": "Accuracy: ±{meters}m",
  "enterAddress": "Enter address or place name",
  "confirmLocation": "Confirm location",
  
  "routeType": "Route Type",
  "walking": "Walking",
  "driving": "Driving",
  "publicTransport": "Public Transport",
  "cycling": "Cycling",
  "estimatedTime": "Estimated time: {time}",
  "totalDistance": "Total distance: {distance}",
  "avgSpeed": "Avg speed: {speed}",
  "recommendedFor": "Recommended: < {distance}",
  "routeTooLong": "⚠️ This route is {distance}",
  "considerOtherMode": "Consider using {mode}",
  
  "changeRouteType": "Change Route Type",
  "optimizedFor": "Optimized for {mode}"
}
```

---

## Testing Checklist

### Starting Location
- [ ] GPS permission request works
- [ ] Current location detected accurately
- [ ] Address autocomplete shows suggestions
- [ ] Geocoding converts address to coordinates
- [ ] Can select from existing places
- [ ] Default to first place works
- [ ] Preference is remembered

### Transport Mode
- [ ] All 4 modes selectable
- [ ] Mode-specific parameters applied
- [ ] Time/distance estimates accurate
- [ ] Google Maps opens with correct mode
- [ ] Warning shown for unreasonable distances
- [ ] Preference is remembered
- [ ] UI updates when mode changes

### Integration
- [ ] Works with offline places
- [ ] Works with online API places
- [ ] Route optimization considers starting point
- [ ] Route optimization considers transport mode
- [ ] Localization works for all strings

---

## Performance Considerations

1. **GPS Location:**
   - Cache last known location
   - Set timeout for GPS (10 seconds)
   - Fallback to network location if GPS slow

2. **Geocoding:**
   - Debounce address search (500ms)
   - Cache geocoding results
   - Limit autocomplete to 5 results

3. **Route Optimization:**
   - ACO parameters tuned per mode
   - Faster optimization for walking (fewer iterations)
   - More thorough for driving (more iterations)

---

## Future Enhancements (Phase 3)

- **Mixed Transport Modes:** Allow combining modes in one route
- **Real-time Traffic:** Adjust driving times based on traffic
- **Transit Schedules:** Show actual bus/train times
- **Bike Sharing:** Integrate with bike-sharing services
- **Accessibility Options:** Wheelchair-friendly routes
- **Avoid Highways:** Option for cycling/walking
- **Scenic Routes:** Prefer scenic paths for walking

---

## Success Metrics

- **User Adoption:** % of users who change from default settings
- **Mode Distribution:** Most popular transport mode
- **GPS Usage:** % of routes starting from current location
- **Custom Addresses:** % of routes with custom starting point
- **Route Satisfaction:** Feedback on route quality per mode

---

**Status:** 📋 PLANNING  
**Priority:** HIGH  
**Estimated Effort:** 2-3 weeks  
**Dependencies:** Phase 1 completion ✅
