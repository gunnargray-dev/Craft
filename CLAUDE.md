# Design Skills

When working on design tasks in this project, read the relevant reference file from `skills/references/` based on the current task.

## Routing

- **Animation, transitions, springs, enter/exit** → `skills/references/motion-patterns.md`
- **Buttons, inputs, cards, cells, sheets, press states** → `skills/references/component-craft.md`
- **Type scale, font weights, tracking, leading** → `skills/references/typography-system.md`
- **Palette, semantic colors, dark mode, contrast** → `skills/references/color-system.md`
- **Grid, spacing tokens, padding, safe areas** → `skills/references/spacing-layout.md`
- **Tab bars, sheets, modality, popovers** → `skills/references/navigation-patterns.md`
- **Gestures, haptics, touch targets, scroll** → `skills/references/interaction-patterns.md`
- **Pre-ship audit, contrast checks, VoiceOver** → `skills/references/accessibility-audit.md`
- **iOS vs iPadOS, orientation, multitasking** → `skills/references/platform-adaptation.md`

## Always Apply

1. Springs, never linear/ease-in-out for interactive elements
2. Concentric border radius: outer = inner + padding
3. Press states on all tappable elements (scale 0.97, snappy spring)
4. Three-tier transparent shadow system
5. Semantic system colors, support light + dark mode
6. 44pt minimum touch targets
7. Respect Reduce Motion, Dynamic Type, VoiceOver
