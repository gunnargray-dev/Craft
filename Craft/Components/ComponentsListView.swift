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

                Section("Text Inputs") {
                    NavigationLink {
                        TextInputDemoView()
                    } label: {
                        Label("Text Fields", systemImage: "character.cursor.ibeam")
                    }
                    .enterAnimation(delay: 0.05)
                }

                Section("Cards") {
                    NavigationLink {
                        CardGalleryView()
                    } label: {
                        Label("Card Variants", systemImage: "rectangle.on.rectangle")
                    }
                    .enterAnimation(delay: 0.1)
                }

                Section("Lists") {
                    NavigationLink {
                        ListDemoView()
                    } label: {
                        Label("List Cells", systemImage: "list.bullet")
                    }
                    .enterAnimation(delay: 0.15)
                }

                Section("Sheets") {
                    NavigationLink {
                        SheetDemoView()
                    } label: {
                        Label("Sheet Detents", systemImage: "rectangle.bottomhalf.inset.filled")
                    }
                    .enterAnimation(delay: 0.2)
                }

                Section("Empty States") {
                    NavigationLink {
                        EmptyStateDemoView()
                    } label: {
                        Label("Empty States", systemImage: "tray")
                    }
                    .enterAnimation(delay: 0.25)
                }
            }
            .navigationTitle("Components")
        }
    }
}

#Preview {
    ComponentsListView()
}
