import SwiftUI

struct ContrastCheckerView: View {
    @State private var foregroundColor: Color = .black
    @State private var backgroundColor: Color = .white
    @State private var contrastRatio: Double = 21.0

    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.lg) {
                // Preview
                previewSection
                    .enterAnimation(delay: 0.0)

                // Contrast Result
                resultSection
                    .enterAnimation(delay: 0.05)

                // Color Pickers
                pickersSection
                    .enterAnimation(delay: 0.1)

                // WCAG Badges
                badgesSection
                    .enterAnimation(delay: 0.15)
            }
            .padding(.horizontal, Spacing.systemMargin)
            .padding(.top, Spacing.sm)
            .padding(.bottom, Spacing.xxl)
        }
        .navigationTitle("Contrast Checker")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: foregroundColor) { _, _ in updateRatio() }
        .onChange(of: backgroundColor) { _, _ in updateRatio() }
    }

    // MARK: - Preview Section

    private var previewSection: some View {
        VStack(spacing: Spacing.sm) {
            Text("Preview")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
                .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: Spacing.sm) {
                Text("The quick brown fox jumps over the lazy dog.")
                    .font(.title3)
                    .fontWeight(.semibold)

                Text("This sample text demonstrates how your chosen foreground color appears on the selected background. Check the contrast ratio below to ensure readability.")
                    .font(.body)

                Text("Caption text — 12pt")
                    .font(.caption)
            }
            .foregroundStyle(foregroundColor)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(Spacing.lg)
            .background(backgroundColor, in: RoundedRectangle(cornerRadius: CornerRadius.lg))
            .overlay(
                RoundedRectangle(cornerRadius: CornerRadius.lg)
                    .strokeBorder(.primary.opacity(0.1), lineWidth: 1)
            )
        }
    }

    // MARK: - Result Section

    private var resultSection: some View {
        VStack(spacing: Spacing.xs) {
            Text("Contrast Ratio")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
                .textCase(.uppercase)

            Text(String(format: "%.2f : 1", contrastRatio))
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.bold)
                .foregroundStyle(.primary)
                .contentTransition(.numericText(value: contrastRatio))
                .animation(Springs.snappy, value: contrastRatio)
        }
        .frame(maxWidth: .infinity)
        .padding(Spacing.lg)
        .background(.background, in: RoundedRectangle(cornerRadius: CornerRadius.lg))
        .shadowSmall()
    }

    // MARK: - Pickers Section

    private var pickersSection: some View {
        VStack(spacing: Spacing.md) {
            ColorPicker(selection: $foregroundColor, supportsOpacity: false) {
                Label("Foreground", systemImage: "textformat")
                    .font(.body)
            }
            .frame(minHeight: 44)

            ColorPicker(selection: $backgroundColor, supportsOpacity: false) {
                Label("Background", systemImage: "rectangle.fill")
                    .font(.body)
            }
            .frame(minHeight: 44)

            Button {
                let temp = foregroundColor
                foregroundColor = backgroundColor
                backgroundColor = temp
            } label: {
                Label("Swap Colors", systemImage: "arrow.up.arrow.down")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: 44)
            }
            .buttonStyle(.bordered)
            .pressEffect()
        }
        .padding(Spacing.md)
        .background(.background, in: RoundedRectangle(cornerRadius: CornerRadius.lg))
        .shadowSmall()
    }

    // MARK: - WCAG Badges

    private var badgesSection: some View {
        VStack(spacing: Spacing.sm) {
            Text("WCAG Compliance")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: Spacing.sm) {
                WCAGBadge(
                    level: "AA",
                    subtitle: "Normal Text",
                    passes: contrastRatio >= 4.5
                )

                WCAGBadge(
                    level: "AA",
                    subtitle: "Large Text",
                    passes: contrastRatio >= 3.0
                )
            }

            HStack(spacing: Spacing.sm) {
                WCAGBadge(
                    level: "AAA",
                    subtitle: "Normal Text",
                    passes: contrastRatio >= 7.0
                )

                WCAGBadge(
                    level: "AAA",
                    subtitle: "Large Text",
                    passes: contrastRatio >= 4.5
                )
            }
        }
    }

    // MARK: - Helpers

    private func updateRatio() {
        let fgLum = relativeLuminance(of: foregroundColor)
        let bgLum = relativeLuminance(of: backgroundColor)
        let lighter = max(fgLum, bgLum)
        let darker = min(fgLum, bgLum)
        contrastRatio = (lighter + 0.05) / (darker + 0.05)
    }

    private func relativeLuminance(of color: Color) -> Double {
        let resolved = UIColor(color)
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        resolved.getRed(&r, green: &g, blue: &b, alpha: &a)

        let rLin = linearize(Double(r))
        let gLin = linearize(Double(g))
        let bLin = linearize(Double(b))

        return 0.2126 * rLin + 0.7152 * gLin + 0.0722 * bLin
    }

    private func linearize(_ sRGB: Double) -> Double {
        if sRGB <= 0.04045 {
            return sRGB / 12.92
        } else {
            return pow((sRGB + 0.055) / 1.055, 2.4)
        }
    }
}

// MARK: - WCAG Badge

private struct WCAGBadge: View {
    let level: String
    let subtitle: String
    let passes: Bool

    var body: some View {
        HStack(spacing: Spacing.sm) {
            Image(systemName: passes ? "checkmark.circle.fill" : "xmark.circle.fill")
                .font(.title2)
                .foregroundStyle(passes ? .green : .red)

            VStack(alignment: .leading, spacing: 2) {
                Text(level)
                    .font(.headline)
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer(minLength: 0)

            Text(passes ? "Pass" : "Fail")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(passes ? .green : .red)
                .padding(.horizontal, Spacing.xs)
                .padding(.vertical, Spacing.xxs)
                .background(
                    (passes ? Color.green : Color.red).opacity(0.12),
                    in: RoundedRectangle(cornerRadius: CornerRadius.sm)
                )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Spacing.sm)
        .background(.background, in: RoundedRectangle(cornerRadius: CornerRadius.md))
        .shadowSmall()
        .contentTransition(.symbolEffect(.replace))
        .animation(Springs.snappy, value: passes)
    }
}

#Preview {
    NavigationStack {
        ContrastCheckerView()
    }
}
