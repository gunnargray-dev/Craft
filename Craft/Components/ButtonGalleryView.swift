import SwiftUI

struct ButtonGalleryView: View {
    @State private var pressCount = 0

    private let levels: [(String, CraftButtonLevel)] = [
        ("Primary", .primary),
        ("Secondary", .secondary),
        ("Tertiary", .tertiary),
        ("Destructive", .destructive)
    ]

    private let sizes: [(String, CraftButtonSize)] = [
        ("Small", .small),
        ("Medium", .medium),
        ("Large", .large),
        ("Extra Large", .extraLarge)
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // MARK: - Hierarchy Levels
                Text("Hierarchy Levels")
                    .sectionHeader()
                    .enterAnimation(delay: 0.0)

                VStack(spacing: Spacing.md) {
                    ForEach(Array(levels.enumerated()), id: \.offset) { index, level in
                        CraftButton(
                            title: level.0,
                            level: level.1,
                            size: .large,
                            isFullWidth: true
                        ) {
                            pressCount += 1
                        }
                        .enterAnimation(delay: 0.05 * Double(index + 1))
                    }
                }
                .padding(.horizontal, Spacing.systemMargin)

                // MARK: - Size Scale
                Text("Size Scale")
                    .sectionHeader()
                    .enterAnimation(delay: 0.25)

                VStack(spacing: Spacing.md) {
                    ForEach(Array(sizes.enumerated()), id: \.offset) { index, size in
                        HStack {
                            Text(size.0)
                                .font(PPFont.caption)
                                .foregroundStyle(Color.fgSecondary)
                                .frame(width: 80, alignment: .leading)

                            CraftButton(
                                title: size.0,
                                level: .primary,
                                size: size.1
                            ) {
                                pressCount += 1
                            }

                            Spacer()
                        }
                        .enterAnimation(delay: 0.3 + 0.05 * Double(index))
                    }
                }
                .padding(.horizontal, Spacing.systemMargin)

                // MARK: - Grid: Levels x Sizes
                Text("Full Matrix")
                    .sectionHeader()
                    .enterAnimation(delay: 0.5)

                LazyVGrid(
                    columns: [
                        GridItem(.flexible(), spacing: Spacing.xs),
                        GridItem(.flexible(), spacing: Spacing.xs),
                        GridItem(.flexible(), spacing: Spacing.xs),
                        GridItem(.flexible(), spacing: Spacing.xs)
                    ],
                    spacing: Spacing.sm
                ) {
                    // Header row
                    ForEach(sizes, id: \.0) { size in
                        Text(size.0)
                            .font(PPFont.caption)
                            .foregroundStyle(Color.fgSecondary)
                    }

                    // Button rows
                    ForEach(Array(levels.enumerated()), id: \.offset) { levelIndex, level in
                        ForEach(Array(sizes.enumerated()), id: \.offset) { sizeIndex, size in
                            CraftButton(
                                title: String(level.0.prefix(3)),
                                level: level.1,
                                size: size.1
                            ) {
                                pressCount += 1
                            }
                            .enterAnimation(delay: 0.55 + 0.03 * Double(levelIndex * 4 + sizeIndex))
                        }
                    }
                }
                .padding(.horizontal, Spacing.systemMargin)

                // MARK: - With Icons
                Text("With Icons")
                    .sectionHeader()
                    .enterAnimation(delay: 0.9)

                VStack(spacing: Spacing.sm) {
                    CraftButton(title: "Add to Cart", level: .primary, size: .large, icon: "cart.badge.plus", isFullWidth: true) {
                        pressCount += 1
                    }
                    .enterAnimation(delay: 0.95)

                    CraftButton(title: "Share", level: .secondary, size: .medium, icon: "square.and.arrow.up") {
                        pressCount += 1
                    }
                    .enterAnimation(delay: 1.0)

                    CraftButton(title: "Delete", level: .destructive, size: .medium, icon: "trash") {
                        pressCount += 1
                    }
                    .enterAnimation(delay: 1.05)
                }
                .padding(.horizontal, Spacing.systemMargin)

                // MARK: - Interactive Counter
                Text("Interactive Demo")
                    .sectionHeader()
                    .enterAnimation(delay: 1.1)

                VStack(spacing: Spacing.md) {
                    Text("Tap count: \(pressCount)")
                        .font(PPFont.title)
                        .contentTransition(.numericText(value: Double(pressCount)))
                        .animation(Springs.snappy, value: pressCount)

                    Text("Press any button above or below to increment")
                        .font(PPFont.caption)
                        .foregroundStyle(Color.fgSecondary)

                    CraftButton(title: "Reset", level: .tertiary, size: .medium, icon: "arrow.counterclockwise") {
                        pressCount = 0
                    }
                }
                .padding(.horizontal, Spacing.systemMargin)
                .enterAnimation(delay: 1.15)

                Spacer(minLength: Spacing.xxl)
            }
        }
        .background(Color.bgBase)
        .navigationTitle("Buttons")
    }
}

#Preview {
    NavigationStack {
        ButtonGalleryView()
    }
}
