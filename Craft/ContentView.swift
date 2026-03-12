import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Components", systemImage: "square.on.square") {
                NavigationStack {
                    ComponentsListView()
                }
            }
            Tab("Foundation", systemImage: "textformat") {
                NavigationStack {
                    FoundationListView()
                }
            }
            Tab("Motion", systemImage: "wand.and.stars") {
                NavigationStack {
                    MotionListView()
                }
            }
            Tab("Audit", systemImage: "checkmark.shield") {
                NavigationStack {
                    AuditListView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
