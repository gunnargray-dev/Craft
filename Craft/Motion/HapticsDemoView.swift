import SwiftUI

struct HapticType: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let icon: String
    let fire: () -> Void
}

struct HapticsDemoView: View {
    private let haptics: [HapticType] = {
        var list: [HapticType] = []

        list.append(HapticType(
            name: "Impact (Light)",
            description: "Subtle physical feedback, like a UI element snapping into place.",
            icon: "hand.tap"
        ) {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.prepare()
            generator.impactOccurred()
        })

        list.append(HapticType(
            name: "Impact (Medium)",
            description: "Moderate feedback for standard interactions like toggling a switch.",
            icon: "hand.tap.fill"
        ) {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.prepare()
            generator.impactOccurred()
        })

        list.append(HapticType(
            name: "Impact (Heavy)",
            description: "Strong feedback for significant actions like dropping an item.",
            icon: "hand.point.up.braille.fill"
        ) {
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.prepare()
            generator.impactOccurred()
        })

        list.append(HapticType(
            name: "Impact (Rigid)",
            description: "Sharp, precise tap for crisp mechanical interactions.",
            icon: "diamond.fill"
        ) {
            let generator = UIImpactFeedbackGenerator(style: .rigid)
            generator.prepare()
            generator.impactOccurred()
        })

        list.append(HapticType(
            name: "Impact (Soft)",
            description: "Gentle, cushioned impact for softer visual transitions.",
            icon: "circle.fill"
        ) {
            let generator = UIImpactFeedbackGenerator(style: .soft)
            generator.prepare()
            generator.impactOccurred()
        })

        list.append(HapticType(
            name: "Notification (Success)",
            description: "Confirms a task completed successfully. Double pulse.",
            icon: "checkmark.circle.fill"
        ) {
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(.success)
        })

        list.append(HapticType(
            name: "Notification (Warning)",
            description: "Alerts the user to a potential issue requiring attention.",
            icon: "exclamationmark.triangle.fill"
        ) {
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(.warning)
        })

        list.append(HapticType(
            name: "Notification (Error)",
            description: "Signals that an action failed or an error occurred.",
            icon: "xmark.circle.fill"
        ) {
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(.error)
        })

        list.append(HapticType(
            name: "Selection",
            description: "Light tick for scrolling through options like a picker.",
            icon: "line.3.horizontal"
        ) {
            let generator = UISelectionFeedbackGenerator()
            generator.prepare()
            generator.selectionChanged()
        })

        return list
    }()

    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.xs) {
                ForEach(Array(haptics.enumerated()), id: \.element.id) { index, haptic in
                    HapticRow(haptic: haptic)
                        .enterAnimation(delay: Double(index) * 0.03)
                }
            }
            .padding(.horizontal, Spacing.systemMargin)
            .padding(.vertical, Spacing.md)
        }
        .background(Color.bgBase)
        .navigationTitle("Haptics")
    }
}

// MARK: - Haptic Row

private struct HapticRow: View {
    let haptic: HapticType
    @State private var didTap = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        HStack(spacing: Spacing.sm) {
            Image(systemName: haptic.icon)
                .font(PPFont.section)
                .foregroundStyle(Color.accentFgPrimary)
                .frame(width: 44, height: 44)
                .background(Color.accentFgPrimary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: CornerRadius.sm, style: .continuous))

            VStack(alignment: .leading, spacing: Spacing.xxs) {
                Text(haptic.name)
                    .font(PPFont.bodyLgStrong)
                Text(haptic.description)
                    .font(PPFont.caption)
                    .foregroundStyle(Color.fgSecondary)
                    .lineLimit(2)
            }

            Spacer(minLength: Spacing.xs)

            Image(systemName: "play.circle.fill")
                .font(PPFont.title)
                .foregroundStyle(Color.accentFgPrimary)
                .symbolEffect(.bounce, value: didTap)
        }
        .padding(Spacing.sm)
        .frame(minHeight: 44)
        .background(Color.bgRaised)
        .clipShape(RoundedRectangle(cornerRadius: CornerRadius.md, style: .continuous))
        .contentShape(RoundedRectangle(cornerRadius: CornerRadius.md, style: .continuous))
        .pressEffect {
            haptic.fire()
            didTap.toggle()
        }
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel("Play \(haptic.name) haptic")
    }
}

#Preview {
    NavigationStack {
        HapticsDemoView()
    }
}
