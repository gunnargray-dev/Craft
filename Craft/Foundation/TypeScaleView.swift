import SwiftUI

struct TypeScaleView: View {
    private let styles: [(name: String, font: Font, spec: PPTypographyToken.Spec)] = [
        ("Hero", PPFont.hero, PPTypographyToken.uiHeadingHero),
        ("Display", PPFont.display, PPTypographyToken.uiHeadingDisplay),
        ("Headline", PPFont.headline, PPTypographyToken.uiHeadingHeadline),
        ("Title", PPFont.title, PPTypographyToken.uiHeadingTitle),
        ("Section", PPFont.section, PPTypographyToken.uiHeadingSection),
        ("Body Lg", PPFont.bodyLg, PPTypographyToken.uiTextBodyLgNormal),
        ("Body Lg Strong", PPFont.bodyLgStrong, PPTypographyToken.uiTextBodyLgStrong),
        ("Body Md", PPFont.bodyMd, PPTypographyToken.uiTextBodyMdNormal),
        ("Body Md Strong", PPFont.bodyMdStrong, PPTypographyToken.uiTextBodyMdStrong),
        ("Code Md", PPFont.codeMd, PPTypographyToken.uiTextCodeMd),
        ("Code Sm", PPFont.codeSm, PPTypographyToken.uiTextCodeSm),
        ("Caption", PPFont.caption, PPTypographyToken.uiTextCaptionNormal),
        ("Caption Strong", PPFont.captionStrong, PPTypographyToken.uiTextCaptionStrong),
    ]

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0) {
                ForEach(Array(styles.enumerated()), id: \.offset) { index, item in
                    typeRow(item: item, index: index)

                    if index < styles.count - 1 {
                        Divider()
                            .padding(.horizontal, Spacing.systemMargin)
                    }
                }
            }
        }
        .background(Color.bgBase)
        .navigationTitle("Type Scale")
    }

    @ViewBuilder
    private func typeRow(item: (name: String, font: Font, spec: PPTypographyToken.Spec), index: Int) -> some View {
        let spec = item.spec
        let weightName = fontWeightName(spec.fontWeight)

        VStack(alignment: .leading, spacing: Spacing.xs) {
            Text(item.name)
                .font(item.font)

            HStack(spacing: Spacing.md) {
                specBadge(label: spec.fontFamily)
                specBadge(label: "\(Int(spec.fontSize))pt")
                specBadge(label: weightName)
                specBadge(label: "L: \(Int(spec.lineHeight))pt")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, Spacing.systemMargin)
        .padding(.vertical, Spacing.md)
        .enterAnimation(delay: Double(index) * 0.04)
    }

    private func specBadge(label: String) -> some View {
        Text(label)
            .font(PPFont.caption)
            .foregroundStyle(Color.fgSecondary)
            .padding(.horizontal, Spacing.xs)
            .padding(.vertical, Spacing.xxs)
            .background(
                RoundedRectangle(cornerRadius: CornerRadius.sm)
                    .fill(Color.bgSoft)
            )
    }

    private func fontWeightName(_ weight: Int) -> String {
        switch weight {
        case 400: return "Regular"
        case 500: return "Medium"
        case 600: return "Semibold"
        case 700: return "Bold"
        default: return "\(weight)"
        }
    }
}

#Preview {
    NavigationStack {
        TypeScaleView()
    }
}
