# Interaction Patterns

## Touch Targets

### Minimum Sizes

| Platform | Default | Minimum | Notes |
|---|---|---|---|
| iOS/iPadOS | 44x44pt | 28x28pt | Visual element can be smaller if hit area is 44pt |
| watchOS | 44x44pt | 28x28pt | Prefer larger on small screens |
| visionOS | 60x60pt | 28x28pt | Eye tracking needs generous targets |

### Rules
- **Visual size ≠ hit area.** A 28pt icon button must have a 44pt hit area (extend with invisible padding).
- **Spacing between targets:** 8pt minimum between tappable elements. 12pt preferred. Closer = accidental taps.
- **Thumb zones:** On iPhone, the bottom-center of the screen is easiest to reach. Place primary actions there. Top corners are hardest — keep them for infrequent actions.
- **Edge targets:** Elements at screen edges should extend their hit area to the edge. Don't leave dead zones between the tap target and the screen boundary.

## Gestures

### Standard System Gestures (Never Override)
| Gesture | System Behavior |
|---|---|
| Swipe from left edge | Back navigation |
| Swipe down on sheet | Dismiss |
| Tap status bar | Scroll to top |
| Two-finger pinch | Zoom (photos, maps) |
| Long press on text | Selection / context menu |
| Three-finger gestures | Undo/redo/paste |
| Swipe up from bottom | Home / app switcher |

### Custom Gestures

**Single tap:** Primary action. Every tappable element responds to single tap.

**Long press:** Secondary actions, context menus, drag initiation.
- Trigger delay: 500ms (system default). Don't shorten.
- Always show haptic feedback on trigger.
- Reveal a context menu or begin drag. Never use long press as the only way to access an action.

**Swipe (on cells/cards):**
- Leading swipe: positive/constructive actions (pin, mark read, archive)
- Trailing swipe: destructive/dismissive actions (delete, mute)
- Maximum 3 actions per side
- First action (smallest swipe) is the most common action
- Full swipe triggers the first action automatically

**Drag and drop:**
- Long press to pick up (with lift haptic)
- Show a preview of the dragged item attached to the finger
- Drop targets highlight on hover
- Cancel: drag back to origin or lift finger outside any target

**Pull to refresh:**
- Overscroll at top triggers refresh
- System UIRefreshControl handles animation
- Haptic on trigger (light impact)

### Gesture Discovery
Gestures are invisible. If a gesture is the only way to access a feature, most users won't find it.

**Rules:**
- Every gesture-accessible action must also be available through a visible button or menu item.
- Exception: standard system gestures (back swipe, pull to refresh) that users already know.
- Use onboarding tips (TipKit) to surface non-obvious gestures the first 1-2 times.

## Haptic Feedback

### Feedback Types

| Type | Intensity | Use |
|---|---|---|
| **Selection** | Light tick | Scrolling through picker values, moving between discrete items |
| **Impact (light)** | Subtle thud | Toggle switches, pull-to-refresh trigger |
| **Impact (medium)** | Moderate thud | Snapping to a detent, drag drop |
| **Impact (heavy)** | Strong thud | Significant state change, completing a major action |
| **Success** | Rising pattern | Task completed, payment processed, item saved |
| **Warning** | Attention pattern | Approaching a limit, potential issue |
| **Error** | Declining pattern | Action failed, input rejected |

### Rules
- **Pair with visual feedback.** Haptics supplement — they never replace visual/audio cues.
- **Don't overuse.** If everything vibrates, nothing stands out. Haptics on every tap = annoying.
- **Match intensity to significance.** Light impact for minor interactions, success/error for outcomes.
- **Respect Silent Mode.** Haptics work in silent mode — they're separate from audio. This is intentional.
- **Test on device.** Simulator doesn't produce haptics. Physical device required for tuning.

### Common Haptic Pairings
| Interaction | Haptic | Visual |
|---|---|---|
| Toggle on/off | Impact (light) | Switch animation |
| Delete confirmation | Impact (medium) | Item removal animation |
| Pull to refresh trigger | Impact (light) | Spinner appears |
| Picker scroll | Selection (each value) | Value highlight |
| Sheet snaps to detent | Impact (medium) | Sheet position change |
| Successful save | Success | Checkmark / completion animation |
| Error on submit | Error | Shake animation + red highlight |
| Long press trigger | Impact (medium) | Context menu / lift preview |

## Scroll Behaviors

### Standard Scroll
- Deceleration: system default. Don't override unless building a custom physics simulation.
- Bounce at edges (rubber band): system behavior. Don't disable.
- Scroll indicators: appear during scroll, fade after 1.5s of inactivity.
- Content insets: automatically adjusted for nav bar, tab bar, keyboard.

### Paging Scroll
- Content snaps to page boundaries. One full swipe = one page.
- Page indicator dots: centered below content, 8pt spacing.
- Current page dot: accent color, filled. Other dots: gray, 50% opacity.
- Maximum ~8 pages before dots become meaningless. Use a progress bar or counter for more.

### Parallax Scroll
- Background moves slower than foreground (0.3-0.5x speed ratio).
- Use for hero images, header backgrounds.
- **Reduce Motion:** Disable parallax entirely. Background becomes static.

### Sticky Headers
- Section headers stick to the top of the scroll view as content scrolls beneath.
- Previous header pushes up as the next section header reaches the top.
- Sticky header has a subtle material/blur background to separate from content.

### Infinite Scroll
- Begin loading next page when user reaches ~80% scroll depth (2-3 screen heights from end).
- Show a spinner at the bottom during load.
- End state: "No more items" message when all content loaded. Don't keep showing a spinner.
- Error state: "Failed to load. Tap to retry" — inline, not an alert.

## Context Menus

### Trigger
- Long press on any element that has secondary actions.
- Delay: 500ms (system default).
- Haptic: impact (medium) on trigger.
- Preview: a scaled-up snapshot of the element appears above the menu.

### Menu Structure
- Group related actions with separators.
- Destructive actions: red text, at the bottom, separated.
- Include SF Symbol icons alongside each action label.
- Maximum 10-12 items. Beyond that, restructure into submenus.
- **Submenus:** Use sparingly. One level deep maximum.

### Rules
- Context menus are supplementary. Every action in the context menu must be accessible elsewhere.
- Don't put the only path to an important feature in a context menu.
- iPad: context menus also activate on right-click (trackpad/mouse).

## Focus & Keyboard (iPad + External Keyboard)

### Tab Order
- Tab key moves focus through interactive elements in reading order.
- Focus ring: 3pt rounded rectangle around the focused element, system accent color.
- Focused element should be visible — scroll into view if needed.

### Keyboard Shortcuts
- ⌘ shortcuts for primary actions (⌘N new, ⌘S save, ⌘Delete delete).
- Show discoverability overlay: hold ⌘ key to reveal all available shortcuts.
- Don't override system shortcuts (⌘C, ⌘V, ⌘Z, ⌘Tab).

### Pointer (Trackpad/Mouse on iPad)
- Hover effects: subtle background highlight or scale (1.02) on interactive elements.
- Pointer transforms: system pointer morphs to match the shape of buttons and fields.
- Right-click: show context menu (same as long press).
