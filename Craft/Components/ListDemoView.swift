import SwiftUI

struct ListItem: Identifiable {
    let id = UUID()
    var icon: String
    var iconColor: Color
    var title: String
    var subtitle: String
    var trailing: TrailingAccessory

    enum TrailingAccessory {
        case chevron
        case badge(String)
        case toggle
        case text(String)
    }
}

struct ListDemoView: View {
    @State private var items: [ListItem] = [
        ListItem(icon: "bell.fill", iconColor: .red, title: "Notifications", subtitle: "Manage your alerts", trailing: .badge("3")),
        ListItem(icon: "moon.fill", iconColor: .indigo, title: "Do Not Disturb", subtitle: "Silence calls and notifications", trailing: .toggle),
        ListItem(icon: "wifi", iconColor: .blue, title: "Wi-Fi", subtitle: "Connected to Home Network", trailing: .text("Home")),
        ListItem(icon: "battery.100", iconColor: .green, title: "Battery", subtitle: "98% charged", trailing: .chevron),
        ListItem(icon: "lock.fill", iconColor: .gray, title: "Privacy", subtitle: "Control app permissions", trailing: .chevron),
        ListItem(icon: "paintbrush.fill", iconColor: .orange, title: "Appearance", subtitle: "Theme and display settings", trailing: .chevron),
        ListItem(icon: "icloud.fill", iconColor: .cyan, title: "Cloud Sync", subtitle: "Last synced 2 min ago", trailing: .text("On")),
        ListItem(icon: "star.fill", iconColor: .yellow, title: "Favorites", subtitle: "Your saved items", trailing: .badge("12")),
    ]

    @State private var toggleStates: [UUID: Bool] = [:]

    var body: some View {
        List {
            Section {
                ForEach(items) { item in
                    listRow(item: item)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                withAnimation(Springs.responsive) {
                                    items.removeAll { $0.id == item.id }
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: false) {
                            Button {
                                // Edit action
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(.accentColor)
                        }
                }
                .onMove { indices, newOffset in
                    items.move(fromOffsets: indices, toOffset: newOffset)
                }
            } header: {
                Text("Settings")
                    .enterAnimation(delay: 0.0)
            } footer: {
                Text("Swipe left to delete, swipe right to edit. Use the Edit button to reorder.")
                    .enterAnimation(delay: 0.3)
            }

            Section {
                ForEach(Array(compactItems.enumerated()), id: \.element.id) { index, item in
                    compactRow(item: item)
                        .enterAnimation(delay: 0.4 + 0.04 * Double(index))
                }
            } header: {
                Text("Compact Variant")
                    .enterAnimation(delay: 0.35)
            }
        }
        .navigationTitle("Lists")
        .toolbar {
            EditButton()
        }
    }

    @ViewBuilder
    private func listRow(item: ListItem) -> some View {
        HStack(spacing: Spacing.sm) {
            // Leading icon
            Image(systemName: item.icon)
                .font(.body)
                .foregroundStyle(.white)
                .frame(width: 32, height: 32)
                .background(item.iconColor)
                .clipShape(RoundedRectangle(cornerRadius: CornerRadius.sm, style: .continuous))

            // Title + subtitle
            VStack(alignment: .leading, spacing: 2) {
                Text(item.title)
                    .font(.body)
                Text(item.subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer(minLength: Spacing.xs)

            // Trailing accessory
            trailingView(for: item)
        }
        .frame(minHeight: 44)
    }

    @ViewBuilder
    private func trailingView(for item: ListItem) -> some View {
        switch item.trailing {
        case .chevron:
            Image(systemName: "chevron.right")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.tertiary)

        case .badge(let count):
            Text(count)
                .font(.caption2.weight(.semibold))
                .foregroundStyle(.white)
                .padding(.horizontal, Spacing.xs)
                .padding(.vertical, Spacing.xxs)
                .background(.red)
                .clipShape(Capsule())

        case .toggle:
            Toggle("", isOn: Binding(
                get: { toggleStates[item.id] ?? false },
                set: { toggleStates[item.id] = $0 }
            ))
            .labelsHidden()

        case .text(let value):
            Text(value)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    // MARK: - Compact Items

    private var compactItems: [ListItem] {
        [
            ListItem(icon: "doc.text", iconColor: .blue, title: "Documents", subtitle: "24 files", trailing: .chevron),
            ListItem(icon: "photo", iconColor: .green, title: "Photos", subtitle: "1,432 items", trailing: .chevron),
            ListItem(icon: "music.note", iconColor: .pink, title: "Music", subtitle: "86 songs", trailing: .chevron),
        ]
    }

    @ViewBuilder
    private func compactRow(item: ListItem) -> some View {
        HStack(spacing: Spacing.sm) {
            Image(systemName: item.icon)
                .font(.body)
                .foregroundStyle(item.iconColor)
                .frame(width: 24)

            Text(item.title)
                .font(.body)

            Spacer()

            Text(item.subtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Image(systemName: "chevron.right")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.tertiary)
        }
        .frame(minHeight: 44)
    }
}

#Preview {
    NavigationStack {
        ListDemoView()
    }
}
