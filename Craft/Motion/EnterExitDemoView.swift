import SwiftUI

struct EnterExitDemoView: View {
    @State private var isVisible = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.lg) {
                // MARK: - Toggle Button
                toggleButton
                    .enterAnimation(delay: 0.0)

                // MARK: - Animation Parameters
                parametersCard
                    .enterAnimation(delay: 0.05)

                // MARK: - Demo Card
                demoArea
                    .enterAnimation(delay: 0.1)
            }
            .padding(.horizontal, Spacing.systemMargin)
            .padding(.vertical, Spacing.md)
        }
        .background(Color.bgBase)
        .navigationTitle("Enter / Exit")
    }

    // MARK: - Toggle Button

    private var toggleButton: some View {
        CraftButton(
            title: isVisible ? "Hide Card" : "Show Card",
            level: isVisible ? .secondary : .primary,
            size: .large,
            icon: isVisible ? "eye.slash" : "eye",
            isFullWidth: true
        ) {
            if isVisible {
                // Exit: faster, subtle
                withAnimation(reduceMotion ? .default : .spring(response: 0.3, dampingFraction: 0.85)) {
                    isVisible = false
                }
            } else {
                // Enter: smooth spring
                withAnimation(reduceMotion ? .default : Springs.smooth) {
                    isVisible = true
                }
            }
        }
    }

    // MARK: - Parameters Card

    private var parametersCard: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text("Animation Parameters")
                .font(PPFont.section)

            Divider()

            HStack(spacing: Spacing.lg) {
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Label("Enter", systemImage: "arrow.down")
                        .font(PPFont.bodyMdStrong)
                        .foregroundStyle(Color.positiveFgPrimary)
                    Group {
                        Text("opacity: 0 \u{2192} 1")
                        Text("translateY: 20pt \u{2192} 0")
                        Text("blur: 4pt \u{2192} 0")
                        Text("spring: 0.5 / 0.8")
                    }
                    .font(PPFont.caption)
                    .foregroundStyle(Color.fgSecondary)
                }

                Spacer()

                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Label("Exit", systemImage: "arrow.up")
                        .font(PPFont.bodyMdStrong)
                        .foregroundStyle(Color.warningFgPrimary)
                    Group {
                        Text("opacity: 1 \u{2192} 0")
                        Text("translateY: 0 \u{2192} -12pt")
                        Text("blur: none")
                        Text("spring: 0.3 / 0.85")
                    }
                    .font(PPFont.caption)
                    .foregroundStyle(Color.fgSecondary)
                }
            }
        }
        .padding(Spacing.md)
        .background(Color.bgRaised)
        .clipShape(RoundedRectangle(cornerRadius: CornerRadius.md, style: .continuous))
    }

    // MARK: - Demo Area

    private var demoArea: some View {
        ZStack {
            RoundedRectangle(cornerRadius: CornerRadius.lg, style: .continuous)
                .fill(Color.bgSoft)
                .frame(height: 300)

            if isVisible {
                demoCard
                    .transition(.asymmetric(
                        insertion: .modifier(
                            active: EnterModifier(opacity: 0, offsetY: 20, blur: 4),
                            identity: EnterModifier(opacity: 1, offsetY: 0, blur: 0)
                        ),
                        removal: .modifier(
                            active: ExitModifier(opacity: 0, offsetY: -12),
                            identity: ExitModifier(opacity: 1, offsetY: 0)
                        )
                    ))
            }
        }
    }

    private var demoCard: some View {
        VStack(spacing: Spacing.sm) {
            Image(systemName: "sparkles")
                .font(PPFont.display)
                .foregroundStyle(Color.accentFgPrimary)

            Text("Animated Card")
                .font(PPFont.section)

            Text("This card enters with full motion and exits with a quieter animation.")
                .font(PPFont.bodyLg)
                .foregroundStyle(Color.fgSecondary)
                .multilineTextAlignment(.center)
        }
        .padding(Spacing.lg)
        .frame(maxWidth: 280)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: CornerRadius.lg, style: .continuous))
        .shadowMedium()
    }
}

// MARK: - Custom Transition Modifiers

private struct EnterModifier: ViewModifier {
    let opacity: Double
    let offsetY: CGFloat
    let blur: CGFloat

    func body(content: Content) -> some View {
        content
            .opacity(opacity)
            .offset(y: offsetY)
            .blur(radius: blur)
    }
}

private struct ExitModifier: ViewModifier {
    let opacity: Double
    let offsetY: CGFloat

    func body(content: Content) -> some View {
        content
            .opacity(opacity)
            .offset(y: offsetY)
    }
}

#Preview {
    NavigationStack {
        EnterExitDemoView()
    }
}
