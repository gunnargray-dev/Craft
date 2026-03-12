import SwiftUI

struct GestureDemoView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.xl) {
                // MARK: - Swipe Demo
                SwipeSection()
                    .enterAnimation(delay: 0.0)

                // MARK: - Long Press Demo
                LongPressSection()
                    .enterAnimation(delay: 0.1)

                // MARK: - Drag Demo
                DragSection()
                    .enterAnimation(delay: 0.2)
            }
            .padding(.horizontal, Spacing.systemMargin)
            .padding(.vertical, Spacing.md)
        }
        .navigationTitle("Gestures")
    }
}

// MARK: - Section Header

private struct GestureSectionHeader: View {
    let title: String
    let subtitle: String
    let icon: String

    var body: some View {
        HStack(spacing: Spacing.sm) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(Color.accentColor)
                .frame(width: 36, height: 36)
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .font(.headline)
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
    }
}

// MARK: - Swipe Section

private struct SwipeSection: View {
    @State private var swipeOffset: CGFloat = 0
    @State private var isDragging = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private var swipeProgress: CGFloat {
        min(abs(swipeOffset) / 120, 1.0)
    }

    private var swipeDirection: String {
        if swipeOffset > 20 { return "Right" }
        if swipeOffset < -20 { return "Left" }
        return "Neutral"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            GestureSectionHeader(
                title: "Swipe",
                subtitle: "Swipe left or right with visual feedback",
                icon: "hand.draw"
            )

            ZStack {
                // Background indicators
                HStack {
                    Image(systemName: "arrow.left.circle.fill")
                        .font(.title)
                        .foregroundStyle(.red)
                        .opacity(swipeOffset < -20 ? Double(swipeProgress) : 0)
                    Spacer()
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.title)
                        .foregroundStyle(.green)
                        .opacity(swipeOffset > 20 ? Double(swipeProgress) : 0)
                }
                .padding(.horizontal, Spacing.lg)

                // Swipeable card
                HStack(spacing: Spacing.sm) {
                    Image(systemName: "envelope.fill")
                        .font(.title2)
                        .foregroundStyle(Color.accentColor)
                    VStack(alignment: .leading, spacing: Spacing.xxs) {
                        Text("Swipeable Card")
                            .font(.body.weight(.semibold))
                        Text("Direction: \(swipeDirection)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                }
                .padding(Spacing.md)
                .frame(minHeight: 64)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: CornerRadius.md, style: .continuous))
                .shadowSmall()
                .offset(x: swipeOffset)
                .rotationEffect(.degrees(Double(swipeOffset) / 20), anchor: .bottom)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            isDragging = true
                            swipeOffset = value.translation.width
                        }
                        .onEnded { _ in
                            isDragging = false
                            // Fire haptic at threshold
                            if abs(swipeOffset) > 100 {
                                let generator = UIImpactFeedbackGenerator(style: .medium)
                                generator.impactOccurred()
                            }
                            withAnimation(reduceMotion ? .default : Springs.snappy) {
                                swipeOffset = 0
                            }
                        }
                )
            }
            .frame(height: 80)
            .clipShape(RoundedRectangle(cornerRadius: CornerRadius.md, style: .continuous))
        }
        .padding(Spacing.md)
        .background(Color(.tertiarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: CornerRadius.lg, style: .continuous))
    }
}

// MARK: - Long Press Section

private struct LongPressSection: View {
    @State private var isPressed = false
    @State private var isCompleted = false
    @State private var progress: CGFloat = 0
    @State private var timer: Timer?
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            GestureSectionHeader(
                title: "Long Press",
                subtitle: "Hold to fill the progress ring",
                icon: "hand.tap"
            )

            HStack {
                Spacer()
                ZStack {
                    // Background ring
                    Circle()
                        .stroke(Color(.tertiarySystemFill), lineWidth: 6)
                        .frame(width: 100, height: 100)

                    // Progress ring
                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(
                            isCompleted ? Color.green : Color.accentColor,
                            style: StrokeStyle(lineWidth: 6, lineCap: .round)
                        )
                        .frame(width: 100, height: 100)
                        .rotationEffect(.degrees(-90))
                        .animation(reduceMotion ? .default : .linear(duration: 0.05), value: progress)

                    // Center icon
                    Image(systemName: isCompleted ? "checkmark" : "hand.tap.fill")
                        .font(.title)
                        .foregroundStyle(isCompleted ? .green : .accentColor)
                        .contentTransition(.symbolEffect(.replace))
                }
                .frame(width: 100, height: 100)
                .contentShape(Circle())
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            guard !isPressed, !isCompleted else { return }
                            isPressed = true
                            startProgress()
                        }
                        .onEnded { _ in
                            isPressed = false
                            if !isCompleted {
                                cancelProgress()
                            }
                        }
                )
                .accessibilityLabel("Long press button")
                .accessibilityHint("Press and hold to complete")
                Spacer()
            }

            if isCompleted {
                HStack {
                    Spacer()
                    CraftButton(title: "Reset", level: .tertiary, size: .small) {
                        withAnimation(reduceMotion ? .default : Springs.snappy) {
                            isCompleted = false
                            progress = 0
                        }
                    }
                    Spacer()
                }
            }
        }
        .padding(Spacing.md)
        .background(Color(.tertiarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: CornerRadius.lg, style: .continuous))
    }

    private func startProgress() {
        let step: CGFloat = 0.02
        let interval: TimeInterval = 0.03
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { t in
            if progress >= 1.0 {
                t.invalidate()
                timer = nil
                isCompleted = true
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
            } else if !isPressed {
                t.invalidate()
                timer = nil
            } else {
                progress += step
                // Tick haptic at 25% intervals
                let prev = progress - step
                for threshold in [0.25, 0.5, 0.75] as [CGFloat] {
                    if prev < threshold && progress >= threshold {
                        let generator = UIImpactFeedbackGenerator(style: .light)
                        generator.impactOccurred()
                    }
                }
            }
        }
    }

    private func cancelProgress() {
        timer?.invalidate()
        timer = nil
        withAnimation(reduceMotion ? .default : Springs.snappy) {
            progress = 0
        }
    }
}

// MARK: - Drag Section

private struct DragSection: View {
    @State private var dragOffset: CGSize = .zero
    @State private var isDragging = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            GestureSectionHeader(
                title: "Drag",
                subtitle: "Freely drag the square, springs back on release",
                icon: "arrow.up.and.down.and.arrow.left.and.right"
            )

            ZStack {
                RoundedRectangle(cornerRadius: CornerRadius.lg, style: .continuous)
                    .fill(Color(.secondarySystemBackground))
                    .frame(height: 220)

                // Origin indicator
                RoundedRectangle(cornerRadius: CornerRadius.md, style: .continuous)
                    .strokeBorder(Color(.quaternaryLabel), style: StrokeStyle(lineWidth: 1.5, dash: [6, 4]))
                    .frame(width: 68, height: 68)

                // Draggable square
                RoundedRectangle(cornerRadius: CornerRadius.md, style: .continuous)
                    .fill(Color.accentColor.gradient)
                    .frame(width: 64, height: 64)
                    .shadowMedium()
                    .scaleEffect(isDragging ? 1.08 : 1.0)
                    .offset(dragOffset)
                    .animation(reduceMotion ? .default : Springs.snappy, value: isDragging)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if !isDragging {
                                    isDragging = true
                                    let generator = UIImpactFeedbackGenerator(style: .light)
                                    generator.impactOccurred()
                                }
                                dragOffset = value.translation
                            }
                            .onEnded { _ in
                                isDragging = false
                                let generator = UIImpactFeedbackGenerator(style: .medium)
                                generator.impactOccurred()
                                withAnimation(reduceMotion ? .default : Springs.responsive) {
                                    dragOffset = .zero
                                }
                            }
                    )
                    .accessibilityLabel("Draggable square")
                    .accessibilityHint("Drag freely and release to see spring animation")
            }

            // Offset readout
            HStack {
                Spacer()
                Text("x: \(String(format: "%.0f", dragOffset.width))  y: \(String(format: "%.0f", dragOffset.height))")
                    .font(.caption.monospacedDigit())
                    .foregroundStyle(.secondary)
                Spacer()
            }
        }
        .padding(Spacing.md)
        .background(Color(.tertiarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: CornerRadius.lg, style: .continuous))
    }
}

#Preview {
    NavigationStack {
        GestureDemoView()
    }
}
