import SwiftUI

struct ComponentsListView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Buttons") {
                    NavigationLink {
                        ButtonGalleryView()
                    } label: {
                        Label("Button Gallery", systemImage: "rectangle.and.hand.point.up.left.filled")
                    }
                    .enterAnimation(delay: 0.0)
                }
                .listRowBackground(Color.bgRaised)

                Section("Text Inputs") {
                    NavigationLink {
                        TextInputDemoView()
                    } label: {
                        Label("Text Fields", systemImage: "character.cursor.ibeam")
                    }
                    .enterAnimation(delay: 0.05)
                }
                .listRowBackground(Color.bgRaised)

                Section("Cards") {
                    NavigationLink {
                        CardGalleryView()
                    } label: {
                        Label("Card Variants", systemImage: "rectangle.on.rectangle")
                    }
                    .enterAnimation(delay: 0.1)
                }
                .listRowBackground(Color.bgRaised)

                Section("Lists") {
                    NavigationLink {
                        ListDemoView()
                    } label: {
                        Label("List Cells", systemImage: "list.bullet")
                    }
                    .enterAnimation(delay: 0.15)
                }
                .listRowBackground(Color.bgRaised)

                Section("Sheets") {
                    NavigationLink {
                        SheetDemoView()
                    } label: {
                        Label("Sheet Detents", systemImage: "rectangle.bottomhalf.inset.filled")
                    }
                    .enterAnimation(delay: 0.2)
                }
                .listRowBackground(Color.bgRaised)

                Section("Empty States") {
                    NavigationLink {
                        EmptyStateDemoView()
                    } label: {
                        Label("Empty States", systemImage: "tray")
                    }
                    .enterAnimation(delay: 0.25)
                }
                .listRowBackground(Color.bgRaised)
            }
            .scrollContentBackground(.hidden)
            .background(Color.bgBase)
            .navigationTitle("Components")
        }
    }
}

#Preview {
    ComponentsListView()
}
