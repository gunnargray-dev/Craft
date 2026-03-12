import SwiftUI

struct DynamicTypePreviewView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.lg) {
                Text("The same card rendered at three Dynamic Type sizes to verify layout flexibility.")
                    .font(PPFont.bodyMd)
                    .foregroundStyle(Color.fgSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, Spacing.systemMargin)
                    .enterAnimation(delay: 0.0)

                // xSmall
                SizeSection(label: "xSmall") {
                    SampleCard()
                        .dynamicTypeSize(.xSmall)
                }
                .enterAnimation(delay: 0.05)

                // Large (Default)
                SizeSection(label: "Large (Default)") {
                    SampleCard()
                        .dynamicTypeSize(.large)
                }
                .enterAnimation(delay: 0.1)

                // AX5
                SizeSection(label: "AX5 (Accessibility)") {
                    SampleCard()
                        .dynamicTypeSize(.accessibility5)
                }
                .enterAnimation(delay: 0.15)
            }
            .padding(.top, Spacing.sm)
            .padding(.bottom, Spacing.xxl)
        }
        .background(Color.bgBase)
        .navigationTitle("Dynamic Type Preview")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Size Section

private struct SizeSection<Content: View>: View {
    let label: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            Text(label)
                .font(PPFont.caption)
                .fontWeight(.semibold)
                .foregroundStyle(Color.fgSecondary)
                .textCase(.uppercase)
                .padding(.horizontal, Spacing.systemMargin)

            content
                .padding(.horizontal, Spacing.systemMargin)
        }
    }
}

// MARK: - Sample Card

private struct SampleCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            HStack(spacing: Spacing.sm) {
                Circle()
                    .fill(.tint.opacity(0.15))
                    .frame(width: 40, height: 40)
                    .overlay {
                        Image(systemName: "person.fill")
                            .font(PPFont.bodyLg)
                            .foregroundStyle(.tint)
                    }

                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text("Alex Johnson")
                        .font(PPFont.section)
                    Text("Product Designer")
                        .font(PPFont.bodyMd)
                        .foregroundStyle(Color.fgSecondary)
                }

                Spacer(minLength: 0)
            }

            Text("Building thoughtful interfaces that respect every user's needs. Accessibility isn't a feature — it's a foundation.")
                .font(PPFont.bodyLg)
                .foregroundStyle(Color.fgPrimary)

            HStack(spacing: Spacing.sm) {
                Label("12 projects", systemImage: "folder.fill")
                    .font(PPFont.caption)
                    .foregroundStyle(Color.fgSecondary)

                Spacer(minLength: 0)

                Text("View Profile")
                    .font(PPFont.bodyMd)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.fgInverse)
                    .padding(.horizontal, Spacing.md)
                    .padding(.vertical, Spacing.xs)
                    .background(.tint, in: RoundedRectangle(cornerRadius: CornerRadius.sm))
            }
        }
        .padding(Spacing.md)
        .background(Color.bgRaised, in: RoundedRectangle(cornerRadius: CornerRadius.lg))
        .shadowMedium()
    }
}

#Preview {
    NavigationStack {
        DynamicTypePreviewView()
    }
}
