import SwiftUI

struct AuditListView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.sm) {
                AuditRow(
                    icon: "textformat.size",
                    title: "Dynamic Type Preview",
                    subtitle: "See how a card renders across type sizes",
                    destination: DynamicTypePreviewView()
                )
                .enterAnimation(delay: 0.0)

                AuditRow(
                    icon: "circle.lefthalf.filled",
                    title: "Contrast Checker",
                    subtitle: "Calculate WCAG contrast ratios",
                    destination: ContrastCheckerView()
                )
                .enterAnimation(delay: 0.05)

                AuditRow(
                    icon: "rectangle.split.2x2",
                    title: "Size Class",
                    subtitle: "Live horizontal & vertical size class info",
                    destination: SizeClassView()
                )
                .enterAnimation(delay: 0.1)

                AuditRow(
                    icon: "checklist",
                    title: "Checklist",
                    subtitle: "Interactive accessibility audit checklist",
                    destination: ChecklistView()
                )
                .enterAnimation(delay: 0.15)
            }
            .padding(.horizontal, Spacing.systemMargin)
            .padding(.top, Spacing.sm)
            .padding(.bottom, Spacing.xxl)
        }
        .background(Color.bgBase)
        .navigationTitle("Audit")
    }
}

// MARK: - Audit Row

private struct AuditRow<Destination: View>: View {
    let icon: String
    let title: String
    let subtitle: String
    let destination: Destination

    var body: some View {
        NavigationLink {
            destination
        } label: {
            HStack(spacing: Spacing.md) {
                Image(systemName: icon)
                    .font(PPFont.title)
                    .foregroundStyle(.tint)
                    .frame(width: 44, height: 44)
                    .background(.tint.opacity(0.12), in: RoundedRectangle(cornerRadius: CornerRadius.sm))

                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text(title)
                        .font(PPFont.section)
                        .foregroundStyle(Color.fgPrimary)
                    Text(subtitle)
                        .font(PPFont.bodyMd)
                        .foregroundStyle(Color.fgSecondary)
                }

                Spacer(minLength: 0)

                Image(systemName: "chevron.right")
                    .font(PPFont.caption)
                    .foregroundStyle(Color.fgTertiary)
            }
            .padding(Spacing.md)
            .background(Color.bgRaised, in: RoundedRectangle(cornerRadius: CornerRadius.lg))
            .shadowSmall()
        }
        .buttonStyle(.plain)
        .pressEffect()
        .contentShape(RoundedRectangle(cornerRadius: CornerRadius.lg))
    }
}

#Preview {
    NavigationStack {
        AuditListView()
    }
}
