import SwiftUI

struct CardGalleryView: View {
    @State private var tappedCard = false
    @State private var showSkeleton = false
    @State private var favorited = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private let innerRadius = CornerRadius.md
    private let cardPadding = Spacing.md

    private var outerRadius: CGFloat {
        CornerRadius.concentric(inner: innerRadius, padding: cardPadding)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // MARK: - Tappable Card
                Text("Tappable Card")
                    .sectionHeader()
                    .enterAnimation(delay: 0.0)

                tappableCard
                    .padding(.horizontal, Spacing.systemMargin)
                    .enterAnimation(delay: 0.05)

                // MARK: - Multi-Action Card
                Text("Multi-Action Card")
                    .sectionHeader()
                    .enterAnimation(delay: 0.15)

                multiActionCard
                    .padding(.horizontal, Spacing.systemMargin)
                    .enterAnimation(delay: 0.2)

                // MARK: - Loading Skeleton
                Text("Loading Skeleton")
                    .sectionHeader()
                    .enterAnimation(delay: 0.35)

                VStack(spacing: Spacing.md) {
                    Toggle("Show Skeleton", isOn: $showSkeleton)
                        .padding(.horizontal, Spacing.systemMargin)
                        .enterAnimation(delay: 0.4)

                    if showSkeleton {
                        skeletonCard
                            .padding(.horizontal, Spacing.systemMargin)
                            .transition(.opacity)
                    } else {
                        loadedCard
                            .padding(.horizontal, Spacing.systemMargin)
                            .transition(.opacity)
                    }
                }
                .animation(reduceMotion ? .default : Springs.responsive, value: showSkeleton)
                .enterAnimation(delay: 0.45)

                // MARK: - Concentric Radius Demo
                Text("Concentric Radii")
                    .sectionHeader()
                    .enterAnimation(delay: 0.55)

                concentricDemo
                    .padding(.horizontal, Spacing.systemMargin)
                    .enterAnimation(delay: 0.6)

                Spacer(minLength: Spacing.xxl)
            }
        }
        .navigationTitle("Cards")
    }

    // MARK: - Tappable Card

    private var tappableCard: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            RoundedRectangle(cornerRadius: innerRadius, style: .continuous)
                .fill(Color.accentColor.opacity(0.12))
                .frame(height: 160)
                .overlay(
                    Image(systemName: "photo")
                        .font(.largeTitle)
                        .foregroundStyle(.secondary)
                )

            VStack(alignment: .leading, spacing: Spacing.xxs) {
                Text("Tappable Card")
                    .font(.headline)

                Text("This card has a press effect with shadow elevation change. Tap to see it in action.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, cardPadding)
            .padding(.bottom, cardPadding)
        }
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: outerRadius, style: .continuous))
        .shadow(
            color: tappedCard ? Shadows.large.color : Shadows.small.color,
            radius: tappedCard ? Shadows.large.radius : Shadows.small.radius,
            x: 0,
            y: tappedCard ? Shadows.large.y : Shadows.small.y
        )
        .animation(reduceMotion ? .default : Springs.snappy, value: tappedCard)
        .pressEffect {
            withAnimation(reduceMotion ? .default : Springs.snappy) {
                tappedCard.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                withAnimation(reduceMotion ? .default : Springs.snappy) {
                    tappedCard = false
                }
            }
        }
        .accessibilityAddTraits(.isButton)
    }

    // MARK: - Multi-Action Card

    private var multiActionCard: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            HStack(spacing: Spacing.sm) {
                Circle()
                    .fill(Color.orange.opacity(0.2))
                    .frame(width: 48, height: 48)
                    .overlay(
                        Image(systemName: "person.fill")
                            .foregroundStyle(.orange)
                    )

                VStack(alignment: .leading, spacing: 2) {
                    Text("Alex Johnson")
                        .font(.headline)
                    Text("Product Designer")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Button {
                    withAnimation(reduceMotion ? .default : Springs.snappy) {
                        favorited.toggle()
                    }
                } label: {
                    Image(systemName: favorited ? "heart.fill" : "heart")
                        .font(.title3)
                        .foregroundStyle(favorited ? .red : .secondary)
                        .contentTransition(.symbolEffect(.replace))
                }
                .frame(minWidth: 44, minHeight: 44)
            }
            .padding(.horizontal, cardPadding)
            .padding(.top, cardPadding)

            Text("Building design systems that bridge the gap between design and engineering. Passionate about motion and interaction design.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.horizontal, cardPadding)

            Divider()
                .padding(.horizontal, cardPadding)

            HStack(spacing: Spacing.sm) {
                CraftButton(title: "Message", level: .secondary, size: .small, icon: "bubble.left") {}

                CraftButton(title: "Follow", level: .primary, size: .small, icon: "plus") {}

                Spacer()
            }
            .padding(.horizontal, cardPadding)
            .padding(.bottom, cardPadding)
        }
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: outerRadius, style: .continuous))
        .shadowMedium()
    }

    // MARK: - Loaded Card

    private var loadedCard: some View {
        HStack(spacing: Spacing.sm) {
            RoundedRectangle(cornerRadius: innerRadius, style: .continuous)
                .fill(Color.purple.opacity(0.15))
                .frame(width: 80, height: 80)
                .overlay(
                    Image(systemName: "star.fill")
                        .font(.title2)
                        .foregroundStyle(.purple)
                )

            VStack(alignment: .leading, spacing: Spacing.xxs) {
                Text("Featured Item")
                    .font(.headline)
                Text("This is the loaded state of the card with real content.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                Text("$29.99")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(Color.accentColor)
            }

            Spacer(minLength: 0)
        }
        .padding(cardPadding)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: outerRadius, style: .continuous))
        .shadowSmall()
    }

    // MARK: - Skeleton Card

    private var skeletonCard: some View {
        HStack(spacing: Spacing.sm) {
            RoundedRectangle(cornerRadius: innerRadius, style: .continuous)
                .fill(Color(.systemGray5))
                .frame(width: 80, height: 80)
                .shimmer()

            VStack(alignment: .leading, spacing: Spacing.xxs) {
                RoundedRectangle(cornerRadius: CornerRadius.sm, style: .continuous)
                    .fill(Color(.systemGray5))
                    .frame(width: 120, height: 16)
                    .shimmer()

                RoundedRectangle(cornerRadius: CornerRadius.sm, style: .continuous)
                    .fill(Color(.systemGray5))
                    .frame(height: 14)
                    .shimmer()

                RoundedRectangle(cornerRadius: CornerRadius.sm, style: .continuous)
                    .fill(Color(.systemGray5))
                    .frame(width: 60, height: 14)
                    .shimmer()
            }

            Spacer(minLength: 0)
        }
        .padding(cardPadding)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: outerRadius, style: .continuous))
        .shadowSmall()
    }

    // MARK: - Concentric Radius Demo

    private var concentricDemo: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text("Outer radius = inner radius + padding")
                .font(.caption)
                .foregroundStyle(.secondary)

            HStack(spacing: Spacing.lg) {
                VStack(spacing: Spacing.xs) {
                    Text("Correct")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.green)

                    RoundedRectangle(cornerRadius: outerRadius, style: .continuous)
                        .strokeBorder(Color.green.opacity(0.4), lineWidth: 2)
                        .frame(width: 120, height: 80)
                        .overlay(
                            RoundedRectangle(cornerRadius: innerRadius, style: .continuous)
                                .fill(Color.green.opacity(0.15))
                                .padding(cardPadding)
                        )
                }

                VStack(spacing: Spacing.xs) {
                    Text("Incorrect")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.red)

                    RoundedRectangle(cornerRadius: innerRadius, style: .continuous)
                        .strokeBorder(Color.red.opacity(0.4), lineWidth: 2)
                        .frame(width: 120, height: 80)
                        .overlay(
                            RoundedRectangle(cornerRadius: innerRadius, style: .continuous)
                                .fill(Color.red.opacity(0.15))
                                .padding(cardPadding)
                        )
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding(cardPadding)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: outerRadius, style: .continuous))
        .shadowSmall()
    }
}

// MARK: - Shimmer Modifier

struct ShimmerModifier: ViewModifier {
    @State private var phase: CGFloat = 0
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View {
        if reduceMotion {
            content.opacity(0.6)
        } else {
            content
                .overlay(
                    LinearGradient(
                        colors: [
                            .clear,
                            .white.opacity(0.4),
                            .clear
                        ],
                        startPoint: .init(x: phase - 0.5, y: 0.5),
                        endPoint: .init(x: phase + 0.5, y: 0.5)
                    )
                    .blendMode(.screen)
                )
                .onAppear {
                    withAnimation(
                        .linear(duration: 1.5)
                        .repeatForever(autoreverses: false)
                    ) {
                        phase = 2
                    }
                }
        }
    }
}

extension View {
    func shimmer() -> some View {
        modifier(ShimmerModifier())
    }
}

#Preview {
    NavigationStack {
        CardGalleryView()
    }
}
