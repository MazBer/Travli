# System Patterns: Travli

## Architecture Overview
Mobile application with offline-first capabilities and cloud data synchronization.

```
┌─────────────────────────────────────────┐
│         Mobile Application              │
│  ┌───────────────────────────────────┐  │
│  │     Presentation Layer            │  │
│  │  (React Native / Flutter)         │  │
│  └───────────────────────────────────┘  │
│  ┌───────────────────────────────────┐  │
│  │     Business Logic Layer          │  │
│  │  - Route Optimization (ACO)       │  │
│  │  - Data Management                │  │
│  │  - State Management               │  │
│  └───────────────────────────────────┘  │
│  ┌───────────────────────────────────┐  │
│  │     Data Layer                    │  │
│  │  - Local Storage (SQLite)         │  │
│  │  - Cache Management               │  │
│  └───────────────────────────────────┘  │
└─────────────────────────────────────────┘
           │                    │
           ▼                    ▼
    ┌──────────┐        ┌──────────────┐
    │   API    │        │  External    │
    │ Services │        │  APIs        │
    │          │        │ (Places,     │
    │          │        │  Maps, etc)  │
    └──────────┘        └──────────────┘
```

## Key Technical Decisions

### 1. Mobile Framework
**Decision Pending**: React Native vs Flutter
- **React Native**: JavaScript-based, large ecosystem, hot reload
- **Flutter**: Dart-based, excellent performance, beautiful UI components
- **Recommendation**: Flutter (better performance, easier for C# developers to learn Dart, excellent UI toolkit)

### 2. Route Optimization Algorithm
**Ant Colony Optimization (ACO)** for solving the Traveling Salesman Problem (TSP)
- One-way route (not circular)
- Considers both distance and travel time
- Heuristic approach suitable for real-time mobile computation

### 3. Data Architecture
**Offline-First Approach**
- Local SQLite database for places and routes
- Sync with cloud when online
- Cached images for offline viewing

### 4. State Management
- **Flutter**: Provider or Riverpod
- **React Native**: Redux or Context API + Hooks

## Design Patterns

### 1. Repository Pattern
Abstracts data sources (local vs remote)
```
User Interface
      ↓
  Repository
   ↙     ↘
Local    Remote
Cache    API
```

### 2. Service Layer Pattern
Separates business logic from UI
- `RouteOptimizationService`: ACO implementation
- `PlacesService`: Place data management
- `AuthService`: Authentication handling
- `StorageService`: Local data persistence

### 3. Observer Pattern
For reactive UI updates when data changes

### 4. Strategy Pattern
For different route optimization strategies (future extensibility)

## Component Relationships

### Core Components
1. **Navigation Controller**: Manages screen transitions
2. **Search Module**: City and place search functionality
3. **Route Optimizer**: ACO algorithm implementation
4. **Data Sync Manager**: Handles online/offline synchronization
5. **Storage Manager**: Local database operations
6. **UI Components**: Reusable design system components

### Data Flow
```
User Input → UI Component → Service Layer → Repository → Data Source
                                ↓
                          State Update
                                ↓
                          UI Re-render
```

## Critical Implementation Paths

### Path 1: Search to Route Generation
1. User enters city name
2. Search service queries local cache first, then API
3. Display places with images
4. User selects destinations
5. Route optimizer calculates optimal path
6. Display route on map/list

### Path 2: Offline Mode
1. App checks connectivity
2. If offline, use only local cache
3. Queue sync operations for when online
4. Notify user of offline status

### Path 3: Save & Share
1. User saves generated route
2. Store in local database
3. Generate shareable link/data
4. Share via native share sheet

## Performance Considerations
- Lazy load images
- Paginate place lists
- Cache API responses
- Optimize ACO algorithm for mobile (limit iterations)
- Background sync for data updates

## Security Patterns
- Secure storage for auth tokens
- API key protection
- Input validation
- Rate limiting on API calls
