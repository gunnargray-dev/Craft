import SwiftUI

struct ChecklistView: View {
    @State private var items: [ChecklistItem] = ChecklistItem.defaultItems

    private var completedCount: Int {
        items.filter(\.isChecked).count
    }

    private var progress: Double {
        Double(completedCount) / Double(items.count)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.lg) {
                // Progress Header
                progressHeader
                    .enterAnimation(delay: 0.0)

                // Checklist Items
                VStack(spacing: Spacing.xs) {
                    ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                        ChecklistRow(item: item) {
                            withAnimation(Springs.snappy) {
                                items[index].isChecked.toggle()
                            }
                        }
                        .enterAnimation(delay: 0.03 * Double(index) + 0.05)
                    }
                }
            }
            .padding(.horizontal, Spacing.systemMargin)
            .padding(.top, Spacing.sm)
            .padding(.bottom, Spacing.xxl)
        }
        .navigationTitle("Checklist")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Progress Header

    private var progressHeader: some View {
        VStack(spacing: Spacing.sm) {
            HStack {
                Text("\(completedCount) of \(items.count) complete")
                    .font(.headline)
                    .contentTransition(.numericText(value: Double(completedCount)))
                    .animation(Springs.snappy, value: completedCount)

                Spacer()

                Text("\(Int(progress * 100))%")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.tint)
                    .contentTransition(.numericText(value: progress))
                    .animation(Springs.snappy, value: progress)
            }

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: CornerRadius.full)
                        .fill(.primary.opacity(0.08))
                        .frame(height: 8)

                    RoundedRectangle(cornerRadius: CornerRadius.full)
                        .fill(.tint)
                        .frame(width: max(8, geo.size.width * progress), height: 8)
                        .animation(Springs.responsive, value: progress)
                }
            }
            .frame(height: 8)
        }
        .padding(Spacing.md)
        .background(.background, in: RoundedRectangle(cornerRadius: CornerRadius.lg))
        .shadowSmall()
    }
}

// MARK: - Checklist Row

private struct ChecklistRow: View {
    let item: ChecklistItem
    let toggle: () -> Void

    var body: some View {
        Button(action: toggle) {
            HStack(alignment: .top, spacing: Spacing.sm) {
                Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
                    .font(.title3)
                    .foregroundStyle(item.isChecked ? .green : .secondary)
                    .frame(width: 28)
                    .contentTransition(.symbolEffect(.replace))

                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text(item.title)
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundStyle(item.isChecked ? .secondary : .primary)
                        .strikethrough(item.isChecked)

                    Text(item.description)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }

                Spacer(minLength: 0)
            }
            .padding(Spacing.sm)
            .frame(minHeight: 44)
            .background(.background, in: RoundedRectangle(cornerRadius: CornerRadius.md))
            .shadowSmall()
        }
        .buttonStyle(.plain)
        .pressEffect()
        .contentShape(RoundedRectangle(cornerRadius: CornerRadius.md))
        .accessibilityLabel("\(item.title). \(item.description)")
        .accessibilityValue(item.isChecked ? "Checked" : "Unchecked")
        .accessibilityAddTraits(.isButton)
    }
}

// MARK: - Checklist Item Model

struct ChecklistItem: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    var isChecked: Bool = false

    static let defaultItems: [ChecklistItem] = [
        ChecklistItem(
            title: "Touch targets ≥ 44pt",
            description: "All interactive elements have a minimum 44×44 point hit area for comfortable tapping."
        ),
        ChecklistItem(
            title: "Color not sole indicator of state",
            description: "States are communicated with icons, shapes, or text in addition to color changes."
        ),
        ChecklistItem(
            title: "Dynamic Type supported",
            description: "All text scales with the user's preferred text size, from xSmall through AX5."
        ),
        ChecklistItem(
            title: "Contrast ratio ≥ 4.5:1",
            description: "Text and meaningful UI elements meet WCAG AA minimum contrast against their background."
        ),
        ChecklistItem(
            title: "Reduce Motion respected",
            description: "Animations are minimized or removed when the user has enabled Reduce Motion."
        ),
        ChecklistItem(
            title: "VoiceOver labels present",
            description: "All interactive elements and images have descriptive accessibility labels."
        ),
        ChecklistItem(
            title: "Keyboard navigation works",
            description: "All functionality is reachable and operable using an external keyboard."
        ),
        ChecklistItem(
            title: "Focus order is logical",
            description: "VoiceOver and keyboard focus follows a natural reading and interaction order."
        ),
        ChecklistItem(
            title: "Error states are clear",
            description: "Errors are announced, visually distinct, and provide actionable guidance to fix the issue."
        ),
        ChecklistItem(
            title: "Loading states communicated",
            description: "Progress and loading indicators are present and announced to assistive technology."
        ),
    ]
}

#Preview {
    NavigationStack {
        ChecklistView()
    }
}
