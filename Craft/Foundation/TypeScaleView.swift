import SwiftUI

struct TypeScaleView: View {
    private let styles: [(name: String, style: Font.TextStyle, weight: String)] = [
        ("Large Title", .largeTitle, "Regular"),
        ("Title", .title, "Regular"),
        ("Title 2", .title2, "Regular"),
        ("Title 3", .title3, "Regular"),
        ("Headline", .headline, "Semibold"),
        ("Subheadline", .subheadline, "Regular"),
        ("Body", .body, "Regular"),
        ("Callout", .callout, "Regular"),
        ("Footnote", .footnote, "Regular"),
        ("Caption", .caption, "Regular"),
        ("Caption 2", .caption2, "Regular"),
    ]

    /// Default point sizes at Large dynamic type size
    private let defaultSizes: [Font.TextStyle: CGFloat] = [
        .largeTitle: 34,
        .title: 28,
        .title2: 22,
        .title3: 20,
        .headline: 17,
        .subheadline: 15,
        .body: 17,
        .callout: 16,
        .footnote: 13,
        .caption: 12,
        .caption2: 11,
    ]

    /// Default leading values at Large dynamic type size
    private let defaultLeading: [Font.TextStyle: CGFloat] = [
        .largeTitle: 41,
        .title: 34,
        .title2: 28,
        .title3: 25,
        .headline: 22,
        .subheadline: 20,
        .body: 22,
        .callout: 21,
        .footnote: 18,
        .caption: 16,
        .caption2: 13,
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
        .navigationTitle("Type Scale")
    }

    @ViewBuilder
    private func typeRow(item: (name: String, style: Font.TextStyle, weight: String), index: Int) -> some View {
        let size = defaultSizes[item.style] ?? 17
        let leading = defaultLeading[item.style] ?? 22

        VStack(alignment: .leading, spacing: Spacing.xs) {
            Text(item.name)
                .font(.system(item.style))

            HStack(spacing: Spacing.md) {
                specBadge(label: "\(Int(size))pt")
                specBadge(label: item.weight)
                specBadge(label: "L: \(Int(leading))pt")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, Spacing.systemMargin)
        .padding(.vertical, Spacing.md)
        .enterAnimation(delay: Double(index) * 0.04)
    }

    private func specBadge(label: String) -> some View {
        Text(label)
            .font(.caption2)
            .foregroundStyle(.secondary)
            .padding(.horizontal, Spacing.xs)
            .padding(.vertical, Spacing.xxs)
            .background(
                RoundedRectangle(cornerRadius: CornerRadius.sm)
                    .fill(Color(.quaternarySystemFill))
            )
    }
}

#Preview {
    NavigationStack {
        TypeScaleView()
    }
}
