import SwiftUI

struct SpringPreset: Identifiable {
    let id = UUID()
    let name: String
    let response: Double
    let damping: Double
}

struct SpringPlaygroundView: View {
    private let presets: [SpringPreset] = [
        SpringPreset(name: "Snappy", response: 0.3, damping: 0.7),
        SpringPreset(name: "Responsive", response: 0.4, damping: 0.75),
        SpringPreset(name: "Smooth", response: 0.5, damping: 0.8),
        SpringPreset(name: "Bouncy", response: 0.5, damping: 0.5),
        SpringPreset(name: "Stiff", response: 0.2, damping: 0.8),
    ]

    @State private var response: Double = 0.3
    @State private var damping: Double = 0.7
    @State private var selectedPreset: String = "Snappy"
    @State private var circleOffset: CGSize = .zero
    @State private var isDragging = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private var currentSpring: Animation {
        .spring(response: response, dampingFraction: damping)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.lg) {
                // MARK: - Preset Buttons
                presetButtons
                    .enterAnimation(delay: 0.0)

                // MARK: - Draggable Circle
                dragArea
                    .enterAnimation(delay: 0.05)

                // MARK: - Current Values
                valuesDisplay
                    .enterAnimation(delay: 0.1)

                // MARK: - Sliders
                sliderControls
                    .enterAnimation(delay: 0.15)
            }
            .padding(.horizontal, Spacing.systemMargin)
            .padding(.vertical, Spacing.md)
        }
        .navigationTitle("Spring Playground")
    }

    // MARK: - Preset Buttons

    private var presetButtons: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Spacing.xs) {
                ForEach(presets) { preset in
                    presetButton(for: preset)
                }
            }
            .padding(.horizontal, Spacing.xxs)
        }
    }

    private func presetButton(for preset: SpringPreset) -> some View {
        let isSelected = selectedPreset == preset.name
        return Text(preset.name)
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(isSelected ? .white : .primary)
            .padding(.horizontal, Spacing.md)
            .padding(.vertical, Spacing.sm)
            .frame(minHeight: 44)
            .background(isSelected ? Color.accentColor : Color(.tertiarySystemFill))
            .clipShape(RoundedRectangle(cornerRadius: CornerRadius.sm, style: .continuous))
            .contentShape(RoundedRectangle(cornerRadius: CornerRadius.sm, style: .continuous))
            .pressEffect {
                withAnimation(reduceMotion ? .default : Springs.snappy) {
                    selectedPreset = preset.name
                    response = preset.response
                    damping = preset.damping
                }
            }
            .accessibilityAddTraits(.isButton)
    }

    // MARK: - Drag Area

    private var dragArea: some View {
        ZStack {
            RoundedRectangle(cornerRadius: CornerRadius.lg, style: .continuous)
                .fill(Color(.secondarySystemBackground))
                .frame(height: 280)

            // Origin crosshair
            Circle()
                .strokeBorder(Color(.quaternaryLabel), lineWidth: 1.5)
                .frame(width: 80, height: 80)

            // Draggable circle
            Circle()
                .fill(Color.accentColor)
                .frame(width: 72, height: 72)
                .shadowMedium()
                .offset(circleOffset)
                .gesture(dragGesture)
                .accessibilityLabel("Draggable spring circle")
                .accessibilityHint("Drag and release to see the spring animation")
        }
    }

    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                isDragging = true
                circleOffset = value.translation
            }
            .onEnded { _ in
                isDragging = false
                withAnimation(reduceMotion ? .default : currentSpring) {
                    circleOffset = .zero
                }
            }
    }

    // MARK: - Values Display

    private var valuesDisplay: some View {
        HStack(spacing: Spacing.lg) {
            VStack(spacing: Spacing.xxs) {
                Text("Response")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(String(format: "%.2f", response))
                    .font(.title2.weight(.semibold).monospacedDigit())
            }

            VStack(spacing: Spacing.xxs) {
                Text("Damping")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(String(format: "%.2f", damping))
                    .font(.title2.weight(.semibold).monospacedDigit())
            }
        }
        .padding(Spacing.md)
        .frame(maxWidth: .infinity)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: CornerRadius.md, style: .continuous))
    }

    // MARK: - Slider Controls

    private var sliderControls: some View {
        VStack(spacing: Spacing.lg) {
            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text("Response")
                    .font(.subheadline.weight(.semibold))
                HStack(spacing: Spacing.sm) {
                    Text("0.1")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Slider(value: $response, in: 0.1...1.0, step: 0.01) {
                        Text("Response")
                    }
                    .onChange(of: response) {
                        selectedPreset = "Custom"
                    }
                    Text("1.0")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text("Damping Fraction")
                    .font(.subheadline.weight(.semibold))
                HStack(spacing: Spacing.sm) {
                    Text("0.1")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Slider(value: $damping, in: 0.1...1.0, step: 0.01) {
                        Text("Damping")
                    }
                    .onChange(of: damping) {
                        selectedPreset = "Custom"
                    }
                    Text("1.0")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(Spacing.md)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: CornerRadius.md, style: .continuous))
    }
}

#Preview {
    NavigationStack {
        SpringPlaygroundView()
    }
}
