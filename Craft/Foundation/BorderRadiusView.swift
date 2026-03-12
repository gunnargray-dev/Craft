import SwiftUI

struct BorderRadiusView: View {
    @State private var padding: CGFloat = 12
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private let innerRadius: CGFloat = CornerRadius.md

    private var concentricOuterRadius: CGFloat {
        CornerRadius.concentric(inner: innerRadius, padding: padding)
    }

    private let radiusTokens: [(name: String, value: CGFloat)] = [
        ("xs", CornerRadius.xs),
        ("sm", CornerRadius.sm),
        ("md", CornerRadius.md),
        ("lg", CornerRadius.lg),
        ("xl", CornerRadius.xl),
        ("xxl", CornerRadius.xxl),
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.lg) {
                // Radius token showcase
                Text("Radius Tokens")
                    .sectionHeader()
                    .enterAnimation(delay: 0)

                VStack(spacing: Spacing.sm) {
                    ForEach(Array(radiusTokens.enumerated()), id: \.offset) { index, token in
                        radiusRow(name: token.name, value: token.value)
                            .enterAnimation(delay: Double(index) * 0.04 + 0.02)
                    }
                }
                .padding(.horizontal, Spacing.systemMargin)

                // Explanation
                Text("Adjust padding to see how concentric radius keeps curves optically consistent, while a fixed radius creates visual tension.")
                    .font(PPFont.bodyMd)
                    .foregroundStyle(Color.fgSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, Spacing.systemMargin)
                    .enterAnimation(delay: 0.3)

                // Slider
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    HStack {
                        Text("Padding")
                            .font(PPFont.bodyMd)
                            .fontWeight(.medium)
                        Spacer()
                        Text("\(Int(padding))pt")
                            .font(PPFont.bodyMd)
                            .foregroundStyle(Color.fgSecondary)
                            .monospacedDigit()
                    }

                    Slider(value: $padding, in: 0...40, step: 4)
                        .tint(Color.accentFgPrimary)
                }
                .padding(.horizontal, Spacing.systemMargin)
                .enterAnimation(delay: 0.35)

                // Spec readout
                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text("Inner radius: \(Int(innerRadius))pt")
                        .font(PPFont.caption)
                        .foregroundStyle(Color.fgSecondary)
                    Text("Concentric outer: \(Int(innerRadius))pt + \(Int(padding))pt = \(Int(concentricOuterRadius))pt")
                        .font(PPFont.caption)
                        .foregroundStyle(Color.fgSecondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, Spacing.systemMargin)
                .enterAnimation(delay: 0.4)

                // Side-by-side comparison
                HStack(alignment: .top, spacing: Spacing.md) {
                    comparisonBox(
                        title: "Concentric",
                        subtitle: "outer = inner + padding",
                        outerRadius: concentricOuterRadius,
                        isCorrect: true
                    )

                    comparisonBox(
                        title: "Mismatched",
                        subtitle: "outer = inner (same)",
                        outerRadius: innerRadius,
                        isCorrect: false
                    )
                }
                .padding(.horizontal, Spacing.systemMargin)
                .enterAnimation(delay: 0.45)
                .animation(reduceMotion ? .default : Springs.responsive, value: padding)
            }
            .padding(.vertical, Spacing.md)
        }
        .background(Color.bgBase)
        .navigationTitle("Border Radius")
    }

    // MARK: - Radius Token Row

    private func radiusRow(name: String, value: CGFloat) -> some View {
        HStack(spacing: Spacing.md) {
            // Rounded shape preview
            RoundedRectangle(cornerRadius: value)
                .fill(Color.accentBgSubtle)
                .overlay(
                    RoundedRectangle(cornerRadius: value)
                        .strokeBorder(Color.accentFgPrimary, lineWidth: 1.5)
                )
                .frame(width: 44, height: 44)

            VStack(alignment: .leading, spacing: Spacing.xxs) {
                Text(name)
                    .font(PPFont.bodyMd)
                    .fontWeight(.medium)
                Text("\(Int(value))pt")
                    .font(PPFont.caption)
                    .foregroundStyle(Color.fgSecondary)
            }

            Spacer()
        }
        .frame(minHeight: 44)
    }

    // MARK: - Comparison Box

    private func comparisonBox(
        title: String,
        subtitle: String,
        outerRadius: CGFloat,
        isCorrect: Bool
    ) -> some View {
        VStack(spacing: Spacing.sm) {
            // Label
            HStack(spacing: Spacing.xxs) {
                Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .foregroundStyle(isCorrect ? Color.positiveFgPrimary : Color.negativeFgPrimary)
                Text(title)
                    .font(PPFont.section)
            }

            Text(subtitle)
                .font(PPFont.caption)
                .foregroundStyle(Color.fgSecondary)

            // Visual demo
            ZStack {
                // Outer shape
                RoundedRectangle(cornerRadius: outerRadius)
                    .fill(Color.bgSoft)

                // Inner shape with padding
                RoundedRectangle(cornerRadius: innerRadius)
                    .fill(isCorrect ? Color.accentFgPrimary.opacity(0.15) : Color.negativeFgPrimary.opacity(0.15))
                    .padding(padding)
            }
            .frame(height: 160)
            .overlay(
                RoundedRectangle(cornerRadius: outerRadius)
                    .strokeBorder(
                        isCorrect ? Color.positiveFgPrimary.opacity(0.4) : Color.negativeFgPrimary.opacity(0.4),
                        lineWidth: 1.5
                    )
            )
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    NavigationStack {
        BorderRadiusView()
    }
}
