import SwiftUI

struct FoundationListView: View {
    var body: some View {
        List {
            Section {
                foundationRow(
                    icon: "textformat.size",
                    title: "Type Scale",
                    delay: 0.0
                ) {
                    TypeScaleView()
                }
                foundationRow(
                    icon: "text.alignleft",
                    title: "Type Hierarchy",
                    delay: 0.05
                ) {
                    TypeHierarchyView()
                }
                foundationRow(
                    icon: "paintpalette",
                    title: "Color Palette",
                    delay: 0.1
                ) {
                    ColorPaletteView()
                }
                foundationRow(
                    icon: "ruler",
                    title: "Spacing",
                    delay: 0.15
                ) {
                    SpacingRulerView()
                }
                foundationRow(
                    icon: "rectangle.roundedtop",
                    title: "Border Radius",
                    delay: 0.2
                ) {
                    BorderRadiusView()
                }
            }
            .listRowBackground(Color.bgRaised)
        }
        .scrollContentBackground(.hidden)
        .background(Color.bgBase)
        .navigationTitle("Foundation")
    }

    private func foundationRow<Destination: View>(
        icon: String,
        title: String,
        delay: Double,
        @ViewBuilder destination: () -> Destination
    ) -> some View {
        NavigationLink {
            destination()
        } label: {
            Label(title, systemImage: icon)
                .frame(minHeight: 44)
        }
        .enterAnimation(delay: delay)
    }
}

#Preview {
    NavigationStack {
        FoundationListView()
    }
}
