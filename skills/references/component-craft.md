# Component Craft

Micro-details that separate polished components from defaults. Every rule here exists because the default behavior isn't good enough.

## Universal Rules

### Concentric Border Radius
When nesting rounded elements: **outer radius = inner radius + padding**.

```
Container radius: 16pt
Container padding: 12pt
Inner element radius: 4pt (16 - 12 = 4)
```

Mismatched radii are one of the most visible tells of unpolished UI. Check every nested rounded element.

### Optical Alignment
- Geometric centering ≠ optical centering for asymmetric shapes.
- Icons next to text: reduce padding on the icon side by 1-2pt.
- Play/arrow icons in circles: shift 1-2pt toward the pointed direction.
- Fix in the SVG/symbol asset when possible, not with layout offsets.

### Press States
Every tappable element needs a press state. The default system highlight is acceptable for standard controls. For custom elements:

- **Scale down:** 0.96-0.98 with snappy spring (response: 0.3, damping: 0.7).
- **Opacity dim:** 0.7 opacity on press, 1.0 on release.
- **Never both** scale and opacity simultaneously — pick one.
- **Minimum press duration:** Show the press state for at least 100ms even on quick taps, so users get feedback.

### Shadow System
Three-tier transparent shadow system that works on any background:

**Elevation 1 (cards, cells):**
```
Shadow 1: 0, 1, 2, rgba(0,0,0, 0.06)
Shadow 2: 0, 1, 3, rgba(0,0,0, 0.04)
```

**Elevation 2 (floating elements, popovers):**
```
Shadow 1: 0, 2, 8, rgba(0,0,0, 0.08)
Shadow 2: 0, 4, 16, rgba(0,0,0, 0.06)
Shadow 3: 0, 0, 1, rgba(0,0,0, 0.04)
```

**Elevation 3 (modals, sheets):**
```
Shadow 1: 0, 8, 32, rgba(0,0,0, 0.12)
Shadow 2: 0, 2, 8, rgba(0,0,0, 0.08)
```

- Transition shadow on hover/press: darken layer 1 by ~0.02 opacity.
- Dark mode: reduce all shadow opacities by 40-50% (dark backgrounds make shadows less visible but also less necessary).

## Buttons

### Hierarchy
1. **Primary (filled):** Solid background, contrasting text. One per view. Accent color or Liquid Glass with accent tint.
2. **Secondary (tinted):** Tinted background at ~12% opacity, accent-colored text. Supporting actions.
3. **Tertiary (plain):** Text-only, accent color. Cancel, skip, or low-priority actions.
4. **Destructive:** Red fill or red text depending on severity. Always confirm destructive actions.

### Sizing
| Size | Height | Horizontal padding | Font | Use |
|---|---|---|---|---|
| Large | 50pt | 20pt | Body Semibold (17pt) | Primary CTAs |
| Medium | 44pt | 16pt | Subhead Semibold (15pt) | Form actions, secondary |
| Small | 34pt | 12pt | Footnote Semibold (13pt) | Inline, compact contexts |
| Mini | 28pt | 8pt | Caption Semibold (12pt) | Tags, badges, tight layouts |

### Rules
- Corner radius: height / 2 for capsule, or match container's inner radius rule.
- Minimum touch target: 44x44pt regardless of visual size (extend hit area with invisible padding).
- **Don't stack more than 2 buttons vertically** in a single group. Use a sheet or action sheet for more options.
- Full-width buttons: inset from screen edges by system margin (16pt). Harmonize corner radius with device corner radius.
- **Loading state:** Replace label with activity indicator. Keep button width constant (don't let it shrink). Disable interaction.

## Text Inputs

### Anatomy
```
┌─────────────────────────────┐
│ Label (Caption 1, secondary)│
│ ┌─────────────────────────┐ │
│ │ Placeholder / Value     │ │
│ │ (Body, primary)         │ │
│ └─────────────────────────┘ │
│ Helper / Error (Caption 2)  │
└─────────────────────────────┘
```

### States
| State | Border | Label | Helper |
|---|---|---|---|
| Default | 1pt separator color | Secondary label | Secondary label |
| Focused | 2pt accent color | Accent color | Secondary label |
| Filled | 1pt separator color | Secondary label | Secondary label |
| Error | 2pt system red | System red | System red + message |
| Disabled | 0.5pt, 50% opacity | Tertiary label | Hidden |

### Rules
- **Validate on blur, not on every keystroke.** Show errors when the user moves to the next field.
- Exception: format-as-you-type for phone numbers, credit cards, dates.
- **Animate error appearance:** fade in + slight translateY (8pt) from above. Don't push content down abruptly.
- **Clear button:** Show only when field has content AND is focused. 44pt touch target.
- **Secure fields:** Use system SecureField. Show/hide toggle on the trailing edge.

## Cards

### Anatomy
- **Corner radius:** 12-16pt for standard cards. Match the container's concentric radius rule.
- **Padding:** 16pt internal. 12pt between cards in a list.
- **Background:** System grouped secondary background, or elevation 1 shadow on primary background.
- **Image slots:** Clip to card radius at top. Full-bleed to card edges (no internal padding for hero images).

### Interaction
- **Tappable cards:** Entire card is the tap target. Press state on the whole card (scale 0.98 or opacity 0.85).
- **Cards with multiple actions:** Buttons inside the card have their own tap targets. Card itself is not tappable.
- **Never both.** A card is either a single tap target OR a container for multiple actions. Not both.

### Loading Skeletons
- Match the exact layout of the loaded state: same heights, widths, and positions.
- Use pulsing gradient animation (shimmer). Light mode: gray-100 to gray-200. Dark mode: gray-800 to gray-700.
- Shimmer direction: leading to trailing, matching reading direction.
- Corner radii on skeleton elements: 4pt for text lines, match actual radius for images/avatars.
- **Duration:** Pulse cycle 1.5s. Continue until content loads — no maximum cycles.

## Lists & Cells

### Standard Cell Anatomy
```
┌──────────────────────────────────────────┐
│ [Icon/Avatar]  Title                [▸]  │
│                Subtitle                  │
│─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ │  ← separator
```

### Rules
- **Cell height:** Minimum 44pt. Standard: 56pt (one line) or 72pt (two lines).
- **Separator inset:** Align with the text's leading edge, not the cell's leading edge. If there's an icon, separator starts after the icon + its trailing padding.
- **Swipe actions:** Maximum 3 actions per side. Leading side: positive actions (pin, read). Trailing side: destructive actions (delete, archive).
- **Swipe action colors:** System blue (default), system orange (secondary), system red (destructive).
- **Reorder handle:** Right edge, vertically centered. Three horizontal lines icon. Only visible in edit mode.
- **Selection indicators:** Checkmark in leading position, accent color. Not a radio button.

## Sheets & Trays

### Dynamic Tray System
Overlays that preserve context instead of full-screen takeovers.

**Rules:**
- Initiated by user action (tap, long-press, notification).
- Each subsequent tray in a flow varies in height to make progression unmistakable.
- One primary action per tray. One piece of content.
- Grabber handle at top: centered, 36x5pt, system gray 3, 2.5pt corner radius.
- **Detent stops:** Small (1/4 screen), medium (1/2 screen), large (full minus safe area). Don't use arbitrary heights.
- **Dismiss:** Swipe down from anywhere. Tap scrim. Cancel/X button in top-trailing corner.
- **Scrim:** Black at 30% opacity behind the sheet. Tapping scrim = cancel.

### When Tray vs Full Screen
| Use Tray | Use Full Screen |
|---|---|
| Confirmations, warnings | Multi-field forms |
| Single-choice selection | Complex multi-step flows |
| Quick settings adjustment | Content creation (compose, edit) |
| Transient info display | Media viewing |
| 1-2 actions needed | Persistent destinations |

## Empty States

Every empty state has three elements:

1. **Illustration or icon** — centered, 80-120pt. Use SF Symbol at large weight or a simple illustration. Muted color.
2. **Title** — what this state is. "No Messages Yet." Headline weight.
3. **Description + CTA** — what to do about it. Body weight, secondary color. Include a tappable action if possible.

- **Don't use humor** in error-related empty states. "Oops!" reads as dismissive.
- **Do use warmth** in first-run empty states. "Your library is empty. Start by adding your first item."
- Empty states are temporary — don't put critical information here.
