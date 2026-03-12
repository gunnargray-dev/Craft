import SwiftUI

struct BorderRadiusView: View {
    @State private var padding: CGFloat = 12
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private let innerRadius: CGFloat = CornerRadius.md

    private var concentricOuterRadius: CGFloat {
        CornerRadius.concentric(inner: innerRadius, padding: padding)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.lg) {
                // Explanation
                Text("Adjust padding to see how concentric radius keeps curves optically consistent, while a fixed radius creates visual tension.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, Spacing.systemMargin)
                    .enterAnimation(delay: 0)

                // Slider
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    HStack {
                        Text("Padding")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        Spacer()
                        Text("\(Int(padding))pt")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .monospacedDigit()
                    }

                    Slider(value: $padding, in: 0...40, step: 4)
                        .tint(.blue)
                }
                .padding(.horizontal, Spacing.systemMargin)
                .enterAnimation(delay: 0.05)

                // Spec readout
                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text("Inner radius: \(Int(innerRadius))pt")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("Concentric outer: \(Int(innerRadius))pt + \(Int(padding))pt = \(Int(concentricOuterRadius))pt")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, Spacing.systemMargin)
                .enterAnimation(delay: 0.1)

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
                .enterAnimation(delay: 0.15)
                .animation(reduceMotion ? .default : Springs.responsive, value: padding)
            }
            .padding(.vertical, Spacing.md)
        }
        .navigationTitle("Border Radius")
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
                    .foregroundStyle(isCorrect ? .green : .red)
                Text(title)
                    .font(.headline)
            }

            Text(subtitle)
                .font(.caption)
                .foregroundStyle(.secondary)

            // Visual demo
            ZStack {
                // Outer shape
                RoundedRectangle(cornerRadius: outerRadius)
                    .fill(Color(.tertiarySystemBackground))

                // Inner shape with padding
                RoundedRectangle(cornerRadius: innerRadius)
                    .fill(isCorrect ? .blue.opacity(0.15) : .red.opacity(0.15))
                    .padding(padding)
            }
            .frame(height: 160)
            .overlay(
                RoundedRectangle(cornerRadius: outerRadius)
                    .strokeBorder(
                        isCorrect ? .green.opacity(0.4) : .red.opacity(0.4),
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
