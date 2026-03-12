# Design Skills — MANDATORY

**Before writing or modifying ANY SwiftUI code, you MUST read the relevant skills reference file(s).** These are not optional guidelines — they are the project's design system.

## How to Use

1. Determine which design domains your task touches (motion, components, typography, etc.)
2. Read the corresponding reference file(s) from `skills/references/`
3. Follow every rule, value, and constraint in those files
4. If your task spans multiple domains, read all relevant files

## Routing

| Task involves... | Read this file |
|---|---|
| Animation, transitions, springs, enter/exit | `skills/references/motion-patterns.md` |
| Buttons, inputs, cards, cells, sheets, press states, shadows | `skills/references/component-craft.md` |
| Type scale, font weights, tracking, leading, Dynamic Type | `skills/references/typography-system.md` |
| Palette, semantic colors, dark mode, contrast | `skills/references/color-system.md` |
| Grid, spacing tokens, padding, margins, safe areas | `skills/references/spacing-layout.md` |
| Tab bars, sheets, modality, alerts, popovers, navigation | `skills/references/navigation-patterns.md` |
| Gestures, haptics, touch targets, scroll behaviors | `skills/references/interaction-patterns.md` |
| Accessibility audit, contrast checks, VoiceOver, Reduce Motion | `skills/references/accessibility-audit.md` |
| iOS vs iPadOS, orientation, size classes, multitasking | `skills/references/platform-adaptation.md` |

**When in doubt, read `skills/references/component-craft.md` — it covers the universal rules (concentric radii, shadows, press states) that apply to everything.**

## Non-Negotiable Rules (Always in Effect)

These apply to every file, every component, every commit. No exceptions.

### Motion
- Springs only. Never linear, ease-in, ease-out, or ease-in-out for interactive elements.
- Snappy spring (response: 0.3, damping: 0.7) for button press, toggles.
- Responsive spring (response: 0.4, damping: 0.75) for sheet presentation.
- Smooth spring (response: 0.5, damping: 0.8) for navigation transitions.
- Respect `accessibilityReduceMotion` — cross-dissolve fallbacks, no bounce.

### Components
- Concentric border radius: outer = inner + padding. Always.
- Press states on ALL tappable elements: scale(0.97) with snappy spring.
- Three-tier transparent shadow system (see `DesignTokens.swift`).
- Loading skeletons match exact layout of loaded state.

### Layout
- 4pt spacing grid. All spacing values are multiples of 4.
- 16pt system margins on iPhone.
- 44pt minimum touch targets (extend hit area with `contentShape` if visual element is smaller).

### Typography
- Use `PPFont.*` tokens for all text (`PerplexityTypography.swift`). Never use raw `Font.system()`.
- Four font families: PPLX Sans (UI), PPLX Serif (titles/articles), PPLX Mono (code), GT Canon (display/hero).
- Apply line height with `.ppLineHeight()` and tracking with `.ppTracking()`.
- Maximum 2 font weights per view. `.monospacedDigit()` on dynamic numbers.
- Support Dynamic Type — test at AX5.

### Color & Accessibility
- Use Perplexity semantic tokens (`Color.fgPrimary`, `Color.bgBase`, `Color.accentFgPrimary`, etc.) from `PerplexityColors.swift`.
- Primitives (`Color.teal500`, `Color.gray700`, etc.) available but prefer semantic tokens in components.
- All semantic colors support light/dark mode automatically via `Color.dynamicColor()`.
- Never rely on color alone for state — add icons, shapes, or text.
- WCAG AA contrast minimums: 4.5:1 body text, 3:1 large/bold.

### Code Patterns
- Use `DesignTokens.swift` for all spacing, shadows, springs, and radii.
- Use `Dimensions.*` spacing tokens (`spacing3xs` through `spacing3xl`, 2–32pt).
- Use `CraftButton` for all buttons. Use `.pressEffect()` for custom tappable elements.
- Use `.enterAnimation(delay:)` for staggered reveals on new screens.
