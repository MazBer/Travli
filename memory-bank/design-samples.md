# Design Samples: Travli

## Design System

### Color Palette
```
Primary Text: #111817 (dark charcoal)
Secondary Text: #618983 (muted teal)
Background: #FFFFFF (white)
Surface: #f0f4f4 (light gray)
Border: #f0f4f4 (light gray)
```

### Typography
```
Font Family: "Plus Jakarta Sans", "Noto Sans", sans-serif
Heading (Large): 22px, bold, -0.015em tracking
Heading (Medium): 18px/19px, bold, -0.015em tracking
Body: 16px, medium/normal
Small: 14px, normal
Extra Small: 12px, medium, 0.015em tracking
```

### Spacing & Layout
- Padding: 16px (p-4)
- Gap: 12px (gap-3), 16px (gap-4)
- Border Radius: 12px (rounded-xl), 8px (rounded-lg)
- Icon Size: 24px
- Avatar/Thumbnail: 56px (size-14), 40px (size-10)

### Components

#### Bottom Navigation
- 3 tabs: Home, Search, Settings
- Icons: House, MagnifyingGlass, Gear
- Active state: filled icon + primary color
- Inactive state: regular icon + secondary color

#### Search Bar
- Background: #f0f4f4
- Height: 48px (h-12)
- Border radius: 12px (rounded-xl)
- Left icon: MagnifyingGlass
- Right icon: XCircle (clear button)
- Placeholder color: #618983

#### Place Card (List Item)
- Min height: 72px
- Thumbnail: 56px square, rounded-lg
- Two-line text layout
- Title: base font, medium weight, primary color
- Subtitle: small font, normal weight, secondary color

#### Trip Card (Horizontal Scroll)
- Min width: 240px (min-w-60)
- Aspect ratio: 16:9 for image
- Border radius: 12px
- Image + text below layout

## Screen Layouts

### Home Screen
- Header: "Home" title (centered) + User icon (right)
- Section: "Recent trips" (horizontal scroll of cards)
- Section: "Recently viewed" (vertical list of place cards)
- Bottom navigation

### Search Screen
- Header: Back button (left) + "Search" title (centered)
- Search bar with clear button
- Section: "Top places in [City]"
- Vertical list of place cards with thumbnails
- Bottom navigation

### Settings Screen
- Header: Back button (left) + "Settings" title (centered)
- Section: "Preferences" (Theme, Language, Units)
- Section: "Account" (Profile, Notifications, Privacy, Help, About)
- Each item: Icon (left) + Text + Optional subtitle
- Bottom navigation

## Notes
- All screens use white background
- Consistent 16px horizontal padding
- Section headers: 22px bold, with padding
- Icons from Phosphor icon set
- Images use aspect-ratio and bg-cover for consistent sizing
