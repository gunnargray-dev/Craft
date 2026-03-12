import SwiftUI

// MARK: - Spacing (4pt grid)

enum Spacing {
    static let xxs: CGFloat = 4
    static let xs: CGFloat = 8
    static let sm: CGFloat = 12
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
    static let xxl: CGFloat = 48

    static let systemMargin: CGFloat = 16
}

// MARK: - Corner Radius

enum CornerRadius {
    static let sm: CGFloat = 8
    static let md: CGFloat = 12
    static let lg: CGFloat = 16
    static let xl: CGFloat = 20
    static let full: CGFloat = 999

    /// Concentric radius: outer = inner + padding
    static func concentric(inner: CGFloat, padding: CGFloat) -> CGFloat {
        inner + padding
    }
}

// MARK: - Shadows (Three-tier system)

struct ShadowToken {
    let color: Color
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat
}

enum Shadows {
    static let small = ShadowToken(
        color: .black.opacity(0.06),
        radius: 2,
        x: 0,
        y: 1
    )
    static let medium = ShadowToken(
        color: .black.opacity(0.1),
        radius: 8,
        x: 0,
        y: 4
    )
    static let large = ShadowToken(
        color: .black.opacity(0.15),
        radius: 20,
        x: 0,
        y: 8
    )
}

extension View {
    func shadowSmall() -> some View {
        shadow(color: Shadows.small.color, radius: Shadows.small.radius, x: Shadows.small.x, y: Shadows.small.y)
    }

    func shadowMedium() -> some View {
        shadow(color: Shadows.medium.color, radius: Shadows.medium.radius, x: Shadows.medium.x, y: Shadows.medium.y)
    }

    func shadowLarge() -> some View {
        shadow(color: Shadows.large.color, radius: Shadows.large.radius, x: Shadows.large.x, y: Shadows.large.y)
    }
}

// MARK: - Spring Animations

enum Springs {
    /// Snappy: button press, toggles
    static let snappy = Animation.spring(response: 0.3, dampingFraction: 0.7)
    /// Responsive: sheet presentation
    static let responsive = Animation.spring(response: 0.4, dampingFraction: 0.75)
    /// Smooth: navigation transitions
    static let smooth = Animation.spring(response: 0.5, dampingFraction: 0.8)
}

// MARK: - Press Effect Modifier

struct PressEffect: ViewModifier {
    @GestureState private var isPressed = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var action: () -> Void

    func body(content: Content) -> some View {
        content
            .scaleEffect(isPressed ? 0.97 : 1.0)
            .animation(reduceMotion ? .default : Springs.snappy, value: isPressed)
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .updating($isPressed) { _, state, _ in
                        state = true
                    }
                    .onEnded { value in
                        if abs(value.translation.width) < 20 && abs(value.translation.height) < 20 {
                            action()
                        }
                    }
            )
    }
}

extension View {
    func pressEffect(action: @escaping () -> Void = {}) -> some View {
        modifier(PressEffect(action: action))
    }
}

// MARK: - Enter Animation Modifier

struct EnterAnimation: ViewModifier {
    let delay: Double
    @State private var appeared = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View {
        content
            .opacity(appeared ? 1 : 0)
            .offset(y: appeared ? 0 : 20)
            .blur(radius: appeared ? 0 : 4)
            .animation(
                reduceMotion ? .default : Springs.smooth.delay(delay),
                value: appeared
            )
            .onAppear {
                appeared = true
            }
    }
}

extension View {
    func enterAnimation(delay: Double = 0) -> some View {
        modifier(EnterAnimation(delay: delay))
    }
}

// MARK: - Section Header Style

struct SectionHeaderStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundStyle(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, Spacing.systemMargin)
            .padding(.top, Spacing.lg)
            .padding(.bottom, Spacing.xs)
    }
}

extension View {
    func sectionHeader() -> some View {
        modifier(SectionHeaderStyle())
    }
}
