# Color System

## Palette Architecture

### Three Layers

1. **Primitive palette** — Raw color values. Named by hue + shade (e.g., `Color.teal500`). Defined in `PerplexityColors.swift`. Avoid referencing directly in UI.
2. **Semantic tokens** — Named by purpose (e.g., `Color.fgPrimary`, `Color.bgBase`, `Color.accentFgPrimary`). Defined in `PerplexityColors.swift`. **This is what components use.**
3. **Component tokens** — Named by component + state. Optional layer for complex systems built on top of semantic tokens.

**Rule:** Components should use semantic tokens, not primitives. This makes light/dark mode switching automatic.

### Perplexity Primitive Palette

10 hues × 9 shades (100–900) defined in `PerplexityColors.swift` as `Color` extensions:

| Hue | Code Name | Token Range | Example |
|---|---|---|---|
| Gray | Odin | `gray100`–`gray900` | `Color.gray500` |
| Red | Ifrit | `red100`–`red900` | `Color.red500` |
| Orange | Phoenix | `orange100`–`orange900` | `Color.orange500` |
| Yellow | Sylph | `yellow100`–`yellow900` | `Color.yellow500` |
| Green | Garuda | `green100`–`green900` | `Color.green500` |
| Teal | Shiva | `teal100`–`teal900` | `Color.teal500` |
| Blue | Leviathan | `blue100`–`blue900` | `Color.blue500` |
| Indigo | Fenrir | `indigo100`–`indigo900` | `Color.indigo500` |
| Purple | Ramuh | `purple100`–`purple900` | `Color.purple500` |
| Pink | Jenova | `pink100`–`pink900` | `Color.pink500` |

### Perplexity Semantic Colors

All semantic tokens are defined with automatic light/dark mode support via `Color.dynamicColor(light:dark:)` in `PerplexityColors.swift` and `PlatformImports.swift`.

**Foreground:**
| Token | Purpose |
|---|---|
| `Color.fgPrimary` | Primary text, headings |
| `Color.fgSecondary` | Subtitles, metadata (65% opacity) |
| `Color.fgTertiary` | Disabled text, placeholders (40% opacity) |
| `Color.fgInverse` | Text on inverted backgrounds |

**Background:**
| Token | Purpose |
|---|---|
| `Color.bgBase` | Primary view background (warm off-white / near-black) |
| `Color.bgRaised` | Cards, sheets, elevated surfaces |
| `Color.bgSoft` | Subtle filled areas (7% opacity) |
| `Color.bgSubtle` | Very subtle fills (3.5% opacity) |
| `Color.bgInverse` | Inverted background |

**Border:**
| Token | Purpose |
|---|---|
| `Color.borderHeavy` | Strong visible borders |
| `Color.borderBase` | Standard borders (14% opacity) |
| `Color.borderSoft` | Subtle borders (7% opacity) |
| `Color.borderInverse` | Borders on inverted surfaces |
| `Color.borderFocus` | Focus ring / active input border (teal accent) |

**Accent (Shiva / Teal):**
| Token | Purpose |
|---|---|
| `Color.accentFgPrimary` | Primary interactive text, links |
| `Color.accentFgSecondary` | Secondary interactive text (65% opacity) |
| `Color.accentBgBase` | Primary button fills, selected states |
| `Color.accentBgSubtle` | Subtle accent background (5.5% opacity) |
| `Color.accentBorderHeavy` | Accent-colored borders |
| `Color.accentBorderSubtle` | Subtle accent borders (12.5% opacity) |

**Positive (Garuda / Green):**
| Token | Purpose |
|---|---|
| `Color.positiveFgPrimary` | Success text |
| `Color.positiveFgSecondary` | Secondary success text |
| `Color.positiveBgBase` | Success button/badge fills |
| `Color.positiveBgSubtle` | Subtle success background |

**Negative (Ifrit / Red):**
| Token | Purpose |
|---|---|
| `Color.negativeFgPrimary` | Error text, destructive labels |
| `Color.negativeFgSecondary` | Secondary error text |
| `Color.negativeBgBase` | Error/destructive fills |
| `Color.negativeBgSubtle` | Subtle error background |

**Warning (Phoenix / Orange):**
| Token | Purpose |
|---|---|
| `Color.warningFgPrimary` | Warning text |
| `Color.warningFgSecondary` | Secondary warning text |
| `Color.warningBgBase` | Warning fills |
| `Color.warningBgSubtle` | Subtle warning background |

### Apple System Color Reference

For reference when interoperating with system components:

**System backgrounds** (flat layouts):
| Token | Purpose | Light | Dark |
|---|---|---|---|
| systemBackground | Primary view background | White | Black |
| secondarySystemBackground | Grouped content on primary | #F2F2F7 | #1C1C1E |
| tertiarySystemBackground | Content on secondary | White | #2C2C2E |

**Grouped backgrounds** (grouped table views, settings-style):
| Token | Purpose | Light | Dark |
|---|---|---|---|
| systemGroupedBackground | Overall view | #F2F2F7 | Black |
| secondarySystemGroupedBackground | Card/section on grouped | White | #1C1C1E |
| tertiarySystemGroupedBackground | Content on secondary | #F2F2F7 | #2C2C2E |

## Accent Color Strategy

### Perplexity Accent — Shiva (Teal)
The primary accent is teal, defined as `Color.accentFgPrimary` / `Color.accentBgBase`:
- **Light mode:** `rgb(1, 106, 113)` — deep teal
- **Dark mode:** `rgb(78, 153, 163)` — lighter teal for contrast

It appears in:
- Interactive text (links, tappable labels) — `Color.accentFgPrimary`
- Primary button fills — `Color.accentBgBase`
- Focus rings, active input borders — `Color.borderFocus`
- Selected states, toggles — `Color.accentBgBase`
- Subtle highlighted areas — `Color.accentBgSubtle`

### Semantic Signal Colors
Three additional signal colors are pre-defined — use these instead of inventing new ones:
- **Positive (Garuda/Green):** `Color.positiveFgPrimary`, `Color.positiveBgSubtle` — success, confirmation
- **Negative (Ifrit/Red):** `Color.negativeFgPrimary`, `Color.negativeBgSubtle` — errors, destructive actions
- **Warning (Phoenix/Orange):** `Color.warningFgPrimary`, `Color.warningBgSubtle` — caution, non-blocking alerts

### When to Add More Colors
Don't. The accent + 3 signals cover all UI needs. If you think you need another color, reconsider the information hierarchy.

## Dark Mode

### Not an Inversion
Dark mode colors are adjusted, not inverted. All Perplexity semantic tokens handle this automatically via `Color.dynamicColor(light:dark:)`.

Key differences in the Perplexity palette:
- **Backgrounds:** `bgBase` is warm off-white in light → near-black (`rgb(23, 22, 21)`) in dark. Not pure black.
- **Foreground:** `fgPrimary` is warm dark brown in light → warm light gray in dark. Not pure white or black.
- **Accents shift brighter:** Teal accent goes from deep `rgb(1, 106, 113)` to lighter `rgb(78, 153, 163)`.
- **Shadows are nearly invisible** on dark backgrounds. Reduce shadow opacity by 40-50% or remove entirely. Use subtle borders or `bgRaised` for separation instead.
- **Opacity-based tokens** (`fgSecondary`, `bgSoft`, etc.) automatically adapt because the base color shifts.

### iOS Depth System (Base vs Elevated)
- **Base:** The receding background. Dimmer. Used for the primary app background.
- **Elevated:** The foreground surface. Brighter. Used for sheets, popovers, cards that sit above the base.
- System background colors shift between base and elevated automatically when presenting modals, sheets, and multitasking windows.

### Dark Mode Checklist
- [ ] All text passes 4.5:1 contrast on dark backgrounds
- [ ] No pure white (#FFFFFF) text on dark backgrounds — use system label color (slightly warm)
- [ ] White backgrounds in images are softened (slight darkening overlay) to prevent glowing
- [ ] Icons have separate dark variants where contrast demands it
- [ ] Shadows are reduced or replaced with border/background separation
- [ ] Colors still communicate the same meaning (error red is still visibly red)
- [ ] Increase Contrast mode tested (both light + dark)
- [ ] Reduce Transparency mode tested (materials become opaque)

## Liquid Glass Color

### Rules
- Liquid Glass has **no inherent color** — it picks up what's behind it.
- Apply color to Liquid Glass **only for primary actions** (Done button, main CTA).
- Color the **background**, not the symbol/text on the glass.
- One colored glass element per view maximum. Multiple = visual chaos.
- Monochromatic symbols/text by default — they adapt light/dark based on underlying content.

### When Content is Colorful
If your app has visually rich backgrounds (photos, gradients, illustrations):
- Use monochromatic tab bars and toolbars
- Don't apply accent color to glass — it competes with the content
- The glass material provides enough contrast through blur

## Contrast Validation

### WCAG AA Minimums (Non-negotiable)

| Text Type | Minimum Ratio |
|---|---|
| Body text (≤17pt) | 4.5:1 |
| Large text (≥18pt) | 3:1 |
| Bold text (any size) | 3:1 |
| Non-text UI components | 3:1 |

### Ideal Targets
- Body text: 7:1 (ensures readability in challenging lighting)
- Small text (footnote, caption): 7:1 (compensates for reduced legibility at small sizes)
- Interactive elements: 4.5:1 minimum for the element boundary or fill

### Tools
- Xcode Accessibility Inspector (runtime check)
- Figma contrast plugins (design-time check)
- Manual: (L1 + 0.05) / (L2 + 0.05) where L = relative luminance

## Color as Information

### The Independence Rule
Color must never be the **sole** carrier of meaning. Every color-coded state needs a secondary indicator:

| Information | Color | Secondary Indicator |
|---|---|---|
| Error | Red | Error icon + text message |
| Success | Green | Checkmark icon |
| Warning | Orange/Yellow | Warning triangle icon |
| Disabled | Gray | Reduced opacity + non-interactive |
| Selected | Accent | Checkmark, filled icon, or bold weight |
| Unread | Accent dot | "Unread" label for VoiceOver |

### Color Blindness Considerations
Problematic pairings (avoid relying on these alone):
- Red / Green (most common: deuteranopia, protanopia)
- Blue / Orange (less common: tritanopia)
- Red / Brown
- Green / Brown

**Test:** View your designs with color blindness simulation (Figma, Sim Daltonism, Xcode).

## Wide Color (Display P3)

### When to Use
- Photos and video: always capture and display in P3 when available
- Brand colors: if your brand color falls outside sRGB gamut, provide P3 variant
- Gradients: P3 produces smoother gradients with less banding
- Data visualization: P3's wider gamut allows more distinguishable hues

### When sRGB is Fine
- UI chrome (backgrounds, borders, separators)
- Text colors
- Icon tints
- Anything that needs to look identical across all displays

### Asset Format
- P3 images: PNG, 16 bits per channel
- Provide sRGB fallback in asset catalog for older displays
- In Xcode: asset catalog handles P3/sRGB variant switching automatically
