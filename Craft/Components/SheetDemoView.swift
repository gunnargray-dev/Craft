import SwiftUI

enum SheetSize: String, CaseIterable, Identifiable {
    case small = "Small"
    case medium = "Medium"
    case large = "Large"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .small: "rectangle.bottomthird.inset.filled"
        case .medium: "rectangle.bottomhalf.inset.filled"
        case .large: "rectangle.inset.filled"
        }
    }

    var detents: Set<PresentationDetent> {
        switch self {
        case .small: [.height(200)]
        case .medium: [.medium]
        case .large: [.large]
        }
    }

    var description: String {
        switch self {
        case .small: "A compact sheet for quick actions or confirmations. Uses a fixed height detent of 200pt."
        case .medium: "A half-height sheet suitable for pickers, short forms, or action menus. Uses the system .medium detent."
        case .large: "A full-height sheet for complex content, long forms, or detail views. Uses the system .large detent."
        }
    }
}

struct SheetDemoView: View {
    @State private var presentedSheet: SheetSize?
    @State private var showMultiDetentSheet = false

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // MARK: - Single Detent Sheets
                Text("Single Detent")
                    .sectionHeader()
                    .enterAnimation(delay: 0.0)

                VStack(spacing: Spacing.sm) {
                    ForEach(Array(SheetSize.allCases.enumerated()), id: \.element.id) { index, size in
                        sheetButton(size: size)
                            .enterAnimation(delay: 0.05 + 0.06 * Double(index))
                    }
                }
                .padding(.horizontal, Spacing.systemMargin)

                // MARK: - Multi-Detent Sheet
                Text("Multi-Detent")
                    .sectionHeader()
                    .enterAnimation(delay: 0.25)

                VStack(alignment: .leading, spacing: Spacing.sm) {
                    Text("A sheet that supports all three detent sizes. Drag to resize between them.")
                        .font(PPFont.bodyMd)
                        .foregroundStyle(Color.fgSecondary)

                    CraftButton(
                        title: "Present Multi-Detent Sheet",
                        level: .primary,
                        size: .large,
                        icon: "arrow.up.and.down.text.horizontal",
                        isFullWidth: true
                    ) {
                        showMultiDetentSheet = true
                    }
                }
                .padding(.horizontal, Spacing.systemMargin)
                .enterAnimation(delay: 0.3)

                // MARK: - Detent Reference
                Text("Detent Reference")
                    .sectionHeader()
                    .enterAnimation(delay: 0.4)

                VStack(spacing: Spacing.sm) {
                    detentInfoRow(
                        title: ".height(200)",
                        description: "Fixed height, ideal for confirmations",
                        height: 40
                    )
                    .enterAnimation(delay: 0.45)

                    detentInfoRow(
                        title: ".medium",
                        description: "~50% of screen, system-defined",
                        height: 80
                    )
                    .enterAnimation(delay: 0.5)

                    detentInfoRow(
                        title: ".large",
                        description: "Full screen, system-defined",
                        height: 140
                    )
                    .enterAnimation(delay: 0.55)
                }
                .padding(.horizontal, Spacing.systemMargin)

                Spacer(minLength: Spacing.xxl)
            }
        }
        .background(Color.bgBase)
        .navigationTitle("Sheets")
        .sheet(item: $presentedSheet) { size in
            singleDetentSheetContent(size: size)
                .presentationDetents(size.detents)
                .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $showMultiDetentSheet) {
            multiDetentSheetContent
                .presentationDetents([.height(200), .medium, .large])
                .presentationDragIndicator(.visible)
        }
    }

    // MARK: - Sheet Button

    private func sheetButton(size: SheetSize) -> some View {
        HStack(spacing: Spacing.sm) {
            Image(systemName: size.icon)
                .font(PPFont.title)
                .foregroundStyle(Color.accentFgPrimary)
                .frame(width: 44, height: 44)

            VStack(alignment: .leading, spacing: 2) {
                Text(size.rawValue)
                    .font(PPFont.section)
                Text(size.description)
                    .font(PPFont.caption)
                    .foregroundStyle(Color.fgSecondary)
                    .lineLimit(2)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(PPFont.caption)
                .foregroundStyle(Color.fgTertiary)
        }
        .padding(Spacing.md)
        .frame(minHeight: 44)
        .background(Color.bgRaised)
        .clipShape(RoundedRectangle(cornerRadius: CornerRadius.lg, style: .continuous))
        .shadowSmall()
        .pressEffect {
            presentedSheet = size
        }
        .accessibilityAddTraits(.isButton)
    }

    // MARK: - Single Detent Sheet Content

    private func singleDetentSheetContent(size: SheetSize) -> some View {
        VStack(spacing: Spacing.lg) {
            Spacer(minLength: Spacing.sm)

            Image(systemName: size.icon)
                .font(.system(size: 48))
                .foregroundStyle(Color.accentFgPrimary)
                .enterAnimation(delay: 0.1)

            VStack(spacing: Spacing.xs) {
                Text("\(size.rawValue) Sheet")
                    .font(PPFont.title)

                Text(size.description)
                    .font(PPFont.bodyMd)
                    .foregroundStyle(Color.fgSecondary)
                    .multilineTextAlignment(.center)
            }
            .enterAnimation(delay: 0.15)

            CraftButton(title: "Dismiss", level: .secondary, size: .large) {
                presentedSheet = nil
            }
            .enterAnimation(delay: 0.2)

            Spacer()
        }
        .padding(.horizontal, Spacing.systemMargin)
    }

    // MARK: - Multi-Detent Sheet Content

    private var multiDetentSheetContent: some View {
        VStack(spacing: Spacing.lg) {
            Spacer(minLength: Spacing.sm)

            Image(systemName: "arrow.up.and.down.text.horizontal")
                .font(.system(size: 48))
                .foregroundStyle(Color.accentFgPrimary)
                .enterAnimation(delay: 0.1)

            VStack(spacing: Spacing.xs) {
                Text("Multi-Detent Sheet")
                    .font(PPFont.title)

                Text("Drag the sheet to resize between small, medium, and large. The grabber handle at the top indicates this sheet is resizable.")
                    .font(PPFont.bodyMd)
                    .foregroundStyle(Color.fgSecondary)
                    .multilineTextAlignment(.center)
            }
            .enterAnimation(delay: 0.15)

            VStack(spacing: Spacing.sm) {
                ForEach(SheetSize.allCases) { size in
                    HStack(spacing: Spacing.sm) {
                        Image(systemName: size.icon)
                            .foregroundStyle(Color.accentFgPrimary)
                            .frame(width: 24)
                        Text(size.rawValue)
                            .font(PPFont.bodyLg)
                        Spacer()
                    }
                    .padding(.horizontal, Spacing.md)
                    .padding(.vertical, Spacing.sm)
                    .background(Color.bgSoft)
                    .clipShape(RoundedRectangle(cornerRadius: CornerRadius.sm, style: .continuous))
                }
            }
            .enterAnimation(delay: 0.2)

            CraftButton(title: "Done", level: .primary, size: .large, isFullWidth: true) {
                showMultiDetentSheet = false
            }
            .enterAnimation(delay: 0.25)

            Spacer()
        }
        .padding(.horizontal, Spacing.systemMargin)
    }

    // MARK: - Detent Info Row

    private func detentInfoRow(title: String, description: String, height: CGFloat) -> some View {
        HStack(spacing: Spacing.sm) {
            RoundedRectangle(cornerRadius: CornerRadius.sm, style: .continuous)
                .fill(Color.accentBgSubtle)
                .frame(width: 60, height: height)
                .overlay(
                    RoundedRectangle(cornerRadius: CornerRadius.sm - 2, style: .continuous)
                        .fill(Color.accentFgPrimary.opacity(0.25))
                        .padding(4)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                )

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(PPFont.bodyMdStrong)
                    .fontDesign(.monospaced)
                Text(description)
                    .font(PPFont.caption)
                    .foregroundStyle(Color.fgSecondary)
            }

            Spacer()
        }
        .padding(Spacing.sm)
        .background(Color.bgRaised)
        .clipShape(RoundedRectangle(cornerRadius: CornerRadius.md, style: .continuous))
    }
}

#Preview {
    NavigationStack {
        SheetDemoView()
    }
}
