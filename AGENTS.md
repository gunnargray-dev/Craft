# Craft — App Feature Spec

> Coding conventions, architecture, and build commands are in `CLAUDE.md`. This file contains the detailed feature spec and build priority.

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

## Build Priority

Build in this order:
1. App shell (tabs, navigation, DesignTokens.swift)
2. Components tab (most visual validation)
3. Foundation tab
4. Motion tab
5. Audit tab
