# Platform Adaptation

## iPhone vs iPad — Not Just Bigger

iPad is not "iPhone scaled up." It has different interaction models, navigation patterns, and user expectations.

### Key Differences

| Aspect | iPhone | iPad |
|---|---|---|
| Navigation | Tab bar (bottom) | Tab bar (top) or sidebar |
| Primary input | Thumb, one hand | Both hands, touch + keyboard + trackpad |
| Multitasking | Single app (mostly) | Split View, Slide Over, Stage Manager |
| Content density | One column, focused | Multi-column, spacious |
| Modality | Full-screen sheets | Popovers, form sheets, page sheets |
| Hover states | None | Yes (trackpad/mouse) |
| Keyboard shortcuts | Rare | Expected (⌘ shortcuts overlay) |

## Size Classes

### The Four Configurations

| Configuration | Horizontal | Vertical | Layout |
|---|---|---|---|
| iPhone portrait | Compact | Regular | Single column, bottom nav |
| iPhone landscape | Compact | Compact | Single column, reduced chrome |
| iPad full screen | Regular | Regular | Multi-column, sidebar possible |
| iPad split (narrow) | Compact | Regular | Falls back to iPhone-like layout |

### Adaptation Strategy

**Compact horizontal:**
- Single column layout
- Tab bar at bottom (iPhone) or hidden (iPad split)
- Navigation stack with push/pop
- Full-screen sheets
- No sidebar

**Regular horizontal:**
- Multi-column layout possible (split view, sidebar + detail)
- Tab bar at top (iPad) convertible to sidebar
- Popovers instead of full-screen sheets
- Hover states enabled
- Keyboard shortcut overlay (hold ⌘)

### Rules
- **Don't detect device.** React to size class. An iPad in narrow split view should get the compact layout, same as iPhone.
- **Don't assume orientation.** iPhone Pro Max in landscape has different class than iPhone SE in landscape.
- **Test every split width.** iPad split view can be 1/3, 1/2, or 2/3. Your app must work at all of them.

## Orientation

### Portrait (Primary)
- Design for portrait first. It's the default on iPhone and the most common on iPad.
- Content hierarchy: top-to-bottom.
- Navigation: bottom tab bar (iPhone), top tab bar (iPad).

### Landscape
**iPhone landscape:**
- Tab bar may hide or become compact.
- Navigation bar becomes compact (inline title only, no large title).
- Consider hiding non-essential chrome to maximize content.
- Video and photo apps should support landscape natively.
- Productivity apps can optionally lock to portrait.

**iPad landscape:**
- Full layout with sidebar + detail pane.
- This is where iPad apps should feel like desktop apps (rich, spacious).
- All keyboard shortcuts active.
- Trackpad/mouse hover states visible.

### Rules
- Support both orientations unless there's a strong reason not to (games, camera).
- **Never force landscape on iPhone** for non-media content.
- **Never force portrait on iPad** — it feels broken.
- Orientation change = animated transition. Content reflows, doesn't jump.

## Multitasking (iPad)

### Split View
- Your app runs alongside another app.
- Width ranges from ~320pt to ~694pt depending on split ratio.
- At narrow widths: compact horizontal size class. Use iPhone-like layout.
- At wide widths: regular horizontal size class. Use full iPad layout.
- **Content must remain functional at every split width.** Test it.

### Slide Over
- Your app appears as a narrow floating panel (~320pt wide).
- Always compact horizontal. iPhone-like layout.
- Rounded corners, no access to full-screen features.
- Must work as a complete experience at this width.

### Stage Manager
- Resizable windows. Your app may be any arbitrary size.
- Minimum window size: ~320pt wide.
- All size class transitions must be smooth.
- App icon in the top-left of the window — system provides this.

### Rules
- **Opt out of multitasking only with a strong reason.** Users expect it.
- Don't assume full-screen on iPad. Ever.
- Test: launch your app, then drag another app into split view. Does your layout break?
- Test: resize the split continuously. Is the transition smooth or does it jump?

## Navigation Adaptation

### Tab Bar → Sidebar
On iPad, tab bars at the top can convert to a sidebar for complex hierarchies.

**When to convert:**
- App has more than 5 sections
- Sections have sub-navigation (e.g., folders within a section)
- User benefits from seeing more navigation options simultaneously

**Rules:**
- Sidebar shows all navigation options with expandable groups.
- Sidebar collapses at compact width.
- Let users customize which items appear in the tab bar vs sidebar.
- Sidebar selection highlights with accent color background.

### Sheets → Popovers
On iPad with regular horizontal size class, many presentations change:

| iPhone (Compact) | iPad (Regular) |
|---|---|
| Full-screen sheet | Page sheet (narrower, centered) |
| Action sheet (bottom) | Popover (anchored to source) |
| Full-screen modal | Windowed modal |
| Alert (centered) | Alert (centered, narrower) |

**Rule:** Always anchor popovers to their source element on iPad. A popover floating in space with no arrow looks broken.

## Device-Specific Considerations

### Dynamic Island (iPhone 14 Pro+)
- System handles safe area insets. Don't manually offset.
- Live Activities can appear in the Dynamic Island — design for the compact and expanded states.
- Don't place important content directly below the Dynamic Island.

### Home Indicator (Face ID iPhones)
- Bottom safe area: ~34pt. System manages this.
- Bottom-anchored buttons should sit above the safe area, not overlap the indicator.
- Swipe-up gesture is reserved for Home. Don't place conflicting swipe-up interactions at the bottom edge.

### ProMotion (120Hz)
- Animations render at up to 120fps. Springs and transitions look smoother.
- Design as usual — the system handles frame rate. No special consideration needed.
- Exception: custom animations using CADisplayLink should respect the display's actual refresh rate.

### Always-On Display (iPhone 15 Pro+)
- Lock Screen widgets dim. Design widget content to be legible at reduced brightness.
- Use high-contrast colors in widgets.
- Avoid pure white backgrounds in widgets (they glow on always-on display).

## Localization Layout

### Right-to-Left (RTL)
- Layout flips horizontally. Leading edge becomes right side.
- Navigation: back button moves to top-right. Swipe from right edge to go back.
- Icons with directional meaning (arrows, progress) must flip.
- Icons without directional meaning (search, settings, profile) do not flip.
- Text alignment flips to natural alignment (leading edge).
- **Test:** Switch device language to Arabic or Hebrew and verify full layout.

### Text Expansion
- Translated text can be 30-100% longer than English.
- German and Russian are typically longest.
- Design for the longest expected translation, not the English string.
- Use flexible layouts that accommodate expansion without truncation.
- Button labels should have generous horizontal padding to accommodate translation.

### Rules
- Use Auto Layout and leading/trailing constraints, never left/right.
- Use `.environment(\.layoutDirection, .rightToLeft)` in SwiftUI previews to test.
- Date/time/number formatting: always use system formatters (they handle locale automatically).
