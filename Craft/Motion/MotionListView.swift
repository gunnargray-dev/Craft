import SwiftUI

struct MotionListView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Springs") {
                    NavigationLink {
                        SpringPlaygroundView()
                    } label: {
                        Label("Spring Playground", systemImage: "bolt.circle")
                    }
                    .enterAnimation(delay: 0.0)
                }

                Section("Transitions") {
                    NavigationLink {
                        EnterExitDemoView()
                    } label: {
                        Label("Enter / Exit", systemImage: "arrow.up.arrow.down")
                    }
                    .enterAnimation(delay: 0.05)
                }

                Section("Sequencing") {
                    NavigationLink {
                        StaggerDemoView()
                    } label: {
                        Label("Stagger", systemImage: "square.stack.3d.up")
                    }
                    .enterAnimation(delay: 0.1)
                }

                Section("Layout") {
                    NavigationLink {
                        SharedElementView()
                    } label: {
                        Label("Shared Element", systemImage: "rectangle.expand.vertical")
                    }
                    .enterAnimation(delay: 0.15)
                }

                Section("Feedback") {
                    NavigationLink {
                        HapticsDemoView()
                    } label: {
                        Label("Haptics", systemImage: "iphone.radiowaves.left.and.right")
                    }
                    .enterAnimation(delay: 0.2)

                    NavigationLink {
                        GestureDemoView()
                    } label: {
                        Label("Gestures", systemImage: "hand.draw")
                    }
                    .enterAnimation(delay: 0.25)
                }
            }
            .navigationTitle("Motion")
        }
    }
}

#Preview {
    MotionListView()
}
