import SwiftUI

struct DynamicTypePreviewView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.lg) {
                Text("The same card rendered at three Dynamic Type sizes to verify layout flexibility.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
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
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
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
                            .font(.body)
                            .foregroundStyle(.tint)
                    }

                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text("Alex Johnson")
                        .font(.headline)
                    Text("Product Designer")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer(minLength: 0)
            }

            Text("Building thoughtful interfaces that respect every user's needs. Accessibility isn't a feature — it's a foundation.")
                .font(.body)
                .foregroundStyle(.primary)

            HStack(spacing: Spacing.sm) {
                Label("12 projects", systemImage: "folder.fill")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Spacer(minLength: 0)

                Text("View Profile")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(.horizontal, Spacing.md)
                    .padding(.vertical, Spacing.xs)
                    .background(.tint, in: RoundedRectangle(cornerRadius: CornerRadius.sm))
            }
        }
        .padding(Spacing.md)
        .background(.background, in: RoundedRectangle(cornerRadius: CornerRadius.lg))
        .shadowMedium()
    }
}

#Preview {
    NavigationStack {
        DynamicTypePreviewView()
    }
}
