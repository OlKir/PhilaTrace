import SwiftUI

struct AddPageView: View {
    @State private var isPresentingExamplePaywall = false

    var body: some View {
        ZStack {
            LiquidBackgroundView()

            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    hero
                        .padding(.top, 12)

                    options

                    footerTip
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 140)
            }
        }
        .navigationTitle("Add to Collection")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .fullScreenCover(isPresented: $isPresentingExamplePaywall) {
            NavigationStack {
                ExamplePaywallView()
            }
        }
    }

    private var hero: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Catalog Your Finds")
                .font(.system(.largeTitle, design: .rounded).weight(.bold))
                .glossyText()
                .accessibilityAddTraits(.isHeader)

            Text("Choose how you want to add new items to your digital archive.")
                .font(.system(.body))
                .foregroundStyle(LiquidTheme.onSurfaceVariant.opacity(0.9))
        }
    }

    private var options: some View {
        VStack(spacing: 18) {
            PremiumAddOptionCard(
                title: "Take Bulk Photos",
                subtitle: "Instantly scan multiple pages and let AI identify your stamps.",
                onPillTap: { isPresentingExamplePaywall = true }
            )

            perforationDivider
                .opacity(0.18)
                .padding(.vertical, 2)

            StandardAddOptionCard(
                systemImage: "photo.on.rectangle.angled",
                title: "Upload from Gallery",
                subtitle: "Select high-resolution images from your device storage.",
                showsChevron: true,
                onTap: { }
            )

            ManualAddOptionCard(
                systemImage: "square.and.pencil",
                caption: "Manual Entry",
                subtitle: "Add details without a photo first.",
                onTap: { }
            )
        }
    }

    private var footerTip: some View {
        HStack(spacing: 10) {
            Image(systemName: "info.circle.fill")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(LiquidTheme.primaryGlow.opacity(0.7))
            Text("Tip: Natural lighting works best for AI detection.")
                .font(.system(.caption).weight(.medium))
                .foregroundStyle(LiquidTheme.onSurfaceVariant.opacity(0.9))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, alignment: .center)
        .background(.thinMaterial, in: Capsule())
        .overlay {
            Capsule().strokeBorder(.white.opacity(0.10), lineWidth: 1)
        }
        .accessibilityLabel("Tip: Natural lighting works best for AI detection.")
    }

    private var perforationDivider: some View {
        HStack(spacing: 10) {
            ForEach(0..<18, id: \.self) { _ in
                RoundedRectangle(cornerRadius: 2, style: .continuous)
                    .fill(.white.opacity(0.10))
                    .frame(width: 10, height: 4)
            }
        }
        .frame(maxWidth: .infinity)
        .accessibilityHidden(true)
    }
}

private struct PremiumAddOptionCard: View {
    let title: String
    let subtitle: String
    let onPillTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top, spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(LiquidTheme.primary.opacity(0.10))
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .strokeBorder(LiquidTheme.primaryGlow.opacity(0.20), lineWidth: 1)
                    Image(systemName: "camera.on.rectangle")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundStyle(LiquidTheme.primaryGlow.opacity(0.9))
                }
                .frame(width: 52, height: 52)

                VStack(alignment: .leading, spacing: 6) {
                    Text(title)
                        .font(.system(.title3, design: .rounded).weight(.semibold))
                        .foregroundStyle(LiquidTheme.primary)
                    Text(subtitle)
                        .font(.system(.body))
                        .foregroundStyle(LiquidTheme.onSurfaceVariant.opacity(0.9))
                        .fixedSize(horizontal: false, vertical: true)
                }

                Spacer(minLength: 0)
            }

            LiquidGlassPillButton(
                systemImage: "camera.fill",
                title: "LAUNCH SMART SCANNER",
                onTap: onPillTap
            )
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .liquidGlass(cornerRadius: 26)
        .overlay(alignment: .topTrailing) {
            Text("PREMIUM")
                .font(.system(.caption2).weight(.bold))
                .tracking(2.0)
                .foregroundStyle(LiquidTheme.onSurface)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(LiquidTheme.primaryGlow.opacity(0.95), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                .padding(.trailing, 18)
                .offset(y: -10)
        }
        .accessibilityElement(children: .combine)
    }
}

private struct LiquidGlassPillButton: View {
    let systemImage: String
    let title: String
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 10) {
                Image(systemName: systemImage)
                    .font(.system(size: 18, weight: .bold))
                Text(title)
                    .font(.system(.caption).weight(.bold))
                    .tracking(2.4)
                    .textCase(.uppercase)
            }
            .foregroundStyle(LiquidTheme.surface)
            .padding(.horizontal, 18)
            .padding(.vertical, 14)
        }
        .buttonStyle(.glass)
    }
}

private struct StandardAddOptionCard: View {
    let systemImage: String
    let title: String
    let subtitle: String
    let showsChevron: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(alignment: .top, spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(.white.opacity(0.05))
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .strokeBorder(.white.opacity(0.10), lineWidth: 1)
                    Image(systemName: systemImage)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundStyle(LiquidTheme.onSurfaceVariant.opacity(0.75))
                }
                .frame(width: 52, height: 52)

                VStack(alignment: .leading, spacing: 6) {
                    Text(title)
                        .font(.system(.title3, design: .rounded).weight(.semibold))
                        .foregroundStyle(.white)
                    Text(subtitle)
                        .font(.system(.body))
                        .foregroundStyle(LiquidTheme.onSurfaceVariant.opacity(0.9))
                        .fixedSize(horizontal: false, vertical: true)
                }

                Spacer(minLength: 0)

                if showsChevron {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(LiquidTheme.onSurfaceVariant.opacity(0.35))
                        .padding(.top, 6)
                }
            }
            .padding(18)
            .frame(maxWidth: .infinity, alignment: .leading)
            .liquidGlass(cornerRadius: 26)
        }
        .buttonStyle(.plain)
    }
}

private struct ManualAddOptionCard: View {
    let systemImage: String
    let caption: String
    let subtitle: String
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(alignment: .top, spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(.white.opacity(0.05))
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .strokeBorder(.white.opacity(0.06), lineWidth: 1)
                    Image(systemName: systemImage)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundStyle(LiquidTheme.onSurfaceVariant.opacity(0.55))
                }
                .frame(width: 52, height: 52)

                VStack(alignment: .leading, spacing: 6) {
                    Text(caption.uppercased())
                        .font(.system(.caption2).weight(.bold))
                        .tracking(2.4)
                        .foregroundStyle(LiquidTheme.onSurfaceVariant.opacity(0.8))
                    Text(subtitle)
                        .font(.system(.body))
                        .foregroundStyle(LiquidTheme.onSurfaceVariant.opacity(0.65))
                        .fixedSize(horizontal: false, vertical: true)
                }

                Spacer(minLength: 0)
            }
            .padding(18)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.white.opacity(0.04), in: RoundedRectangle(cornerRadius: 26, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 26, style: .continuous)
                    .strokeBorder(.white.opacity(0.10), style: StrokeStyle(lineWidth: 1.5, dash: [7, 7]))
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    AddPageView()
}
