# Accessibility Audit

Pre-ship checklist. Every item is pass/fail. Ship when all pass.

## Visual

### Contrast
- [ ] All body text (≤17pt) meets 4.5:1 contrast ratio against its background
- [ ] All large text (≥18pt) and bold text meet 3:1 contrast ratio
- [ ] All non-text UI elements (icons, borders, controls) meet 3:1 contrast ratio
- [ ] Contrast validated in **both** light and dark modes
- [ ] Contrast validated with **Increase Contrast** setting enabled
- [ ] Contrast validated with **Reduce Transparency** setting enabled

### Color Independence
- [ ] No information conveyed through color alone — secondary indicators (icons, text, shapes) present
- [ ] Error states use both red AND error icon + text message
- [ ] Success states use both green AND checkmark/text
- [ ] Selected states use both accent color AND checkmark/bold/filled icon
- [ ] Tested with color blindness simulation (deuteranopia, protanopia, tritanopia)

### Dynamic Type
- [ ] All text responds to Dynamic Type size changes
- [ ] Tested at **xSmall** — nothing looks oversized or wasteful
- [ ] Tested at **AX5** (largest accessibility) — layout still functional
- [ ] No text truncated to meaninglessness at large sizes
- [ ] Information hierarchy preserved at all sizes (primary still looks primary)
- [ ] Horizontal layouts switch to vertical at `isAccessibilityCategory` sizes
- [ ] Icons scale with adjacent text (use SF Symbols or image scale)

### Bold Text
- [ ] App responds to **Bold Text** accessibility setting
- [ ] All text shifts to a heavier weight variant when Bold Text is on
- [ ] Custom fonts have bold variants available

## Motion

### Reduce Motion
- [ ] All slide/scale/zoom transitions replaced with cross-dissolves when Reduce Motion is on
- [ ] All bounce effects removed (damping = 1.0)
- [ ] Staggered reveals removed — content appears simultaneously with a single fade
- [ ] Parallax effects disabled
- [ ] Auto-playing animations stopped or reduced to static
- [ ] Layout animations that communicate state (disclosure, checkbox) still function

### Flashing
- [ ] No content flashes more than 3 times per second
- [ ] App responds to **Dim Flashing Lights** setting for video content

## Touch & Motor

### Touch Targets
- [ ] All interactive elements have minimum 44x44pt touch area (28x28pt absolute minimum)
- [ ] Minimum 8pt spacing between adjacent touch targets
- [ ] No gesture is the sole way to access a feature (button alternative exists)
- [ ] All custom gestures can be performed with a single finger
- [ ] Swipe actions have equivalent button alternatives (edit mode or context menu)

### Switch Control
- [ ] All interactive elements are reachable via Switch Control scanning
- [ ] Focus order is logical (reading order, top-to-bottom, leading-to-trailing)
- [ ] No timed interactions required (or adjustable timing available)

### Full Keyboard Access
- [ ] All interactive elements reachable via Tab key
- [ ] Tab order follows logical reading order
- [ ] Focus ring visible on all focused elements
- [ ] Enter/Space activates focused element
- [ ] Escape dismisses modals/sheets/popovers

## VoiceOver

### Labels
- [ ] Every interactive element has an accessibility label
- [ ] Labels are concise and descriptive ("Delete message" not "Trash can icon button")
- [ ] Labels don't include the element type ("Settings" not "Settings button" — VoiceOver adds "button" automatically)
- [ ] Decorative images marked as `isAccessibilityElement = false`
- [ ] Informational images have descriptive alt text

### Grouping
- [ ] Related elements grouped into single accessibility elements where appropriate (e.g., a cell with title + subtitle is one element with a combined label)
- [ ] Groups have a logical reading order
- [ ] Custom actions available for swipe-accessible features (VoiceOver custom actions rotor)

### Navigation
- [ ] VoiceOver can navigate every screen without getting trapped
- [ ] Modal views move VoiceOver focus to the modal on presentation
- [ ] Dismissing a modal returns focus to the triggering element
- [ ] Dynamic content updates announced via accessibility notifications
- [ ] Loading states announced ("Loading" / "Content loaded")

### Values & Traits
- [ ] Toggles announce their state ("on" / "off")
- [ ] Sliders announce current value and range
- [ ] Progress indicators announce progress
- [ ] Buttons with state changes update their labels (e.g., "Play" → "Pause")
- [ ] Adjustable elements (stepper, slider) use `.adjustable` trait with increment/decrement actions

## Content

### Text Alternatives
- [ ] All images have alt text or are marked decorative
- [ ] Charts and graphs have text summaries
- [ ] Audio content has captions or transcripts
- [ ] Video content has captions and audio descriptions available

### Readability
- [ ] No text smaller than 11pt (Caption 2)
- [ ] Avoid Ultralight/Thin/Light font weights for functional text
- [ ] Line length: 40-70 characters per line for body text (readability sweet spot)
- [ ] Sufficient leading (≥1.2x font size)

## Testing Process

### Required Tests
1. **VoiceOver walkthrough:** Navigate every screen with eyes closed. Is the experience coherent?
2. **Dynamic Type sweep:** Test at xSmall, default (Large), and AX5. Screenshots at each.
3. **Increase Contrast + Dark Mode:** All text legible?
4. **Reduce Motion:** All transitions graceful? No jarring jumps?
5. **Bold Text:** All text heavier? Nothing broken?
6. **Color blindness simulation:** All information still distinguishable?
7. **Keyboard navigation (iPad):** All elements reachable? Logical order?

### Tools
- **Xcode Accessibility Inspector:** Runtime audit, contrast checking, element inspection
- **VoiceOver (device):** Real screen reader testing — simulator doesn't cut it
- **Sim Daltonism (Mac):** Color blindness simulation overlay
- **Figma plugins:** Stark, A11y, Color Contrast Checker (design-time validation)

### When to Audit
- **Before every release:** Full checklist pass
- **During design:** Contrast and Dynamic Type checks on every new screen
- **During development:** VoiceOver and keyboard testing on every new view
- **On complaints:** If any user reports an accessibility issue, it's a P1 fix
