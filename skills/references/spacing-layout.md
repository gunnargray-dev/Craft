# Spacing & Layout

## Spacing Scale

Use a 4pt base grid. All spacing values are multiples of 4.

| Token | Value | Use |
|---|---|---|
| space-xs | 4pt | Icon-to-label gap, tight inline elements |
| space-sm | 8pt | Between related items in a group, inline padding |
| space-md | 12pt | Between groups, cell internal padding, control spacing |
| space-lg | 16pt | Section margins, card padding, system horizontal margin |
| space-xl | 24pt | Between major sections, bezel-free control padding |
| space-2xl | 32pt | Screen top/bottom padding, breathing room between unrelated sections |
| space-3xl | 48pt | Hero spacing, dramatic separation |

### Rules
- **Consistent internal padding:** Cards use 16pt. Cells use 12-16pt. Don't vary within the same component type.
- **Proximity = relationship.** Items 8pt apart are related. Items 24pt apart are separate groups. Use spacing to communicate hierarchy without headers or dividers.
- **Padding between controls:** ~12pt for bezeled controls, ~24pt for bezel-free controls. Unrelated controls too close = hard to differentiate.

## System Margins

### iOS Horizontal Margins
| Device | Leading/Trailing Margin |
|---|---|
| iPhone SE / Mini | 16pt |
| iPhone Standard | 16pt |
| iPhone Max / Plus | 20pt |
| iPad (compact) | 20pt |
| iPad (regular) | 20pt (or responsive) |

- Content extends edge-to-edge behind these margins. Backgrounds and artwork bleed to display edges.
- Interactive content (text, buttons, form fields) respects the margins.
- Full-bleed images and cards may ignore leading/trailing margins but should keep consistent inner padding.

### Vertical Margins
- **Below navigation bar:** 0pt (content begins immediately; scroll under the bar).
- **Above tab bar:** 0pt (content scrolls under the tab bar). System insets handle safe area.
- **Between screen top and first content:** 8-16pt after large title. 0pt if using system navigation bar.

## Safe Areas

### Non-negotiable
- **Never place interactive elements in safe area insets.** Content can extend into safe areas (backgrounds, images) but tappable controls cannot.
- **Dynamic Island:** Top safe area accounts for this automatically. Don't manually offset.
- **Home indicator:** Bottom safe area. System handles this. Don't add extra padding on top of the inset.

### Where Content Can Bleed
- Background colors and images → extend to all edges
- Scrollable content → extends to bottom and sides, under tab bar
- Maps and media → extend to all edges

### Where Content Must Respect Safe Areas
- Buttons, inputs, interactive controls
- Text content (reading material)
- Navigation elements
- Tab bar items

## Layout Patterns

### Full-Width vs Inset
- **Full-width elements:** Grouped backgrounds, hero images, banners, separators.
- **Inset elements:** Cards, form fields, buttons, text blocks. Inset by system margin.
- **Mixed:** A full-width card background with inset content inside (system margin for the card, then card padding for the content).

### Content Grouping

Use one of these three methods — not multiple in the same view:

1. **Background shapes** — Cards or rounded rectangles with secondary background color. Best for visual distinction.
2. **Separators** — Thin horizontal lines between items. Best for lists with homogeneous content.
3. **Spacing alone** — Larger gaps between groups, smaller gaps within. Best for clean, minimal layouts.

### Grid Systems

**Single column (iPhone portrait):**
- System margin on both sides
- Content flows top to bottom
- Cards stack vertically with 12-16pt gaps

**Two column (iPad, iPhone landscape):**
- 16pt gap between columns
- Columns are equal width or 1/3 + 2/3 split
- At narrow widths, collapse to single column

**Masonry / variable (photo grids, collections):**
- 2pt gap for tight photo grids (Instagram style)
- 8pt gap for card collections
- Minimum item width: 100pt (prevents items too small to tap)

## Adaptive Layout

### Size Classes

| Configuration | Horizontal | Vertical |
|---|---|---|
| iPhone portrait | Compact | Regular |
| iPhone landscape | Compact | Compact |
| iPad portrait | Regular | Regular |
| iPad full landscape | Regular | Regular |
| iPad split (narrow) | Compact | Regular |

### Adaptation Rules

1. **Defer compact layouts on iPad.** Keep full layout as long as possible when resizing. Only switch to compact when full layout no longer fits.
2. **Stack on compact, side-by-side on regular.** Horizontal layouts become vertical stacks when horizontal class is compact.
3. **Show/hide secondary content.** Sidebars, detail panes, and auxiliary panels appear in regular, hide in compact.
4. **Reduce columns.** 3-column grid → 2-column → 1-column as width decreases.
5. **Never hide primary content.** Adaptation changes layout, not information. All content remains accessible.

### Breakpoint Behavior
- Don't hard-code breakpoints. Use size classes and flexible containers.
- Test at every split-screen width on iPad, not just full-screen.
- Test with the keyboard visible (reduces available height significantly).

## Scroll Behavior

### Content Under Bars
- Content scrolls under navigation bars and tab bars with blur/material.
- As content scrolls under the nav bar: the large title collapses to inline title.
- Scroll indicators (scrollbar) inset by safe area margins.

### Scroll-to-Top
- Tapping the status bar scrolls to top. System behavior — don't override.
- If your view has multiple scroll regions, only the primary one responds.

### Pull-to-Refresh
- System control: UIRefreshControl / .refreshable modifier.
- Appears below navigation bar, above content.
- Don't add custom pull-to-refresh on top of system-provided tab bar minimization.

### Pagination
- Prefer infinite scroll with loading indicators for feed-style content.
- Use paging for discrete items (onboarding cards, photo gallery).
- Paging: enable paging behavior, add page indicator dots. Dots centered horizontally, 8pt below content.

## Keyboard Avoidance

- When keyboard appears, content area shrinks. Scroll focused field into view.
- Bottom-anchored buttons slide up with keyboard. Don't let them hide behind it.
- **Test:** every input field on the smallest device (iPhone SE) with keyboard open. Can the user see what they're typing AND the submit button?
- Use `.ignoresSafeArea(.keyboard)` sparingly — only for backgrounds that should extend behind the keyboard.
