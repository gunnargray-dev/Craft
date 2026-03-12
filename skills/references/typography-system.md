# Typography System

## Font Families

Craft uses four custom Perplexity typefaces, bundled as variable fonts in `Craft/Resources/Fonts/`:

| Family | File | Swift Constant | Use |
|---|---|---|---|
| **PPLX Sans** | `PPLXSansBetav0VF.ttf` | `PPFontFamily.sans` | Primary UI text — body, captions, sections |
| **PPLX Serif** | `PPLXSerifBetav0VF.ttf` | `PPFontFamily.serif` | Titles, article body (serif mode) |
| **PPLX Mono** | `PPLXMonoBetav0VF.ttf` | `PPFontFamily.mono` | Code blocks, inline code |
| **GT Canon** | `GT-Canon-VF.ttf` | `PPFontFamily.condensed` | Headlines, display, hero text |

Italic variants: `PPLXSerifBetav0VF-Italic.ttf`, `GT-Canon-Italic-VF.ttf`.

Fonts are registered in `Craft/Info.plist` via `UIAppFonts`. Use `PPFont.*` for all text — **never use raw `Font.system()`**.

## Perplexity Type Scale

All tokens defined in `PerplexityTypography.swift`. Use `PPFont.*` in SwiftUI code.

### UI Text

| Token | Font | Size | Line Height | Tracking | Weight | Use |
|---|---|---|---|---|---|---|
| `PPFont.caption` | PPLX Sans | 12pt | 16pt | -0.54 | Regular (400) | Labels, metadata, timestamps |
| `PPFont.captionStrong` | PPLX Sans | 12pt | 16pt | -0.54 | Semibold (600) | Emphasized labels, badge text |
| `PPFont.codeSm` | PPLX Mono | 12pt | 16pt | -0.24 | Regular (400) | Inline code, small code snippets |
| `PPFont.codeMd` | PPLX Mono | 14pt | 20pt | -0.56 | Regular (400) | Code blocks, terminal output |
| `PPFont.bodyMd` | PPLX Sans | 16pt | 24pt | -0.72 | Regular (400) | Secondary body text, descriptions |
| `PPFont.bodyMdStrong` | PPLX Sans | 16pt | 24pt | -0.72 | Semibold (600) | Emphasized secondary body |
| `PPFont.bodyLg` | PPLX Sans | 17pt | 26pt | -0.72 | Regular (400) | Primary body text, paragraphs |
| `PPFont.bodyLgStrong` | PPLX Sans | 17pt | 26pt | -0.72 | Semibold (600) | Emphasized primary body, cell titles |

### UI Headings

| Token | Font | Size | Line Height | Tracking | Weight | Use |
|---|---|---|---|---|---|---|
| `PPFont.section` | PPLX Sans | 18pt | 26pt | -0.81 | Semibold (600) | Section headers within a screen |
| `PPFont.title` | PPLX Serif | 20pt | 28pt | -0.40 | Semibold (600) | Screen titles, card titles |
| `PPFont.headline` | GT Canon | 24pt | 32pt | -0.48 | Medium (500) | Major headings, feature titles |
| `PPFont.display` | GT Canon | 38pt | 48pt | -0.76 | Medium (500) | Large display text, marketing |
| `PPFont.hero` | GT Canon | 46pt | 56pt | -0.92 | Medium (500) | Hero text, splash screens |

### Article Text

| Token | Font | Size | Line Height | Tracking | Weight | Use |
|---|---|---|---|---|---|---|
| `PPFont.articleBodySerif` | PPLX Serif | 17pt | 26pt | -0.32 | Medium (500) | Long-form reading (serif mode) |
| `PPFont.articleBodySans` | PPLX Sans | 17pt | 26pt | -0.24 | Regular (400) | Long-form reading (sans mode) |
| `PPFont.articleCode` | PPLX Mono | 14pt | 20pt | -0.28 | Regular (400) | Code within articles |

### Article Headings

| Token | Font | Size | Line Height | Tracking | Weight | Use |
|---|---|---|---|---|---|---|
| `PPFont.articleSectionSerif` | PPLX Serif | 19pt | 28pt | -0.36 | Semibold (600) | Article section headers (serif) |
| `PPFont.articleSectionSans` | PPLX Sans | 19pt | 28pt | -0.54 | Semibold (600) | Article section headers (sans) |
| `PPFont.articleTitleSerif` | PPLX Serif | 21pt | 30pt | -0.36 | Semibold (600) | Article titles (serif) |
| `PPFont.articleTitleSans` | PPLX Sans | 21pt | 30pt | 0.00 | Semibold (600) | Article titles (sans) |
| `PPFont.articleHeadlineSerif` | GT Canon | 24pt | 32pt | -0.48 | Medium (500) | Article headlines (serif) |
| `PPFont.articleHeadlineSans` | PPLX Sans | 24pt | 32pt | 0.00 | Semibold (600) | Article headlines (sans) |

### Dark Mode Font Weights

Variable fonts support light/dark weight variants via `DynamicFontWeight`. The design-tokens repo defines per-token weight names for light and dark modes (e.g., "S Regular" vs "Dark S Regular" for PPLX Sans). These are available through `PPTypographyToken` specs.

## Apple Type Scale Reference (iOS/iPadOS — SF Pro)

For reference when comparing to system styles. These are the default (Large) size values.

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

### When to Use Each PPFont Style

**`hero` / `display`** (GT Canon, 46pt / 38pt): Splash screens, landing pages, marketing moments. One per screen maximum.

**`headline`** (GT Canon, 24pt): Major headings, feature titles. The bridge between display and content text.

**`title`** (PPLX Serif, 20pt): Screen titles, card titles. The go-to heading for most screens.

**`section`** (PPLX Sans, 18pt): Section headers within a screen. Use to divide content into groups.

**`bodyLg` vs `bodyMd`** (17pt vs 16pt): Use `bodyLg` for primary content text. Use `bodyMd` for secondary descriptions. Use `Strong` variants for emphasis — don't increase size.

**`caption` / `captionStrong`** (12pt): Labels, metadata, timestamps, badge text. The smallest production text. Nothing smaller.

**`codeSm` / `codeMd`** (PPLX Mono, 12pt / 14pt): Code snippets and technical content only.

**Article styles:** Use `articleBody*` for long-form reading. Choose serif or sans based on user preference. Article headings (`articleSection*`, `articleTitle*`, `articleHeadline*`) create hierarchy within articles.

### Weight Selection

The Perplexity type system uses three weights:

| Weight | Value | When to Use |
|---|---|---|
| Regular (400) | `Font.Weight.regular` | Body text, captions, descriptions, long-form reading |
| Medium (500) | `Font.Weight.medium` | GT Canon headings, article serif body |
| Semibold (600) | `Font.Weight.semibold` | Strong variants, section headers, titles, emphasis |

**Rule:** Use maximum 2 weights per view. Usually Regular + Semibold. The `PPFont` tokens already encode the correct weight — don't override with `.bold()` or `.fontWeight()`.

## Tracking (Letter Spacing)

All Perplexity tokens include specific tracking values. Apply via `.ppTracking()` modifier using the values from `PPTypographyToken`.

### Key Tracking Values (PPLX Fonts)

| Size | Token | Tracking | Notes |
|---|---|---|---|
| 12pt (caption) | `PPTypographyToken.uiTextCaptionNormal` | -0.54 | Tighter at small sizes for cohesion |
| 14pt (code) | `PPTypographyToken.uiTextCodeMd` | -0.56 | Mono needs tighter tracking |
| 16pt (bodyMd) | `PPTypographyToken.uiTextBodyMdNormal` | -0.72 | Standard body — memorize this |
| 17pt (bodyLg) | `PPTypographyToken.uiTextBodyLgNormal` | -0.72 | Primary body text |
| 18pt (section) | `PPTypographyToken.uiHeadingSection` | -0.81 | Section headers |
| 20pt (title) | `PPTypographyToken.uiHeadingTitle` | -0.40 | Serif title — looser than sans |
| 24pt (headline) | `PPTypographyToken.uiHeadingHeadline` | -0.48 | GT Canon headline |
| 38pt (display) | `PPTypographyToken.uiHeadingDisplay` | -0.76 | Display text |
| 46pt (hero) | `PPTypographyToken.uiHeadingHero` | -0.92 | Hero — tightest tracking |

**Pattern:** PPLX fonts use negative tracking across all sizes. Tracking gets tighter (more negative) as size increases, opposite to SF Pro's behavior.

## Leading (Line Height)

All Perplexity tokens include explicit line height values. Apply via `.ppLineHeight(_:fontSize:)` modifier.

### Leading Values by Token

| Category | Size → Line Height | Ratio |
|---|---|---|
| Caption (12pt) | 12 → 16pt | 1.33x |
| Code Sm (12pt) | 12 → 16pt | 1.33x |
| Code Md (14pt) | 14 → 20pt | 1.43x |
| Body Md (16pt) | 16 → 24pt | 1.50x |
| Body Lg (17pt) | 17 → 26pt | 1.53x |
| Section (18pt) | 18 → 26pt | 1.44x |
| Title (20pt) | 20 → 28pt | 1.40x |
| Headline (24pt) | 24 → 32pt | 1.33x |
| Display (38pt) | 38 → 48pt | 1.26x |
| Hero (46pt) | 46 → 56pt | 1.22x |

**Pattern:** Ratio decreases as size increases — small text gets more generous line height for legibility, large text tightens for visual cohesion.

### When to Adjust
- **Wide columns / long passages:** Increase leading by 2-4pt for comfortable reading.
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

## Custom Font Notes

The Perplexity font families are variable fonts (VF) bundled in the app. Key considerations:

- **Variable font weights:** PPLX Sans/Serif and GT Canon support continuous weight axes. The design tokens define specific weight stops (400, 500, 600) — stick to these.
- **Dark mode weight variants:** The design-tokens system defines separate named weight instances for light and dark modes (e.g., "S Regular" vs "Dark S Regular"). These are encoded in `DynamicFontWeight` in the generated `Typography.swift`.
- **Minimum size:** 12pt (`PPFont.caption`). Nothing smaller in production.
- **Mixing with system fonts:** Avoid mixing PPLX fonts with SF Pro in the same view. If you must use system fonts (e.g., for system controls), ensure baseline alignment.
- **Font registration:** All fonts are registered in `Craft/Info.plist` under `UIAppFonts`. If a font doesn't render, verify the file is in the bundle resources.

### Font Family Roles
- **PPLX Sans:** The workhorse. All UI text, body, captions, sections.
- **PPLX Serif:** Expressive. Titles, article body (serif mode), article headings.
- **PPLX Mono:** Technical. Code blocks, inline code, terminal output.
- **GT Canon:** Display. Headlines, display text, hero moments. Condensed/narrow — creates visual drama.
