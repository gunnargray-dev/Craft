import SwiftUI

enum EmptyStateVariant: String, CaseIterable, Identifiable {
    case firstRun = "First Run"
    case error = "Error"
    case noResults = "No Results"

    var id: String { rawValue }
}

struct EmptyStateDemoView: View {
    @State private var selectedVariant: EmptyStateVariant = .firstRun
    @State private var retryCount = 0
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // MARK: - Variant Picker
                Text("Variant")
                    .sectionHeader()
                    .enterAnimation(delay: 0.0)

                Picker("Variant", selection: $selectedVariant) {
                    ForEach(EmptyStateVariant.allCases) { variant in
                        Text(variant.rawValue).tag(variant)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, Spacing.systemMargin)
                .enterAnimation(delay: 0.05)

                // MARK: - Empty State Preview
                Spacer(minLength: Spacing.xxl)

                Group {
                    switch selectedVariant {
                    case .firstRun:
                        firstRunState
                    case .error:
                        errorState
                    case .noResults:
                        noResultsState
                    }
                }
                .transition(.asymmetric(
                    insertion: .opacity.combined(with: .scale(scale: 0.95)),
                    removal: .opacity.combined(with: .scale(scale: 1.02))
                ))
                .animation(reduceMotion ? .default : Springs.responsive, value: selectedVariant)
                .id(selectedVariant)
                .padding(.horizontal, Spacing.systemMargin)

                Spacer(minLength: Spacing.xxl)
            }
        }
        .background(Color.bgBase)
        .navigationTitle("Empty States")
    }

    // MARK: - First Run

    private var firstRunState: some View {
        VStack(spacing: Spacing.lg) {
            ZStack {
                Circle()
                    .fill(Color.accentFgPrimary.opacity(0.1))
                    .frame(width: 120, height: 120)

                Image(systemName: "sparkles")
                    .font(.system(size: 48))
                    .foregroundStyle(Color.accentFgPrimary)
                    .symbolEffect(.pulse)
            }
            .enterAnimation(delay: 0.1)

            VStack(spacing: Spacing.xs) {
                Text("Welcome to Craft")
                    .font(PPFont.title)
                    .multilineTextAlignment(.center)

                Text("Your design system reference, all in one place. Explore components, typography, color, spacing, and motion patterns.")
                    .font(PPFont.bodyMd)
                    .foregroundStyle(Color.fgSecondary)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .enterAnimation(delay: 0.15)

            VStack(spacing: Spacing.sm) {
                CraftButton(
                    title: "Get Started",
                    level: .primary,
                    size: .large,
                    icon: "arrow.right",
                    isFullWidth: true
                ) {}

                CraftButton(
                    title: "Learn More",
                    level: .tertiary,
                    size: .medium
                ) {}
            }
            .enterAnimation(delay: 0.2)
        }
    }

    // MARK: - Error

    private var errorState: some View {
        VStack(spacing: Spacing.lg) {
            ZStack {
                Circle()
                    .fill(Color.negativeBgBase)
                    .frame(width: 120, height: 120)

                Image(systemName: "exclamationmark.icloud.fill")
                    .font(.system(size: 48))
                    .foregroundStyle(Color.negativeFgPrimary)
            }
            .enterAnimation(delay: 0.1)

            VStack(spacing: Spacing.xs) {
                Text("Something Went Wrong")
                    .font(PPFont.title)
                    .multilineTextAlignment(.center)

                Text("We couldn't load the content. Check your connection and try again.")
                    .font(PPFont.bodyMd)
                    .foregroundStyle(Color.fgSecondary)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)

                if retryCount > 0 {
                    Text("Retried \(retryCount) time\(retryCount == 1 ? "" : "s")")
                        .font(PPFont.caption)
                        .foregroundStyle(Color.fgTertiary)
                        .contentTransition(.numericText(value: Double(retryCount)))
                }
            }
            .enterAnimation(delay: 0.15)

            VStack(spacing: Spacing.sm) {
                CraftButton(
                    title: "Try Again",
                    level: .primary,
                    size: .large,
                    icon: "arrow.clockwise",
                    isFullWidth: true
                ) {
                    withAnimation(reduceMotion ? .default : Springs.snappy) {
                        retryCount += 1
                    }
                }

                CraftButton(
                    title: "Contact Support",
                    level: .tertiary,
                    size: .medium,
                    icon: "envelope"
                ) {}
            }
            .enterAnimation(delay: 0.2)
        }
    }

    // MARK: - No Results

    private var noResultsState: some View {
        VStack(spacing: Spacing.lg) {
            ZStack {
                Circle()
                    .fill(Color.warningBgBase)
                    .frame(width: 120, height: 120)

                Image(systemName: "magnifyingglass")
                    .font(.system(size: 48))
                    .foregroundStyle(Color.warningFgPrimary)
            }
            .enterAnimation(delay: 0.1)

            VStack(spacing: Spacing.xs) {
                Text("No Results Found")
                    .font(PPFont.title)
                    .multilineTextAlignment(.center)

                Text("Try adjusting your search or filters to find what you're looking for.")
                    .font(PPFont.bodyMd)
                    .foregroundStyle(Color.fgSecondary)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .enterAnimation(delay: 0.15)

            VStack(alignment: .leading, spacing: Spacing.sm) {
                Text("Suggestions")
                    .font(PPFont.bodyMdStrong)
                    .frame(maxWidth: .infinity, alignment: .leading)

                suggestionRow(icon: "textformat.abc", text: "Check for spelling errors")
                suggestionRow(icon: "line.3.horizontal.decrease.circle", text: "Remove some filters")
                suggestionRow(icon: "arrow.uturn.backward", text: "Try a broader search term")
            }
            .padding(Spacing.md)
            .background(Color.bgSoft)
            .clipShape(RoundedRectangle(cornerRadius: CornerRadius.lg, style: .continuous))
            .enterAnimation(delay: 0.2)

            CraftButton(
                title: "Clear Filters",
                level: .secondary,
                size: .large,
                icon: "xmark.circle",
                isFullWidth: true
            ) {}
            .enterAnimation(delay: 0.25)
        }
    }

    private func suggestionRow(icon: String, text: String) -> some View {
        HStack(spacing: Spacing.sm) {
            Image(systemName: icon)
                .font(PPFont.bodyMd)
                .foregroundStyle(Color.fgSecondary)
                .frame(width: 24)
            Text(text)
                .font(PPFont.bodyMd)
                .foregroundStyle(Color.fgSecondary)
        }
    }
}

#Preview {
    NavigationStack {
        EmptyStateDemoView()
    }
}
