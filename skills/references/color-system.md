# Color System

## Palette Architecture

### Three Layers

1. **Primitive palette** — Raw color values. Named by hue + shade (blue-500, gray-100). Never referenced directly in UI.
2. **Semantic tokens** — Named by purpose (label-primary, background-secondary, accent). Reference primitives. This is what components use.
3. **Component tokens** — Named by component + state (button-primary-fill, input-border-error). Reference semantic tokens. Optional layer for complex systems.

**Rule:** Components never reference primitives directly. Always go through semantic tokens. This is what makes theme switching (light/dark, brand variants) possible without touching component code.

### iOS Semantic Color System

Apple provides two background sets. Use the right one:

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

**Foreground hierarchy:**
| Token | Purpose | Light | Dark |
|---|---|---|---|
| label | Primary text | Black | White |
| secondaryLabel | Subtitles, metadata | #3C3C43 60% | #EBEBF5 60% |
| tertiaryLabel | Disabled, placeholder | #3C3C43 30% | #EBEBF5 30% |
| quaternaryLabel | Watermarks, decorative | #3C3C43 18% | #EBEBF5 18% |
| separator | Thin dividers (translucent) | #3C3C43 29% | #545458 60% |
| opaqueSeparator | Solid dividers | #C6C6C8 | #38383A |
| link | Tappable text links | System blue | System blue |

### System Colors (12 hues)

Red, Orange, Yellow, Green, Mint, Teal, Cyan, Blue, Indigo, Purple, Pink, Brown.

Each has 4 variants: default light, default dark, increased contrast light, increased contrast dark. Never hard-code the hex values — use the semantic API.

**Gray scale:** 6 levels (systemGray through systemGray6). Use for disabled states, backgrounds, secondary fills.

## Accent Color Strategy

### Single Accent
Most apps need one accent color. It appears in:
- Interactive text (links, tappable labels)
- Primary button fills
- Selected tab bar items
- Toggle/switch active states
- Progress indicators

**Selection criteria:**
- Passes 4.5:1 contrast on both light AND dark backgrounds
- Not too similar to system red (avoids confusion with errors/destructive actions)
- Not too similar to system blue (avoids confusion with default system interactive color)
- Distinct from your gray scale at a glance

### When to Add a Second Color
Only when you need to distinguish between two categories of interactive elements. Example: positive actions (green) vs navigation (blue). Three accent colors = too many. Rethink the hierarchy.

## Dark Mode

### Not an Inversion
Dark mode colors are adjusted, not inverted. Key differences:

- **Backgrounds get darker but not pure black.** #1C1C1E (elevated) vs #000000 (base).
- **Foreground colors get slightly desaturated** to reduce eye strain on dark backgrounds.
- **Shadows are nearly invisible** on dark backgrounds. Reduce shadow opacity by 40-50% or remove entirely. Use subtle borders or elevated background colors for separation instead.
- **Colored surfaces shift lighter.** A blue card that's #007AFF in light mode needs to become #0A84FF in dark mode (brighter, not darker).

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
