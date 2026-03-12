# Typography System

## Type Scale (iOS/iPadOS — SF Pro)

Based on Apple's Dynamic Type system. These are the default (Large) size values.

| Style | Weight | Size | Leading | Emphasized | Use |
|---|---|---|---|---|---|
| Large Title | Regular | 34pt | 41pt | Bold | Screen titles, hero text |
| Title 1 | Regular | 28pt | 34pt | Bold | Section headers |
| Title 2 | Regular | 22pt | 28pt | Bold | Card titles, group headers |
| Title 3 | Regular | 20pt | 25pt | Semibold | Subsection headers |
| Headline | Semibold | 17pt | 22pt | Semibold | Emphasized body, cell titles |
| Body | Regular | 17pt | 22pt | Semibold | Primary content text |
| Callout | Regular | 16pt | 21pt | Semibold | Secondary content, descriptions |
| Subhead | Regular | 15pt | 20pt | Semibold | Tertiary content, metadata |
| Footnote | Regular | 13pt | 18pt | Semibold | Timestamps, helper text |
| Caption 1 | Regular | 12pt | 16pt | Semibold | Labels, input labels |
| Caption 2 | Regular | 11pt | 13pt | Semibold | Legal text, minimum size |

## Decision Rules

### When to Use Each Style

**Large Title / Title 1:** Top of scrollable views. One per screen. Use Large Title for primary screens, Title 1 for secondary screens.

**Title 2 / Title 3:** Section headers within a screen. Title 2 for major sections, Title 3 for subsections. Don't skip levels (don't go Large Title → Title 3).

**Headline vs Body:** Same size (17pt), different weight. Use Headline for labels that need emphasis without increasing size. Use Body for readable paragraphs.

**Callout / Subhead:** Smaller content text. Callout for descriptions that pair with titles. Subhead for metadata (date, author, category).

**Footnote:** Helper text below inputs, timestamps, attributions. Smallest size for non-decorative content.

**Caption 1 / Caption 2:** Input labels, badge text, tab bar labels. Caption 2 is the absolute minimum — nothing smaller in production.

### Weight Selection

| Weight | When to Use |
|---|---|
| Regular | Body text, descriptions, any long-form reading |
| Medium | De-emphasized labels that still need distinction from Regular |
| Semibold | Headline labels, cell titles, nav bar titles, input labels |
| Bold | Screen titles (Large Title, Title 1-2), strong emphasis |
| Heavy | Never in standard UI. Reserve for marketing/editorial only |
| Ultralight/Thin/Light | Never for functional text. Only decorative display if legible |

**Rule:** Use maximum 2 weights per view. Usually Regular + Semibold, or Regular + Bold. Three weights = noisy hierarchy.

## Tracking (Letter Spacing)

Apple's tracking values are applied automatically in running apps. In design tools (Figma, Sketch), apply manually:

### Key Tracking Values (SF Pro)

| Size Range | Tracking Direction | Notes |
|---|---|---|
| 6-11pt | Positive (looser) | Small text needs more breathing room |
| 12pt | Zero | Neutral point |
| 13-20pt | Negative (tighter) | Body range tightens for readability |
| 17pt (Body) | -0.43pt | Most common — memorize this one |
| 21-23pt | Transitioning | Moving from tight back to neutral |
| 24pt+ | Positive (looser) | Display sizes open up for elegance |
| 34pt (Large Title) | +0.40pt | Titles need room to breathe |

**Rule of thumb:** If you're designing in Figma at body size (17pt), apply -0.4 tracking. At title size (28pt+), apply +0.3 to +0.4.

## Leading (Line Height)

Apple's text styles encode specific leading values. Follow these ratios:

### Leading Rules

- **Body text (multi-line):** ~1.29x font size (17pt → 22pt leading). This is the iOS default.
- **Titles (1-2 lines):** ~1.2x font size. Tighter because titles rarely wrap.
- **Caption/Footnote:** ~1.23-1.38x. Slightly more generous at small sizes for legibility.

### When to Adjust
- **Wide columns / long passages:** Increase leading by 2-4pt for comfortable reading. Content should feel spacious.
- **Tight layouts (cells, compact cards):** Decrease by 1-2pt. But never go below 1.15x font size.
- **Three or more lines:** Never use tight leading. The eye loses its place.

## Font Smoothing

- **macOS web:** Apply `-webkit-font-smoothing: antialiased` globally. Renders thinner, crisper text.
- **iOS native:** System handles this. Don't override.
- **Figma:** Enable "Smooth" anti-aliasing in text properties to approximate iOS rendering.

## Tabular Numerals

Use monospaced (tabular) figures for:
- Prices, currency amounts
- Counters, timers, scores
- Table columns with numbers
- Any number that updates dynamically

Regular (proportional) figures for:
- Body text containing numbers
- Dates in prose
- Static labels like "3 items"

In SwiftUI: `.monospacedDigit()`. In Figma: enable "Tabular Figures" in OpenType features.

## Hierarchy Through Type

### The 3-Level Rule
Any single view should have at most 3 distinct type levels:

1. **Primary:** What is this? (Title, headline)
2. **Secondary:** What details matter? (Body, callout)
3. **Tertiary:** What's supplementary? (Footnote, caption)

If you need a 4th level, you're putting too much on one screen. Consider splitting into separate views or using progressive disclosure.

### Creating Distinction
Distinguish levels through **one** attribute change, not multiple:

- Size change alone (Title 2 → Body)
- Weight change alone (Headline → Body, same size)
- Color change alone (primary label → secondary label)

Changing size AND weight AND color between two lines is overkill and creates visual noise.

## Text-wrap

- Apply `text-wrap: balance` to titles and short blocks. Distributes words evenly, prevents orphans.
- Apply `text-wrap: pretty` to body text for subtle line-break optimization.
- For native iOS: the system handles this reasonably. In SwiftUI, `.lineLimit(nil)` and let the text flow.

## Dynamic Type Support

Non-negotiable. Every text element must respond to the user's preferred text size.

### Testing Checklist
- [ ] Set device to largest accessibility size (AX5). Does the layout still work?
- [ ] Set device to smallest size (xSmall). Does anything look oversized or wasteful?
- [ ] Do truncated labels get `...` at extreme sizes, or do they overlap other content?
- [ ] Do multi-line labels reflow gracefully, or do they break layout constraints?
- [ ] Is the information hierarchy preserved? (Primary text still looks primary at every size)

### Common Failures
- Fixed-height containers that clip text at large sizes.
- Side-by-side labels that overlap instead of stacking.
- Icons that don't scale with adjacent text.
- Tab bar labels that truncate to meaninglessness.

**Fix:** Use flexible containers. At `isAccessibilityCategory` sizes, switch horizontal layouts to vertical. Reduce column count.

## Typeface Selection (Custom Fonts)

If using a custom typeface instead of SF Pro:

- **Must support Dynamic Type.** If the font can't scale, it can't ship.
- **Must include Regular, Medium, Semibold, Bold at minimum.** Missing weights = broken emphasis hierarchy.
- **Must support Bold Text accessibility setting.** The system adds weight — your font needs a heavier variant to shift to.
- **Test at 11pt (minimum).** If the font is illegible at caption size, use SF Pro for small text and the custom font for titles only.
- **Match SF Pro's metrics** for baseline alignment when mixing system and custom fonts.

### Safe Pairing Pattern
- Custom font for: Large Title, Title 1, Title 2 (brand expression)
- SF Pro for: everything else (optimized for legibility at small sizes)
- Never use more than 2 typeface families total.
