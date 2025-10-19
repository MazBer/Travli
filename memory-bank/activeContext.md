# Active Context: Travli

## Current Status
**Project Initialization Phase** - Setting up memory bank and planning architecture

## Current Work Focus
- Establishing project foundation
- Defining technical stack
- Creating development roadmap
- Setting up memory bank documentation

## Recent Changes
- Created memory bank structure
- Documented project requirements
- Defined phased development approach
- Established design system based on provided samples

## Next Immediate Steps
1. Get user confirmation on Flutter vs React Native
2. Initialize Flutter project structure
3. Set up design system and theme
4. Create basic navigation structure (Home, Search, Settings)
5. Implement UI for home screen based on design sample

## Active Decisions & Considerations

### Framework Decision
**Pending**: Flutter vs React Native
- **Leaning towards Flutter** because:
  - Developer has C# background (Dart is similar)
  - Better performance out of the box
  - Excellent UI toolkit
  - Single codebase, truly native performance
  - Strong community and documentation

### API Strategy
**Pending**: Which APIs to use for places data
- **Options**:
  1. Google Places API (paid, comprehensive, reliable)
  2. Foursquare API (freemium, good coverage)
  3. OpenStreetMap + Overpass API (free, requires more work)
  4. Combination approach (free APIs + fallback to paid)
- **Decision needed**: Budget and data quality requirements

### Database Schema
**In Progress**: Designing local database structure
- Tables needed:
  - `cities`: id, name, country, coordinates, image_url
  - `places`: id, city_id, name, description, category, coordinates, image_url, rating
  - `routes`: id, name, city_id, created_at, is_favorite
  - `route_places`: route_id, place_id, order_index
  - `user_preferences`: key, value

## Important Patterns & Preferences

### Code Style
- Feature-based organization
- Separation of concerns (UI, business logic, data)
- Immutable data structures
- Descriptive naming conventions

### UI/UX Patterns
- Bottom tab navigation (Home, Search, Settings)
- Card-based layouts for places
- Horizontal scrolling for recent trips
- Search with clear button
- Back button on secondary screens
- Consistent color scheme (#111817, #618983, #f0f4f4)
- Plus Jakarta Sans font family

### Development Approach
- **Functionality first, polish later**
- Build in phases with clear milestones
- Test core features before adding complexity
- Offline-first architecture from the start

## Learnings & Project Insights

### Key Insights
1. **Ant Colony Optimization** is well-suited for mobile TSP problems
   - Can be tuned for performance vs accuracy
   - Works well with 5-20 destinations
   - Need to limit iterations for real-time performance

2. **Offline-first is critical** for travel apps
   - Users often have limited connectivity while traveling
   - Local caching must be robust
   - Sync strategy needs careful planning

3. **Design samples provided** show clear patterns:
   - Clean, minimal interface
   - Image-heavy design
   - Consistent spacing and typography
   - Bottom navigation for main sections
   - List-based layouts with thumbnails

4. **User flow is straightforward**:
   - Search → Select → Optimize → Save/Share
   - Keep it simple, avoid feature bloat

### Technical Learnings
- Flutter's widget system maps well to component-based thinking
- Dart's async/await is similar to C#'s async patterns
- Local-first architecture requires careful state management
- Route optimization needs to balance accuracy with speed

## Questions & Uncertainties
1. What's the budget for API usage? (affects API choice)
2. Should we support multiple languages from the start?
3. How many places should we cache per city?
4. Should routes be shareable via deep links or export files?
5. Do we need user accounts in Phase 1, or can we delay to Phase 2?

## Blockers & Risks
- **No blockers currently**
- **Risks**:
  - API costs could escalate with usage
  - ACO performance on older devices needs testing
  - Image caching strategy needs to be efficient
  - Offline mode complexity might delay MVP

## Context for Next Session
When resuming work:
1. Review this file and progress.md
2. Check if framework decision was made
3. Continue with project initialization
4. Start implementing Phase 0 tasks
5. Reference design samples in `/memory-bank/design-samples.md` for UI implementation
