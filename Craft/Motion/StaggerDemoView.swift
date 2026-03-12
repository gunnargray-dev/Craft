import SwiftUI

struct StaggerDemoView: View {
    @State private var staggerDelay: Double = 0.06
    @State private var isShowing = false
    @State private var triggerID = UUID()
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private let cardColors: [Color] = [
        Color.blue600, Color.purple600, Color.pink600, Color.red600,
        Color.orange600, Color.yellow600, Color.green600, Color.teal600,
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.lg) {
                // MARK: - Controls
                controlsSection
                    .enterAnimation(delay: 0.0)

                // MARK: - Cards
                cardsSection
                    .id(triggerID)
            }
            .padding(.horizontal, Spacing.systemMargin)
            .padding(.vertical, Spacing.md)
        }
        .background(Color.bgBase)
        .navigationTitle("Stagger")
    }

    // MARK: - Controls

    private var controlsSection: some View {
        VStack(spacing: Spacing.md) {
            VStack(alignment: .leading, spacing: Spacing.xs) {
                HStack {
                    Text("Stagger Delay")
                        .font(PPFont.bodyMdStrong)
                    Spacer()
                    Text("\(String(format: "%.3f", staggerDelay))s")
                        .font(.subheadline.monospacedDigit())
                        .foregroundStyle(Color.fgSecondary)
                }

                Slider(value: $staggerDelay, in: 0.0...0.2, step: 0.005) {
                    Text("Stagger Delay")
                }
            }

            HStack(spacing: Spacing.sm) {
                CraftButton(
                    title: "Play",
                    level: .primary,
                    size: .medium,
                    icon: "play.fill",
                    isFullWidth: true
                ) {
                    playAnimation()
                }

                CraftButton(
                    title: "Reset",
                    level: .secondary,
                    size: .medium,
                    icon: "arrow.counterclockwise",
                    isFullWidth: true
                ) {
                    resetAnimation()
                }
            }
        }
        .padding(Spacing.md)
        .background(Color.bgRaised)
        .clipShape(RoundedRectangle(cornerRadius: CornerRadius.md, style: .continuous))
    }

    // MARK: - Cards

    private var cardsSection: some View {
        VStack(spacing: Spacing.sm) {
            ForEach(Array(cardColors.enumerated()), id: \.offset) { index, color in
                StaggerCard(
                    index: index,
                    color: color,
                    isShowing: isShowing,
                    delay: Double(index) * staggerDelay,
                    reduceMotion: reduceMotion
                )
            }
        }
    }

    private func playAnimation() {
        isShowing = false
        triggerID = UUID()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            withAnimation(reduceMotion ? .default : Springs.smooth) {
                isShowing = true
            }
        }
    }

    private func resetAnimation() {
        withAnimation(reduceMotion ? .default : .spring(response: 0.25, dampingFraction: 0.9)) {
            isShowing = false
        }
    }
}

// MARK: - Stagger Card

private struct StaggerCard: View {
    let index: Int
    let color: Color
    let isShowing: Bool
    let delay: Double
    let reduceMotion: Bool

    var body: some View {
        HStack(spacing: Spacing.sm) {
            RoundedRectangle(cornerRadius: CornerRadius.sm, style: .continuous)
                .fill(color.gradient)
                .frame(width: 44, height: 44)

            VStack(alignment: .leading, spacing: Spacing.xxs) {
                Text("Card \(index + 1)")
                    .font(PPFont.bodyLgStrong)
                Text("Delay: \(String(format: "%.3f", delay))s")
                    .font(PPFont.caption)
                    .foregroundStyle(Color.fgSecondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(PPFont.caption)
                .foregroundStyle(Color.fgTertiary)
        }
        .padding(Spacing.md)
        .background(Color.bgRaised)
        .clipShape(RoundedRectangle(cornerRadius: CornerRadius.md, style: .continuous))
        .shadowSmall()
        .opacity(isShowing ? 1 : 0)
        .offset(y: isShowing ? 0 : 20)
        .animation(
            reduceMotion ? .default : Springs.smooth.delay(delay),
            value: isShowing
        )
    }
}

#Preview {
    NavigationStack {
        StaggerDemoView()
    }
}
