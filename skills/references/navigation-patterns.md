# Navigation Patterns

## Navigation Model

iOS uses three primary navigation patterns. Choose based on information architecture, not preference.

### 1. Tab Bar (Flat)
**Structure:** 3-5 top-level sections, each with independent navigation state.

**When to use:**
- App has distinct, parallel sections (Feed, Search, Profile)
- Users switch between sections frequently
- Each section's navigation state should persist

**Rules:**
- Tab bar is navigation, not actions. No "compose" or "settings" as tabs unless they're true destinations.
- Never disable or hide tabs. If content unavailable, show empty state.
- Keep visible during navigation. Only modals cover it.
- Use filled SF Symbols for selected, outlined for unselected.
- Badge (red dot or count) for critical information only — don't dilute.
- iOS: bottom, Liquid Glass. iPadOS: top, can convert to sidebar.

### 2. Navigation Stack (Hierarchical)
**Structure:** Drill-down from list → detail → sub-detail. Back button returns up the stack.

**When to use:**
- Content has a clear parent → child relationship
- Users follow a path deeper into content
- Settings, mail, file browsers

**Rules:**
- Back button always returns to parent. Never hijack it for other actions.
- Show the parent's title as the back button label (truncated if long).
- Large title on root views, inline title on pushed views.
- Swipe-from-left-edge to go back is system behavior — never disable it.
- Deep stacks (>4 levels) indicate an architecture problem. Consider restructuring.

### 3. Modality (Interruption)
**Structure:** Content presented over the current context, blocking interaction with the parent.

**When to use:**
- Self-contained task (compose, edit, confirm)
- Critical information requiring acknowledgment
- Task that shouldn't pollute the navigation stack

**Rules:**
- See Sheets & Modality section below.

## Sheets

### Presentation Styles

| Style | Height | Use |
|---|---|---|
| Automatic | System decides | Default. Let the system choose based on content. |
| Page sheet | Almost full screen, slight inset | Multi-step flows, content creation, complex forms |
| Form sheet | Narrower on iPad, full on iPhone | Settings, preferences, simple forms |
| Custom detent | Specific fraction | Quick actions, pickers, confirmations |

### Detent Stops

| Detent | Approximate Height | Use |
|---|---|---|
| Small | ~25% screen | Quick actions, mini player, filter bar |
| Medium | ~50% screen | Selection lists, search results, maps overlay |
| Large | ~90% screen (full minus grab bar + status) | Content creation, full forms |

**Rules:**
- Sheets can snap between detents. Define which ones make sense for your content.
- Don't create arbitrary detent heights. Use the named stops.
- Grabber handle: always show on sheets with multiple detents. 36x5pt, centered, gray-3.
- **Scroll interaction:** Content inside sheets scrolls at the largest detent. At smaller detents, scrolling up expands the sheet first, then scrolls content.

### Dismiss Patterns
- **Swipe down** from sheet surface or grabber handle.
- **Tap scrim** (30% black overlay behind sheet).
- **Cancel / X button** in top-trailing corner for explicit dismiss.
- If unsaved content exists: intercept dismiss with a confirmation action sheet ("Discard Changes?").
- **Non-dismissable sheets:** Rare. Only for critical flows (authentication, required permissions). Remove the scrim tap dismiss but keep the explicit button.

## Alerts

### When to Use
- Critical information requiring acknowledgment
- Destructive action confirmation
- Binary decision (allow/deny, delete/cancel)

### Rules
- **Maximum 2 actions.** Preferred action on the right (or bottom if stacked). Destructive action in red.
- **3 actions maximum** via action sheet, not alert. If you need 3+ options, use an action sheet instead.
- **Title is required.** Brief, specific. "Delete this photo?" not "Are you sure?"
- **Message is optional.** Add only if the title alone isn't sufficient context.
- **Never stack alerts.** One at a time. Queue if necessary (but rethink if you're queuing alerts).
- **No alerts for non-critical information.** Use inline feedback, banners, or toasts instead.

## Action Sheets

### When to Use
- Multiple related actions for the current context
- Destructive action that needs confirmation with alternatives
- Share/export options

### Rules
- Actions listed in order of likelihood (most common first).
- Destructive actions: red text, grouped separately at the bottom above cancel.
- Cancel button: always present, always last, separated by a gap.
- iPhone: slides up from bottom edge. iPad: presented as a popover from the source element.
- **Source matters on iPad.** Always anchor the popover to the element that triggered it. Centered popovers with no anchor look broken.

## Popovers

### When to Use
- Additional information or controls related to a specific element
- On iPad where you have space for floating content
- When context preservation matters more than full attention

### Rules
- Arrow points to the source element. Always.
- Dismiss by tapping outside the popover.
- Don't use on iPhone — present as a sheet instead. System handles this adaptation.
- Content should be compact. If you need scrolling inside a popover, it might be too complex for a popover.
- Maximum one popover visible at a time.

## Navigation Bar

### Anatomy
```
┌──────────────────────────────────────────┐
│ [Back]     Title            [Action(s)]  │
└──────────────────────────────────────────┘
```

### Rules
- **Large title:** Root-level views. Scrolls inline on scroll-up.
- **Inline title:** Pushed views, secondary screens.
- **Right-side actions:** Maximum 2-3 buttons. More → use a menu (ellipsis button).
- **Liquid Glass material:** Nav bar floats over content with blur. Content scrolls beneath it.
- **Title should match the tab or source.** If the tab says "Library," the nav bar title says "Library."

## Search

### Placement
- **In navigation bar:** Pull down to reveal search field. Standard for most apps.
- **As a tab:** Dedicated search tab with its own destination. For search-heavy apps (App Store, Music).
- **Inline:** Search field visible in the content area. For filtering visible content (Contacts, Settings).

### Rules
- Show recent searches on focus (before typing).
- Show suggestions as user types (debounce: 300ms).
- Search results replace or overlay current content — don't navigate to a new screen.
- Cancel button appears on focus, dismisses search and restores previous content.
- Scope bar (optional): horizontal segmented control below search field for filtering by category.

## Deep Linking

### Rules
- Every significant screen should have a URL-addressable path.
- Deep links should restore the full navigation stack (user can navigate back to parent).
- If the target content doesn't exist (deleted, permissions), show a graceful error — not a crash or blank screen.
- Test: does the deep link work from a cold launch (app not in memory)?
