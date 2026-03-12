import SwiftUI

struct ColorPaletteView: View {
    @State private var prefersDark = false
    @Environment(\.self) private var environment

    private let labelColors: [(name: String, color: Color)] = [
        ("label", Color(.label)),
        ("secondaryLabel", Color(.secondaryLabel)),
        ("tertiaryLabel", Color(.tertiaryLabel)),
        ("quaternaryLabel", Color(.quaternaryLabel)),
    ]

    private let backgroundColors: [(name: String, color: Color)] = [
        ("systemBackground", Color(.systemBackground)),
        ("secondarySystemBackground", Color(.secondarySystemBackground)),
        ("tertiarySystemBackground", Color(.tertiarySystemBackground)),
        ("systemGroupedBackground", Color(.systemGroupedBackground)),
    ]

    private let fillColors: [(name: String, color: Color)] = [
        ("separator", Color(.separator)),
        ("systemFill", Color(.systemFill)),
        ("secondarySystemFill", Color(.secondarySystemFill)),
        ("tertiarySystemFill", Color(.tertiarySystemFill)),
        ("quaternarySystemFill", Color(.quaternarySystemFill)),
    ]

    private let tintColors: [(name: String, color: Color)] = [
        ("systemRed", .red),
        ("systemBlue", .blue),
        ("systemGreen", .green),
        ("systemYellow", .yellow),
        ("systemOrange", .orange),
        ("systemPurple", .purple),
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.lg) {
                // Light/Dark toggle
                Picker("Appearance", selection: $prefersDark) {
                    Text("Light").tag(false)
                    Text("Dark").tag(true)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, Spacing.systemMargin)
                .enterAnimation(delay: 0)

                colorSection(title: "Labels", colors: labelColors, startDelay: 0.05)
                colorSection(title: "Backgrounds", colors: backgroundColors, startDelay: 0.15)
                colorSection(title: "Fills", colors: fillColors, startDelay: 0.25)
                colorSection(title: "Tints", colors: tintColors, startDelay: 0.35)
            }
            .padding(.vertical, Spacing.md)
        }
        .navigationTitle("Color Palette")
        .preferredColorScheme(prefersDark ? .dark : .light)
    }

    @ViewBuilder
    private func colorSection(title: String, colors: [(name: String, color: Color)], startDelay: Double) -> some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text(title)
                .sectionHeader()
                .enterAnimation(delay: startDelay)

            ForEach(Array(colors.enumerated()), id: \.offset) { index, item in
                colorRow(name: item.name, color: item.color)
                    .enterAnimation(delay: startDelay + Double(index) * 0.03)
            }
        }
    }

    private func colorRow(name: String, color: Color) -> some View {
        HStack(spacing: Spacing.md) {
            // Color swatch
            RoundedRectangle(cornerRadius: CornerRadius.sm)
                .fill(color)
                .frame(width: 44, height: 44)
                .overlay(
                    RoundedRectangle(cornerRadius: CornerRadius.sm)
                        .strokeBorder(Color(.separator), lineWidth: 0.5)
                )

            VStack(alignment: .leading, spacing: Spacing.xxs) {
                Text(name)
                    .font(.subheadline)
                    .fontWeight(.medium)

                // Live contrast ratio
                Text("CR: \(contrastRatioText(for: color))")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding(.horizontal, Spacing.systemMargin)
    }

    // MARK: - Contrast Calculation

    /// Compute approximate contrast ratio of the given color against the current background.
    private func contrastRatioText(for color: Color) -> String {
        let bgColor = prefersDark
            ? UIColor.black
            : UIColor.white

        let fgUIColor = UIColor(color)

        let fgLum = relativeLuminance(of: fgUIColor)
        let bgLum = relativeLuminance(of: bgColor)

        let lighter = max(fgLum, bgLum)
        let darker = min(fgLum, bgLum)

        let ratio = (lighter + 0.05) / (darker + 0.05)
        return String(format: "%.1f:1", ratio)
    }

    private func relativeLuminance(of color: UIColor) -> CGFloat {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: &a)

        func linearize(_ channel: CGFloat) -> CGFloat {
            channel <= 0.04045
                ? channel / 12.92
                : pow((channel + 0.055) / 1.055, 2.4)
        }

        return 0.2126 * linearize(r) + 0.7152 * linearize(g) + 0.0722 * linearize(b)
    }
}

#Preview {
    NavigationStack {
        ColorPaletteView()
    }
}
