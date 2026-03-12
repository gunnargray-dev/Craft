# Motion Patterns

## Decision Framework

Before adding motion, answer these three questions:

1. **Does this motion communicate something?** If removing it makes the action confusing, it's structural. Keep it. If removing it changes nothing, cut it.
2. **How often does this interaction happen?** High-frequency = restrained or no animation. Low-frequency = opportunity for delight.
3. **Can the user interrupt it?** If yes (and they should be able to), use interruptible transitions, not keyframe sequences.

## Spring Configurations

Springs are the default for iOS. Never use linear or ease-in-out for interactive elements.

### Standard Springs (by context)

| Context | Response | Damping | Use For |
|---|---|---|---|
| **Snappy** | 0.3 | 0.7 | Button press, toggle, small state changes |
| **Responsive** | 0.4 | 0.75 | Sheet presentation, card expansion |
| **Smooth** | 0.5 | 0.8 | Navigation transitions, tray reveals |
| **Gentle** | 0.6 | 0.85 | Background element repositioning |
| **Bouncy** | 0.5 | 0.6 | Completion celebrations, low-frequency delight |

### Rules
- **Zero bounce for frequent interactions.** Damping ≥ 0.8 for anything users do more than a few times per session.
- **Bounce for achievement moments.** Damping 0.5-0.65 for completion states, success confirmations, rare reveals.
- **Match gesture velocity.** Spring initial velocity should match the user's gesture velocity at release. This is what makes drag-to-dismiss feel physical.

## Transition Patterns

### Enter Animations
- Combine **opacity + translateY + blur** for reveals.
- Translate from logical origin: sheets from bottom, menus from their trigger, alerts from center.
- Duration: 0.3-0.45s for structural transitions.

### Exit Animations
- **Quieter than enters.** Fixed small offset (-12pt translateY), not full height.
- Faster than enters: ~0.25s.
- Opacity fades to 0, slight directional hint preserved.
- If an element will reappear in the same position, fade only — no translation.

### Asymmetry Rule
Enters demand attention (full motion). Exits yield it (subtle motion). This isn't symmetrical and shouldn't be.

## Staggered Reveals

Break content into semantic chunks. Animate each with a small delay.

### Timing
- **Between chunks:** 60-100ms stagger.
- **Within a chunk (e.g., words in a title):** 40-80ms stagger.
- **Maximum total stagger duration:** 400ms. If you have 8 items at 80ms, the last item starts at 560ms — too long. Reduce per-item delay or group items.

### What to Stagger
- Title, subtitle, body, action buttons — each a separate chunk.
- List items entering view (limit to 4-6 visible items, not the entire list).
- Dashboard cards on initial load.

### What NOT to Stagger
- Items already visible during a state change (they stay put).
- Navigation transitions (the whole view moves together).
- Any animation the user will see more than 2-3 times per session.

## Component Continuity

### Shared Element Transitions
When an element persists between two states, it should travel — not disappear and reappear.

- Card thumbnail → detail view hero image: animate frame, corner radius, and shadow.
- Button label morphing (Continue → Confirm): shared letters anchor the transition.
- Tab bar icon → selected state: icon stays in place, fill/weight changes.

### Rules
- **Never re-animate what's already there.** If a component doesn't change between states, it holds position. Zero motion.
- **Animate only what changed.** If only the title updates, only the title animates. The rest of the view is still.
- **Preserve scroll position** during state transitions unless the transition explicitly changes the scroll context.

## Gesture-Driven Motion

### Direct Manipulation
- Dragged elements track the finger exactly (1:1 mapping) during the gesture.
- Spring-to-destination on release. Never snap.
- Rubber-band at boundaries: displacement = offset / (1 + abs(offset) / limit).

### Velocity Continuation
- On gesture release, the element's velocity should continue into the spring animation.
- Swipe-to-dismiss threshold: velocity > 500pt/s OR displacement > 50% of container.
- Below threshold: spring back to origin.

## Reduce Motion

When the Reduce Motion accessibility setting is active:

- Replace slide/scale transitions with **cross-dissolve** (opacity fade).
- Remove all bounce (damping = 1.0).
- Remove staggered reveals — show all content simultaneously with a single fade.
- Remove parallax and depth-based motion.
- Keep haptic feedback — it's separate from visual motion.
- Keep layout animations that communicate state (disclosure triangles, checkbox fills).

## The Delight-Impact Curve

```
Delight Potential
      │
  High│         ★ Account creation success
      │       ★ First-time feature discovery
      │     ★ Achievement unlocked
      │   ★ Pull-to-refresh
      │ ★ Tab switch
  Low │★ Keyboard appearance
      └──────────────────────────────
       High ←── Usage Frequency ──→ Low
```

- **High-frequency features:** Maximum restraint. The keyboard appearing 100x/day with a bouncy animation would be maddening.
- **Low-frequency features:** Permission to surprise. Confetti on backup completion. Sound design on destructive action confirmation.
- **The sweet spot:** Features used 1-5x per session. Pull-to-refresh, share sheet, mode switches. Subtle but noticeable.
