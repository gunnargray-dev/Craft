---
name: native-mobile-design
description: Design system and craft execution for native mobile apps (iOS/iPadOS). Use when designing UI components, reviewing design decisions, specifying motion/animation, defining typography or color systems, auditing accessibility, or prototyping interaction patterns. Covers motion, component craft, typography, color, spacing, navigation, interactions, and platform adaptation. NOT for web-specific patterns (CSS, HTML), marketing design, or brand identity work. NOT for SwiftUI code generation — this is design-only.
---

# Native Mobile Design

Design execution skill for high-craft iOS/iPadOS interfaces. Routes to specific reference files based on the design task.

## When to Load References

Read the relevant reference file based on the current task:

- **Animation, transitions, springs, enter/exit timing** → Read `references/motion-patterns.md`
- **Buttons, inputs, cards, cells, sheets, press states, skeletons** → Read `references/component-craft.md`
- **Type scale, font weights, tracking, leading, Dynamic Type** → Read `references/typography-system.md`
- **Palette, semantic colors, dark mode, contrast, Liquid Glass color** → Read `references/color-system.md`
- **Grid, spacing tokens, padding, safe areas, layout adaptation** → Read `references/spacing-layout.md`
- **Tab bars, sheets, modality, popovers, drill-downs** → Read `references/navigation-patterns.md`
- **Gestures, haptics, touch targets, scroll behaviors** → Read `references/interaction-patterns.md`
- **Pre-ship audit, contrast checks, VoiceOver, Reduce Motion** → Read `references/accessibility-audit.md`
- **iOS vs iPadOS, orientation, multitasking, size classes** → Read `references/platform-adaptation.md`

## Design Knowledge Base

Detailed source material lives in Obsidian. Reference when deeper context is needed:

- `~/Documents/Oppi/02 - Knowledge Base/design/design-principles.md` — master principles doc
- `~/Documents/Oppi/02 - Knowledge Base/knowledge/articles/apple-hig-2026-03-10.md` — full HIG distillation
- `~/Documents/Oppi/02 - Knowledge Base/knowledge/articles/family-values-2026-03-09.md` — benji.org Family Values
- `~/Documents/Oppi/02 - Knowledge Base/knowledge/articles/details-interfaces-feel-better-2026-03-10.md` — Jakub Krehel tactical details

## Principles (Always Apply)

1. **Simplicity through gradual revelation.** Show what's relevant when it's relevant.
2. **Fluidity through seamless transitions.** No teleporting. Every state change has spatial relationship to what came before.
3. **Delight through selective emphasis.** Potential for delight increases as feature usage frequency decreases.
4. **The dirty bathroom rule.** Every feature gets the same craft treatment regardless of usage frequency.
5. **Craft is the differentiator.** This approach is slower. The bet: the product that *feels* better wins.
