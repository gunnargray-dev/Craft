import SwiftUI

struct SharedElementItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
}

struct SharedElementView: View {
    @Namespace private var namespace
    @State private var selectedItem: SharedElementItem?
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private let items: [SharedElementItem] = [
        SharedElementItem(title: "Photos", subtitle: "Capture memories in stunning detail", icon: "photo.fill", color: Color.blue600),
        SharedElementItem(title: "Music", subtitle: "Listen to millions of songs anywhere", icon: "music.note", color: Color.pink600),
        SharedElementItem(title: "Weather", subtitle: "Forecasts and conditions at a glance", icon: "cloud.sun.fill", color: Color.orange600),
        SharedElementItem(title: "Maps", subtitle: "Navigate the world around you", icon: "map.fill", color: Color.green600),
        SharedElementItem(title: "Notes", subtitle: "Quick thoughts and detailed documents", icon: "note.text", color: Color.yellow600),
        SharedElementItem(title: "Health", subtitle: "Track your wellness and activity", icon: "heart.fill", color: Color.red600),
    ]

    private let gridColumns = [
        GridItem(.flexible(), spacing: Spacing.sm),
        GridItem(.flexible(), spacing: Spacing.sm),
    ]

    var body: some View {
        ZStack {
            // MARK: - Grid
            ScrollView {
                LazyVGrid(columns: gridColumns, spacing: Spacing.sm) {
                    ForEach(items) { item in
                        gridCard(for: item)
                            .enterAnimation(delay: Double(items.firstIndex(where: { $0.id == item.id }) ?? 0) * 0.05)
                    }
                }
                .padding(.horizontal, Spacing.systemMargin)
                .padding(.vertical, Spacing.md)
            }
            .background(Color.bgBase)
            .opacity(selectedItem == nil ? 1 : 0)
            .navigationTitle("Shared Element")

            // MARK: - Expanded Detail
            if let selected = selectedItem {
                expandedOverlay(for: selected)
            }
        }
    }

    // MARK: - Grid Card

    private func gridCard(for item: SharedElementItem) -> some View {
        VStack(spacing: Spacing.sm) {
            Image(systemName: item.icon)
                .font(PPFont.title)
                .foregroundStyle(Color.fgInverse)
                .frame(width: 56, height: 56)
                .background(item.color.gradient)
                .clipShape(RoundedRectangle(cornerRadius: CornerRadius.md, style: .continuous))
                .matchedGeometryEffect(id: "\(item.id)-icon", in: namespace)

            Text(item.title)
                .font(PPFont.bodyMdStrong)
                .matchedGeometryEffect(id: "\(item.id)-title", in: namespace)
        }
        .frame(maxWidth: .infinity)
        .padding(Spacing.md)
        .background(
            RoundedRectangle(cornerRadius: CornerRadius.lg, style: .continuous)
                .fill(Color.bgRaised)
                .matchedGeometryEffect(id: "\(item.id)-bg", in: namespace)
        )
        .shadowSmall()
        .contentShape(RoundedRectangle(cornerRadius: CornerRadius.lg, style: .continuous))
        .pressEffect {
            withAnimation(reduceMotion ? .default : Springs.responsive) {
                selectedItem = item
            }
        }
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel("Expand \(item.title)")
    }

    // MARK: - Expanded Overlay

    private func expandedOverlay(for item: SharedElementItem) -> some View {
        ZStack {
            // Dimmed background
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(reduceMotion ? .default : Springs.responsive) {
                        selectedItem = nil
                    }
                }
                .accessibilityAddTraits(.isButton)
                .accessibilityLabel("Dismiss")

            // Expanded card
            VStack(spacing: Spacing.lg) {
                Image(systemName: item.icon)
                    .font(.system(size: 44))
                    .foregroundStyle(Color.fgInverse)
                    .frame(width: 88, height: 88)
                    .background(item.color.gradient)
                    .clipShape(RoundedRectangle(cornerRadius: CornerRadius.xl, style: .continuous))
                    .matchedGeometryEffect(id: "\(item.id)-icon", in: namespace)
                    .shadowMedium()

                VStack(spacing: Spacing.xs) {
                    Text(item.title)
                        .font(PPFont.title)
                        .matchedGeometryEffect(id: "\(item.id)-title", in: namespace)

                    Text(item.subtitle)
                        .font(PPFont.bodyLg)
                        .foregroundStyle(Color.fgSecondary)
                        .multilineTextAlignment(.center)
                }

                Spacer()

                CraftButton(
                    title: "Close",
                    level: .secondary,
                    size: .large,
                    icon: "xmark",
                    isFullWidth: true
                ) {
                    withAnimation(reduceMotion ? .default : Springs.responsive) {
                        selectedItem = nil
                    }
                }
            }
            .padding(Spacing.lg)
            .frame(maxWidth: .infinity, maxHeight: 360)
            .background(
                RoundedRectangle(cornerRadius: CornerRadius.xl, style: .continuous)
                    .fill(Color.bgBase)
                    .matchedGeometryEffect(id: "\(item.id)-bg", in: namespace)
            )
            .shadowLarge()
            .padding(.horizontal, Spacing.lg)
        }
    }
}

#Preview {
    NavigationStack {
        SharedElementView()
    }
}
