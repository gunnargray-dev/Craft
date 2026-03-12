import SwiftUI

// MARK: - Button Hierarchy

enum CraftButtonLevel {
    case primary
    case secondary
    case tertiary
    case destructive
}

enum CraftButtonSize: CaseIterable {
    case small
    case medium
    case large
    case extraLarge

    var verticalPadding: CGFloat {
        switch self {
        case .small: 8
        case .medium: 12
        case .large: 16
        case .extraLarge: 20
        }
    }

    var horizontalPadding: CGFloat {
        switch self {
        case .small: 16
        case .medium: 20
        case .large: 24
        case .extraLarge: 32
        }
    }

    var font: Font {
        switch self {
        case .small: PPFont.bodyMdStrong
        case .medium: PPFont.bodyLgStrong
        case .large: PPFont.bodyLgStrong
        case .extraLarge: PPFont.section
        }
    }

    var cornerRadius: CGFloat {
        switch self {
        case .small: CornerRadius.lg
        case .medium: CornerRadius.xl
        case .large: CornerRadius.xl
        case .extraLarge: CornerRadius.xxl
        }
    }

    var minHeight: CGFloat {
        switch self {
        case .small: 36
        case .medium: 44
        case .large: 52
        case .extraLarge: 60
        }
    }
}

struct CraftButton: View {
    let title: String
    let level: CraftButtonLevel
    var size: CraftButtonSize = .medium
    var icon: String? = nil
    var isFullWidth: Bool = false
    var action: () -> Void

    @GestureState private var isPressed = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        HStack(spacing: Spacing.xs) {
            if let icon {
                Image(systemName: icon)
                    .font(size.font)
            }
            Text(title)
                .font(size.font)
        }
        .foregroundStyle(foregroundColor)
        .padding(.horizontal, size.horizontalPadding)
        .padding(.vertical, size.verticalPadding)
        .frame(maxWidth: isFullWidth ? .infinity : nil)
        .frame(minHeight: size.minHeight)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: size.cornerRadius, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: size.cornerRadius, style: .continuous)
                .strokeBorder(borderColor, lineWidth: level == .secondary ? 1.5 : 0)
        )
        .shadowSmall()
        .scaleEffect(isPressed ? 0.97 : 1.0)
        .opacity(isPressed ? 0.9 : 1.0)
        .animation(reduceMotion ? .default : Springs.snappy, value: isPressed)
        .contentShape(RoundedRectangle(cornerRadius: size.cornerRadius, style: .continuous))
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
        .accessibilityAddTraits(.isButton)
    }

    private var foregroundColor: Color {
        switch level {
        case .primary: .fgInverse
        case .secondary: .accentFgPrimary
        case .tertiary: .accentFgPrimary
        case .destructive: .fgInverse
        }
    }

    private var backgroundColor: Color {
        switch level {
        case .primary: .accentBgBase
        case .secondary: .clear
        case .tertiary: .bgSoft
        case .destructive: .negativeBgBase
        }
    }

    private var borderColor: Color {
        switch level {
        case .secondary: .accentBorderSubtle
        default: .clear
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        CraftButton(title: "Primary", level: .primary, size: .large) {}
        CraftButton(title: "Secondary", level: .secondary, size: .large) {}
        CraftButton(title: "Tertiary", level: .tertiary, size: .medium) {}
        CraftButton(title: "Delete", level: .destructive, size: .medium, icon: "trash") {}
    }
    .padding()
}
