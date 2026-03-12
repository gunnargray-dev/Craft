import SwiftUI

struct SizeClassView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.layoutDirection) private var layoutDirection

    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.lg) {
                Text("These values update live as you rotate the device or change multitasking layout.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .enterAnimation(delay: 0.0)

                // Size Classes
                VStack(spacing: Spacing.sm) {
                    Text("Size Classes")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                        .textCase(.uppercase)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    HStack(spacing: Spacing.sm) {
                        SizeClassCard(
                            axis: "Horizontal",
                            icon: "arrow.left.and.right",
                            value: horizontalSizeClass?.label ?? "Unknown"
                        )

                        SizeClassCard(
                            axis: "Vertical",
                            icon: "arrow.up.and.down",
                            value: verticalSizeClass?.label ?? "Unknown"
                        )
                    }
                }
                .enterAnimation(delay: 0.05)

                // Current Traits
                VStack(spacing: Spacing.sm) {
                    Text("Current Traits")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                        .textCase(.uppercase)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    VStack(spacing: 0) {
                        TraitRow(
                            label: "Dynamic Type",
                            value: dynamicTypeSize.label,
                            icon: "textformat.size",
                            showDivider: true
                        )
                        TraitRow(
                            label: "Color Scheme",
                            value: colorScheme == .dark ? "Dark" : "Light",
                            icon: colorScheme == .dark ? "moon.fill" : "sun.max.fill",
                            showDivider: true
                        )
                        TraitRow(
                            label: "Layout Direction",
                            value: layoutDirection == .leftToRight ? "LTR" : "RTL",
                            icon: "text.alignleft",
                            showDivider: false
                        )
                    }
                    .background(.background, in: RoundedRectangle(cornerRadius: CornerRadius.lg))
                    .shadowSmall()
                }
                .enterAnimation(delay: 0.1)

                // Layout Summary
                VStack(spacing: Spacing.sm) {
                    Text("Layout Guidance")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                        .textCase(.uppercase)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    VStack(alignment: .leading, spacing: Spacing.sm) {
                        Label {
                            Text(layoutGuidance)
                                .font(.body)
                        } icon: {
                            Image(systemName: "lightbulb.fill")
                                .foregroundStyle(.yellow)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(Spacing.md)
                    .background(.background, in: RoundedRectangle(cornerRadius: CornerRadius.lg))
                    .shadowSmall()
                }
                .enterAnimation(delay: 0.15)
            }
            .padding(.horizontal, Spacing.systemMargin)
            .padding(.top, Spacing.sm)
            .padding(.bottom, Spacing.xxl)
        }
        .navigationTitle("Size Class")
        .navigationBarTitleDisplayMode(.inline)
        .animation(Springs.responsive, value: horizontalSizeClass)
        .animation(Springs.responsive, value: verticalSizeClass)
    }

    private var layoutGuidance: String {
        if horizontalSizeClass == .regular && verticalSizeClass == .regular {
            return "Regular/Regular — iPad full screen. Use multi-column layouts, sidebars, and wider content."
        } else if horizontalSizeClass == .regular {
            return "Regular/Compact — Landscape iPad or large iPhone landscape. Consider side-by-side content."
        } else if verticalSizeClass == .compact {
            return "Compact/Compact — iPhone landscape. Minimize vertical stacking, use horizontal layouts."
        } else {
            return "Compact/Regular — iPhone portrait. Standard single-column layout with full vertical space."
        }
    }
}

// MARK: - Size Class Card

private struct SizeClassCard: View {
    let axis: String
    let icon: String
    let value: String

    var body: some View {
        VStack(spacing: Spacing.sm) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(.tint)
                .frame(width: 44, height: 44)
                .background(.tint.opacity(0.12), in: RoundedRectangle(cornerRadius: CornerRadius.sm))

            Text(axis)
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
                .contentTransition(.numericText())
        }
        .frame(maxWidth: .infinity)
        .padding(Spacing.lg)
        .background(.background, in: RoundedRectangle(cornerRadius: CornerRadius.lg))
        .shadowMedium()
    }
}

// MARK: - Trait Row

private struct TraitRow: View {
    let label: String
    let value: String
    let icon: String
    let showDivider: Bool

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: Spacing.sm) {
                Image(systemName: icon)
                    .font(.body)
                    .foregroundStyle(.tint)
                    .frame(width: 28)

                Text(label)
                    .font(.body)
                    .foregroundStyle(.primary)

                Spacer(minLength: 0)

                Text(value)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
            }
            .frame(minHeight: 44)
            .padding(.horizontal, Spacing.md)

            if showDivider {
                Divider()
                    .padding(.leading, Spacing.md + 28 + Spacing.sm)
            }
        }
    }
}

// MARK: - Extensions

private extension UserInterfaceSizeClass {
    var label: String {
        switch self {
        case .compact: return "Compact"
        case .regular: return "Regular"
        @unknown default: return "Unknown"
        }
    }
}

private extension DynamicTypeSize {
    var label: String {
        switch self {
        case .xSmall: return "xSmall"
        case .small: return "Small"
        case .medium: return "Medium"
        case .large: return "Large"
        case .xLarge: return "xLarge"
        case .xxLarge: return "xxLarge"
        case .xxxLarge: return "xxxLarge"
        case .accessibility1: return "AX1"
        case .accessibility2: return "AX2"
        case .accessibility3: return "AX3"
        case .accessibility4: return "AX4"
        case .accessibility5: return "AX5"
        @unknown default: return "Unknown"
        }
    }
}

#Preview {
    NavigationStack {
        SizeClassView()
    }
}
