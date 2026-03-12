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
        ListItem(icon: "bell.fill", iconColor: .negativeFgPrimary, title: "Notifications", subtitle: "Manage your alerts", trailing: .badge("3")),
        ListItem(icon: "moon.fill", iconColor: .indigo, title: "Do Not Disturb", subtitle: "Silence calls and notifications", trailing: .toggle),
        ListItem(icon: "wifi", iconColor: Color.blue600, title: "Wi-Fi", subtitle: "Connected to Home Network", trailing: .text("Home")),
        ListItem(icon: "battery.100", iconColor: .positiveFgPrimary, title: "Battery", subtitle: "98% charged", trailing: .chevron),
        ListItem(icon: "lock.fill", iconColor: .gray, title: "Privacy", subtitle: "Control app permissions", trailing: .chevron),
        ListItem(icon: "paintbrush.fill", iconColor: Color.orange600, title: "Appearance", subtitle: "Theme and display settings", trailing: .chevron),
        ListItem(icon: "icloud.fill", iconColor: .cyan, title: "Cloud Sync", subtitle: "Last synced 2 min ago", trailing: .text("On")),
        ListItem(icon: "star.fill", iconColor: Color.yellow600, title: "Favorites", subtitle: "Your saved items", trailing: .badge("12")),
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
                            .tint(Color.accentFgPrimary)
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
                .font(PPFont.bodyLg)
                .foregroundStyle(Color.fgInverse)
                .frame(width: 32, height: 32)
                .background(item.iconColor)
                .clipShape(RoundedRectangle(cornerRadius: CornerRadius.sm, style: .continuous))

            // Title + subtitle
            VStack(alignment: .leading, spacing: 2) {
                Text(item.title)
                    .font(PPFont.bodyLg)
                Text(item.subtitle)
                    .font(PPFont.caption)
                    .foregroundStyle(Color.fgSecondary)
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
                .font(PPFont.caption)
                .foregroundStyle(Color.fgTertiary)

        case .badge(let count):
            Text(count)
                .font(PPFont.caption)
                .foregroundStyle(Color.fgInverse)
                .padding(.horizontal, Spacing.xs)
                .padding(.vertical, Spacing.xxs)
                .background(Color.negativeFgPrimary)
                .clipShape(Capsule())

        case .toggle:
            Toggle("", isOn: Binding(
                get: { toggleStates[item.id] ?? false },
                set: { toggleStates[item.id] = $0 }
            ))
            .labelsHidden()

        case .text(let value):
            Text(value)
                .font(PPFont.bodyMd)
                .foregroundStyle(Color.fgSecondary)
        }
    }

    // MARK: - Compact Items

    private var compactItems: [ListItem] {
        [
            ListItem(icon: "doc.text", iconColor: Color.blue600, title: "Documents", subtitle: "24 files", trailing: .chevron),
            ListItem(icon: "photo", iconColor: .positiveFgPrimary, title: "Photos", subtitle: "1,432 items", trailing: .chevron),
            ListItem(icon: "music.note", iconColor: Color.pink600, title: "Music", subtitle: "86 songs", trailing: .chevron),
        ]
    }

    @ViewBuilder
    private func compactRow(item: ListItem) -> some View {
        HStack(spacing: Spacing.sm) {
            Image(systemName: item.icon)
                .font(PPFont.bodyLg)
                .foregroundStyle(item.iconColor)
                .frame(width: 24)

            Text(item.title)
                .font(PPFont.bodyLg)

            Spacer()

            Text(item.subtitle)
                .font(PPFont.bodyMd)
                .foregroundStyle(Color.fgSecondary)

            Image(systemName: "chevron.right")
                .font(PPFont.caption)
                .foregroundStyle(Color.fgTertiary)
        }
        .frame(minHeight: 44)
    }
}

#Preview {
    NavigationStack {
        ListDemoView()
    }
}
