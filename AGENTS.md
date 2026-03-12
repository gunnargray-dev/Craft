# Craft — iOS Design Library App

A SwiftUI iOS app that serves as a living reference for native mobile design principles. Each screen demonstrates and validates specific design craft patterns.

## Project Setup
- **Platform:** iOS 18+, SwiftUI only
- **Xcode project:** Create as a standard iOS app (no SwiftUI multiplatform)
- **Bundle ID:** co.parallelstudio.craft
- **Deployment target:** iOS 18.0
- **No external dependencies.** Pure SwiftUI + system frameworks only.

## Architecture
- MVVM-light. Views + lightweight view models where state management is needed.
- No over-engineering. This is a reference app, not a production app with networking.
- Use @Observable (iOS 17+) over ObservableObject.
- Group files by feature/tab, not by type.

## Design Standards — CRITICAL

This app IS the design skills validation. Every component must follow these rules:

### Motion
- Use springs, never linear/ease-in-out for interactive elements
- Snappy spring (response: 0.3, damping: 0.7) for button press, toggles
- Responsive spring (response: 0.4, damping: 0.75) for sheet presentation
- Smooth spring (response: 0.5, damping: 0.8) for navigation transitions
- Enter animations: opacity + translateY + blur
- Exit animations: quieter than enters (-12pt offset, faster)
- Respect Reduce Motion: use .animation(.default, value:) and check accessibilityReduceMotion

### Components
- Concentric border radius: outer = inner + padding. ALWAYS.
- Press states on all tappable elements: scale(0.97) with snappy spring
- Three-tier shadow system (use transparent shadows, not solid borders)
- Minimum 44pt touch targets (extend hit area with contentShape)
- Loading skeletons match exact layout of loaded state

### Typography
- Use system text styles (title, headline, body, caption, etc.)
- Maximum 2 weights per view
- Support Dynamic Type — test at AX5

### Color
- Use system semantic colors (label, secondaryLabel, systemBackground, etc.)
- Support both light and dark mode
- Never rely on color alone for state — add icons/shapes

### Spacing
- 4pt grid: use multiples of 4 for all spacing
- System margins: 16pt leading/trailing on iPhone
- Group related items with proximity, separate groups with larger gaps

### Navigation
- Bottom tab bar with 4 tabs (SF Symbols, filled for selected)
- Navigation stack within each tab
- Sheets with grabber handles and proper detents

## Tab Structure

### Tab 1: Components
SF Symbol: `square.on.square`
Sections (each a NavigationLink to a detail view):
- **Buttons** — 4 hierarchy levels (primary/secondary/tertiary/destructive) × 4 sizes, interactive press states
- **Text Inputs** — all 5 states with animated transitions between them
- **Cards** — tappable card, multi-action card, loading skeleton toggle
- **Lists** — standard cell anatomy, swipe actions, reorder mode
- **Sheets** — tray system with small/medium/large detents
- **Empty States** — first-run, error, and no-results variants

### Tab 2: Foundation
SF Symbol: `textformat`
Sections:
- **Type Scale** — all 11 iOS text styles rendered with their specs (name, weight, size, leading)
- **Type Hierarchy** — side-by-side: good (3 levels) vs bad (5+ levels, mixed weights)
- **Color Palette** — semantic tokens on light/dark with live contrast ratios
- **Spacing** — visual ruler showing all 7 tokens with example usage
- **Border Radius** — interactive: slider adjusts padding, shows concentric vs mismatched

### Tab 3: Motion
SF Symbol: `wand.and.stars`
Sections:
- **Spring Playground** — 5 presets, drag a circle and release to see each spring. Sliders for response/damping
- **Enter / Exit** — toggle button showing asymmetric enter (full motion) vs exit (subtle)
- **Stagger** — configurable delay slider, animate a list of cards appearing
- **Shared Element** — tap a card to expand into detail with frame/radius animation
- **Haptics** — 7 haptic types, tap each to feel + see description
- **Gestures** — swipe, long-press, drag demo with correct visual + haptic feedback

### Tab 4: Audit
SF Symbol: `checkmark.shield`
Sections:
- **Dynamic Type Preview** — render a sample card at 3 sizes (xSmall, Large, AX5)
- **Contrast Checker** — pick two colors, show ratio and pass/fail badge
- **Size Class** — display current horizontal/vertical size class, update live on rotation
- **Checklist** — interactive version of accessibility audit (toggleable checkmarks)

## File Structure
```
Craft/
├── CraftApp.swift
├── ContentView.swift (tab bar)
├── Components/
│   ├── ComponentsListView.swift
│   ├── ButtonGalleryView.swift
│   ├── TextInputDemoView.swift
│   ├── CardGalleryView.swift
│   ├── ListDemoView.swift
│   ├── SheetDemoView.swift
│   └── EmptyStateDemoView.swift
├── Foundation/
│   ├── FoundationListView.swift
│   ├── TypeScaleView.swift
│   ├── TypeHierarchyView.swift
│   ├── ColorPaletteView.swift
│   ├── SpacingRulerView.swift
│   └── BorderRadiusView.swift
├── Motion/
│   ├── MotionListView.swift
│   ├── SpringPlaygroundView.swift
│   ├── EnterExitDemoView.swift
│   ├── StaggerDemoView.swift
│   ├── SharedElementView.swift
│   ├── HapticsDemoView.swift
│   └── GestureDemoView.swift
├── Audit/
│   ├── AuditListView.swift
│   ├── DynamicTypePreviewView.swift
│   ├── ContrastCheckerView.swift
│   ├── SizeClassView.swift
│   └── ChecklistView.swift
└── Shared/
    ├── DesignTokens.swift (spacing scale, shadow definitions, spring configs)
    └── CraftButton.swift (reusable button component following the spec)
```

## Priority
Build in this order:
1. App shell (tabs, navigation, DesignTokens.swift)
2. Components tab (most visual validation)
3. Foundation tab
4. Motion tab
5. Audit tab

When completely finished, run this command to notify:
openclaw system event --text "Done: Craft iOS library app built — all 4 tabs with design skill validation" --mode now
