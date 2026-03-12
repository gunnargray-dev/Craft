import SwiftUI

struct SpacingRulerView: View {
    private let tokens: [(name: String, value: CGFloat)] = [
        ("xxs", Spacing.xxs),
        ("xs", Spacing.xs),
        ("sm", Spacing.sm),
        ("md", Spacing.md),
        ("lg", Spacing.lg),
        ("xl", Spacing.xl),
        ("xxl", Spacing.xxl),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.lg) {
                // MARK: - Ruler Section
                Text("Spacing Scale")
                    .sectionHeader()
                    .enterAnimation(delay: 0)

                VStack(alignment: .leading, spacing: Spacing.sm) {
                    ForEach(Array(tokens.enumerated()), id: \.offset) { index, token in
                        spacingRow(name: token.name, value: token.value)
                            .enterAnimation(delay: Double(index) * 0.05 + 0.05)
                    }
                }
                .padding(.horizontal, Spacing.systemMargin)

                // MARK: - Example Usage Section
                Text("Example Usage")
                    .sectionHeader()
                    .enterAnimation(delay: 0.45)

                exampleCard
                    .padding(.horizontal, Spacing.systemMargin)
                    .enterAnimation(delay: 0.5)
            }
            .padding(.bottom, Spacing.xl)
        }
        .navigationTitle("Spacing")
    }

    // MARK: - Spacing Row

    private func spacingRow(name: String, value: CGFloat) -> some View {
        HStack(spacing: Spacing.md) {
            // Name + value label
            HStack(spacing: Spacing.xxs) {
                Text(name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .frame(width: 36, alignment: .leading)
                Text("\(Int(value))pt")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .frame(width: 32, alignment: .trailing)
            }

            // Colored bar
            RoundedRectangle(cornerRadius: CornerRadius.sm / 2)
                .fill(.blue.gradient)
                .frame(width: value * 3, height: 24)

            Spacer()
        }
        .frame(minHeight: 44)
    }

    // MARK: - Example Card

    private var exampleCard: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header group — tight spacing
            VStack(alignment: .leading, spacing: Spacing.xxs) {
                Text("Card Title")
                    .font(.headline)
                Text("Subtitle text")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            // Gap between groups
            Spacer()
                .frame(height: Spacing.md)

            // Body group
            Text("Related items are grouped with small spacing (xxs, xs). Separate groups use larger spacing (md, lg) for visual hierarchy.")
                .font(.body)
                .foregroundStyle(.secondary)

            Spacer()
                .frame(height: Spacing.lg)

            // Action group
            HStack(spacing: Spacing.sm) {
                exampleButton(title: "Primary")
                exampleButton(title: "Secondary")
            }
        }
        .padding(Spacing.md)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: CornerRadius.md)
                .fill(Color(.secondarySystemBackground))
        )
        .shadowSmall()
        .overlay(alignment: .topTrailing) {
            annotationStack
        }
    }

    private func exampleButton(title: String) -> some View {
        Text(title)
            .font(.subheadline)
            .fontWeight(.medium)
            .padding(.horizontal, Spacing.md)
            .padding(.vertical, Spacing.xs)
            .background(
                RoundedRectangle(cornerRadius: CornerRadius.sm)
                    .fill(.blue.opacity(0.12))
            )
    }

    // MARK: - Annotation overlay

    private var annotationStack: some View {
        VStack(alignment: .trailing, spacing: Spacing.xxs) {
            annotationLabel("xxs (4pt) within group")
            annotationLabel("md (16pt) between groups")
            annotationLabel("lg (24pt) before actions")
        }
        .padding(Spacing.xs)
    }

    private func annotationLabel(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 9, weight: .medium, design: .monospaced))
            .foregroundStyle(.secondary)
            .padding(.horizontal, Spacing.xxs)
            .padding(.vertical, 2)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(.tertiarySystemBackground))
            )
    }
}

#Preview {
    NavigationStack {
        SpacingRulerView()
    }
}
