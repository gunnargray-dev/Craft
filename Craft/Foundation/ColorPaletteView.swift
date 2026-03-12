import SwiftUI

struct ColorPaletteView: View {
    @State private var prefersDark = false
    @Environment(\.self) private var environment

    // MARK: - Semantic Colors

    private let fgColors: [(name: String, color: Color)] = [
        ("fgPrimary", Color.fgPrimary),
        ("fgSecondary", Color.fgSecondary),
        ("fgTertiary", Color.fgTertiary),
        ("fgInverse", Color.fgInverse),
    ]

    private let bgColors: [(name: String, color: Color)] = [
        ("bgBase", Color.bgBase),
        ("bgRaised", Color.bgRaised),
        ("bgSoft", Color.bgSoft),
        ("bgSubtle", Color.bgSubtle),
        ("bgInverse", Color.bgInverse),
    ]

    private let borderColors: [(name: String, color: Color)] = [
        ("borderHeavy", Color.borderHeavy),
        ("borderBase", Color.borderBase),
        ("borderSoft", Color.borderSoft),
        ("borderInverse", Color.borderInverse),
        ("borderFocus", Color.borderFocus),
    ]

    private let accentColors: [(name: String, color: Color)] = [
        ("accentFgPrimary", Color.accentFgPrimary),
        ("accentFgSecondary", Color.accentFgSecondary),
        ("accentBgBase", Color.accentBgBase),
        ("accentBgSubtle", Color.accentBgSubtle),
        ("accentBorderHeavy", Color.accentBorderHeavy),
        ("accentBorderSubtle", Color.accentBorderSubtle),
    ]

    private let statusColors: [(name: String, color: Color)] = [
        ("positiveFgPrimary", Color.positiveFgPrimary),
        ("positiveBgBase", Color.positiveBgBase),
        ("positiveBgSubtle", Color.positiveBgSubtle),
        ("negativeFgPrimary", Color.negativeFgPrimary),
        ("negativeBgBase", Color.negativeBgBase),
        ("negativeBgSubtle", Color.negativeBgSubtle),
        ("warningFgPrimary", Color.warningFgPrimary),
        ("warningBgBase", Color.warningBgBase),
        ("warningBgSubtle", Color.warningBgSubtle),
    ]

    // MARK: - Palette Colors

    private let grayScale: [(name: String, color: Color)] = [
        ("gray100", Color.gray100), ("gray200", Color.gray200), ("gray300", Color.gray300),
        ("gray400", Color.gray400), ("gray500", Color.gray500), ("gray600", Color.gray600),
        ("gray700", Color.gray700), ("gray800", Color.gray800), ("gray900", Color.gray900),
    ]

    private let redScale: [(name: String, color: Color)] = [
        ("red100", Color.red100), ("red200", Color.red200), ("red300", Color.red300),
        ("red400", Color.red400), ("red500", Color.red500), ("red600", Color.red600),
        ("red700", Color.red700), ("red800", Color.red800), ("red900", Color.red900),
    ]

    private let orangeScale: [(name: String, color: Color)] = [
        ("orange100", Color.orange100), ("orange200", Color.orange200), ("orange300", Color.orange300),
        ("orange400", Color.orange400), ("orange500", Color.orange500), ("orange600", Color.orange600),
        ("orange700", Color.orange700), ("orange800", Color.orange800), ("orange900", Color.orange900),
    ]

    private let yellowScale: [(name: String, color: Color)] = [
        ("yellow100", Color.yellow100), ("yellow200", Color.yellow200), ("yellow300", Color.yellow300),
        ("yellow400", Color.yellow400), ("yellow500", Color.yellow500), ("yellow600", Color.yellow600),
        ("yellow700", Color.yellow700), ("yellow800", Color.yellow800), ("yellow900", Color.yellow900),
    ]

    private let greenScale: [(name: String, color: Color)] = [
        ("green100", Color.green100), ("green200", Color.green200), ("green300", Color.green300),
        ("green400", Color.green400), ("green500", Color.green500), ("green600", Color.green600),
        ("green700", Color.green700), ("green800", Color.green800), ("green900", Color.green900),
    ]

    private let tealScale: [(name: String, color: Color)] = [
        ("teal100", Color.teal100), ("teal200", Color.teal200), ("teal300", Color.teal300),
        ("teal400", Color.teal400), ("teal500", Color.teal500), ("teal600", Color.teal600),
        ("teal700", Color.teal700), ("teal800", Color.teal800), ("teal900", Color.teal900),
    ]

    private let blueScale: [(name: String, color: Color)] = [
        ("blue100", Color.blue100), ("blue200", Color.blue200), ("blue300", Color.blue300),
        ("blue400", Color.blue400), ("blue500", Color.blue500), ("blue600", Color.blue600),
        ("blue700", Color.blue700), ("blue800", Color.blue800), ("blue900", Color.blue900),
    ]

    private let indigoScale: [(name: String, color: Color)] = [
        ("indigo100", Color.indigo100), ("indigo200", Color.indigo200), ("indigo300", Color.indigo300),
        ("indigo400", Color.indigo400), ("indigo500", Color.indigo500), ("indigo600", Color.indigo600),
        ("indigo700", Color.indigo700), ("indigo800", Color.indigo800), ("indigo900", Color.indigo900),
    ]

    private let purpleScale: [(name: String, color: Color)] = [
        ("purple100", Color.purple100), ("purple200", Color.purple200), ("purple300", Color.purple300),
        ("purple400", Color.purple400), ("purple500", Color.purple500), ("purple600", Color.purple600),
        ("purple700", Color.purple700), ("purple800", Color.purple800), ("purple900", Color.purple900),
    ]

    private let pinkScale: [(name: String, color: Color)] = [
        ("pink100", Color.pink100), ("pink200", Color.pink200), ("pink300", Color.pink300),
        ("pink400", Color.pink400), ("pink500", Color.pink500), ("pink600", Color.pink600),
        ("pink700", Color.pink700), ("pink800", Color.pink800), ("pink900", Color.pink900),
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

                // Semantic colors
                colorSection(title: "Foreground", colors: fgColors, startDelay: 0.05)
                colorSection(title: "Background", colors: bgColors, startDelay: 0.10)
                colorSection(title: "Border", colors: borderColors, startDelay: 0.15)
                colorSection(title: "Accent", colors: accentColors, startDelay: 0.20)
                colorSection(title: "Status", colors: statusColors, startDelay: 0.25)

                // Palette scales
                paletteSection(title: "Gray (Odin)", colors: grayScale, startDelay: 0.30)
                paletteSection(title: "Red (Ifrit)", colors: redScale, startDelay: 0.33)
                paletteSection(title: "Orange (Phoenix)", colors: orangeScale, startDelay: 0.36)
                paletteSection(title: "Yellow (Sylph)", colors: yellowScale, startDelay: 0.39)
                paletteSection(title: "Green (Garuda)", colors: greenScale, startDelay: 0.42)
                paletteSection(title: "Teal (Shiva)", colors: tealScale, startDelay: 0.45)
                paletteSection(title: "Blue (Leviathan)", colors: blueScale, startDelay: 0.48)
                paletteSection(title: "Indigo (Fenrir)", colors: indigoScale, startDelay: 0.51)
                paletteSection(title: "Purple (Ramuh)", colors: purpleScale, startDelay: 0.54)
                paletteSection(title: "Pink (Jenova)", colors: pinkScale, startDelay: 0.57)
            }
            .padding(.vertical, Spacing.md)
        }
        .background(Color.bgBase)
        .navigationTitle("Color Palette")
        .preferredColorScheme(prefersDark ? .dark : .light)
    }

    // MARK: - Semantic Color Section

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

    // MARK: - Palette Scale Section

    @ViewBuilder
    private func paletteSection(title: String, colors: [(name: String, color: Color)], startDelay: Double) -> some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text(title)
                .sectionHeader()
                .enterAnimation(delay: startDelay)

            // Compact horizontal swatch strip
            HStack(spacing: 0) {
                ForEach(Array(colors.enumerated()), id: \.offset) { _, item in
                    Rectangle()
                        .fill(item.color)
                        .frame(height: 44)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: CornerRadius.sm))
            .overlay(
                RoundedRectangle(cornerRadius: CornerRadius.sm)
                    .strokeBorder(Color.borderBase, lineWidth: 0.5)
            )
            .padding(.horizontal, Spacing.systemMargin)
            .enterAnimation(delay: startDelay + 0.02)

            // Labels row
            HStack(spacing: 0) {
                ForEach(Array(colors.enumerated()), id: \.offset) { _, item in
                    Text(String(item.name.suffix(3)))
                        .font(PPFont.caption)
                        .foregroundStyle(Color.fgTertiary)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal, Spacing.systemMargin)
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
                        .strokeBorder(Color.borderBase, lineWidth: 0.5)
                )

            VStack(alignment: .leading, spacing: Spacing.xxs) {
                Text(name)
                    .font(PPFont.bodyMd)
                    .fontWeight(.medium)

                // Live contrast ratio
                Text("CR: \(contrastRatioText(for: color))")
                    .font(PPFont.caption)
                    .foregroundStyle(Color.fgSecondary)
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
