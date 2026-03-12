import SwiftUI

struct TypeHierarchyView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.lg) {
                Text("Compare type hierarchy discipline. Limit to 2-3 levels for clarity.")
                    .font(PPFont.bodyMd)
                    .foregroundStyle(Color.fgSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, Spacing.systemMargin)
                    .enterAnimation(delay: 0)

                HStack(alignment: .top, spacing: Spacing.md) {
                    goodExample
                    badExample
                }
                .padding(.horizontal, Spacing.systemMargin)
            }
            .padding(.vertical, Spacing.md)
        }
        .background(Color.bgBase)
        .navigationTitle("Type Hierarchy")
    }

    // MARK: - Good Example

    private var goodExample: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: Spacing.xs) {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(Color.positiveFgPrimary)
                Text("Good")
                    .font(PPFont.section)
            }
            .padding(.bottom, Spacing.md)

            cardContent {
                VStack(alignment: .leading, spacing: Spacing.sm) {
                    Text("Weekend Trip")
                        .font(PPFont.section)
                        .fontWeight(.semibold)

                    Text("Pack light and bring only what you need. A small carry-on works best for short getaways.")
                        .font(PPFont.bodyLg)
                        .foregroundStyle(Color.fgSecondary)

                    Text("3 days ago")
                        .font(PPFont.caption)
                        .foregroundStyle(Color.fgTertiary)
                }
            }

            Text("3 levels: title, body, caption")
                .font(PPFont.caption)
                .foregroundStyle(Color.fgSecondary)
                .padding(.top, Spacing.sm)
        }
        .enterAnimation(delay: 0.1)
    }

    // MARK: - Bad Example

    private var badExample: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: Spacing.xs) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundStyle(Color.negativeFgPrimary)
                Text("Bad")
                    .font(PPFont.section)
            }
            .padding(.bottom, Spacing.md)

            cardContent {
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Text("TRIP")
                        .font(PPFont.caption)
                        .fontWeight(.black)
                        .tracking(2)

                    Text("Weekend")
                        .font(PPFont.title)
                        .fontWeight(.light)

                    Text("Trip Details")
                        .font(PPFont.section)
                        .italic()

                    Text("Pack light and bring what you need.")
                        .font(PPFont.bodyMd)
                        .fontWeight(.medium)

                    Text("Updated recently")
                        .font(PPFont.caption)
                        .fontWeight(.bold)

                    Text("3 days ago")
                        .font(PPFont.caption)
                        .fontWeight(.heavy)
                }
            }

            Text("6 levels, mixed weights")
                .font(PPFont.caption)
                .foregroundStyle(Color.fgSecondary)
                .padding(.top, Spacing.sm)
        }
        .enterAnimation(delay: 0.15)
    }

    // MARK: - Card Wrapper

    @ViewBuilder
    private func cardContent<Content: View>(@ViewBuilder _ content: () -> Content) -> some View {
        content()
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(Spacing.md)
            .background(
                RoundedRectangle(cornerRadius: CornerRadius.md)
                    .fill(Color.bgRaised)
            )
            .shadowSmall()
    }
}

#Preview {
    NavigationStack {
        TypeHierarchyView()
    }
}
