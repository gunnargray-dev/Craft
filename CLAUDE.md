# Craft — Claude Code Configuration

## Project Overview

Craft is an iOS SwiftUI design library app — a living reference implementation and interactive playground for design tokens, components, motion patterns, and accessibility auditing. It targets **iOS 18+** and uses **pure SwiftUI with no external dependencies** (system frameworks only).

**Architecture:** MVVM-light — prefer `@State`/`@Binding` with lightweight `@Observable` where state management is needed. No over-engineering; this is a reference app, not a production app with networking. Group files by feature/tab, not by type.

For the full feature spec (tab structure, section details, build priority), see `AGENTS.md`.

## Build Commands

```bash
# Build
xcodebuild -project Craft.xcodeproj -scheme Craft -destination 'platform=iOS Simulator,name=iPhone 16,OS=latest' build

# Clean build
xcodebuild -project Craft.xcodeproj -scheme Craft clean build
```

## File Structure

```
Craft/
├── CraftApp.swift
├── ContentView.swift          # Tab bar
├── Shared/                    # Design tokens, typography, colors, shared components
│   ├── DesignTokens.swift     # Spacing scale, shadow definitions, spring configs
│   ├── PerplexityColors.swift # Semantic color palette
│   ├── PerplexityTypography.swift
│   ├── CraftButton.swift      # Reusable button component
│   └── PlatformImports.swift
├── Foundation/                # Color palette, type scale, spacing, border radius demos
├── Components/                # Button, card, sheet, list, text input, empty state galleries
├── Motion/                    # Spring playground, enter/exit, stagger, gesture, haptics demos
└── Audit/                     # Accessibility checklist, contrast checker, dynamic type, size class
```

## Coding Conventions

### Motion
- Springs, never linear/ease-in-out for interactive elements. Use `.spring(response:dampingFraction:)`.
  - Snappy spring: `response: 0.3, damping: 0.7` — button press, toggles
  - Responsive spring: `response: 0.4, damping: 0.75` — sheet presentation
  - Smooth spring: `response: 0.5, damping: 0.8` — navigation transitions
- Enter animations: opacity + translateY + blur. Exit: quieter than enters (−12pt offset, faster).
- Respect Reduce Motion: use `.animation(.default, value:)` and check `accessibilityReduceMotion`.

### Components
- Concentric border radius: outer = inner + padding. Always.
- Press states on all tappable elements: `scale(0.97)` with snappy spring.
- Three-tier shadow system (transparent shadows, not solid borders).
- Minimum 44pt touch targets (extend hit area with `contentShape`).
- Loading skeletons match exact layout of loaded state.

### Typography
- Custom fonts: GT Canon (headings), PPLX Sans (body), PPLX Mono (code), PPLX Serif (editorial).
- System text styles (title, headline, body, caption, etc.) for sizing.
- Maximum 2 weights per view. Support Dynamic Type — test at AX5.

### Color
- Semantic colors via `PerplexityColors.swift`. Support both light and dark mode.
- Never rely on color alone for state — add icons/shapes.
- Design tokens via `DesignTokens.swift`.

### Spacing & Icons
- 4pt spacing grid: use multiples of 4 for all spacing.
- System margins: 16pt leading/trailing on iPhone.
- SF Symbols preferred for iconography (filled variant for selected states).

## Skills Reference

### Coding workflow skills (`.claude/skills/`)
Standard development workflow skills: `code-review`, `code-simplifier`, `coding-workflow`, `commit-push-pr`, `pr-description`, `repo-skills`.

### Design domain skill (`skills/`)
The `native-mobile-design` skill with 9 reference files covering motion, components, typography, color, spacing, navigation, interactions, accessibility, and platform adaptation. Load the relevant reference file based on the design task.

## Execution Rules

- Do NOT stall. If an approach isn't working, try a different one immediately.
- Do NOT explore the codebase endlessly. Get oriented quickly, then start making changes.
- If a tool is missing (e.g., `rg`), use an available alternative (e.g., `grep -r`) and move on.
- If a git operation fails, try a different approach (e.g., `gh repo clone` instead of `git clone`).
- Stay focused on the objective. Do not go on tangents or investigate unrelated code.
- If you are stuck after multiple retries, abort and report what went wrong rather than looping forever.
- NEVER approve PRs — you are not authorized to approve pull requests. Only create and comment on PRs.

## Output Persistence

Before finishing, write your complete final response to `/tmp/claude_code_output.md` using the Write tool. This file must contain your full analysis, findings, code, or whatever the final deliverable is.
