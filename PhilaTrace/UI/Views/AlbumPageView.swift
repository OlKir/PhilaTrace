import SwiftUI

struct AlbumPageView: View {
    let page: AlbumPage

    var body: some View {
        ZStack {
            LiquidBackgroundView()

            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    header
                        .padding(.top, 12)

                    stampsSection
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
        .navigationTitle(/*page.title*/"Stamps")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(page.title)
                .font(.system(.largeTitle, design: .rounded).weight(.bold))
                .glossyText()

            Text(page.mountedCountText.uppercased())
                .font(.system(.caption).weight(.semibold))
                .tracking(2.0)
                .foregroundStyle(LiquidTheme.onSurfaceVariant.opacity(0.9))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var stampsSection: some View {
        LazyVGrid(columns: [GridItem(.flexible(), spacing: 14), GridItem(.flexible(), spacing: 14)], spacing: 14) {
            ForEach(page.stamps) { stamp in
                NavigationLink {
                    StampDetailView(stamp: stamp)
                } label: {
                    StampCardView(stamp: stamp)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

private struct StampCardView: View {
    let stamp: Stamp

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Color.clear
                .aspectRatio(3 / 4, contentMode: .fit)
                .overlay {
                    if let imageName = stamp.imageName {
                        Image(imageName)
                            .resizable()
                            .scaledToFill()
                    } else {
                        Rectangle().fill(gradient)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                .overlay {
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .strokeBorder(.white.opacity(0.10), lineWidth: 1)
                }
                .overlay(alignment: .bottom) {
                    LinearGradient(colors: [.black.opacity(0.60), .clear], startPoint: .bottom, endPoint: .top)
                        .opacity(0.2)
                }

            Text(stamp.title)
                .font(.system(.subheadline).weight(.semibold))
                .foregroundStyle(LiquidTheme.primary.opacity(0.9))
                .lineLimit(1)

            Text("\(stamp.country.uppercased()) · \(String(stamp.year))")
                .font(.system(.caption2).weight(.bold))
                .tracking(2.0)
                .foregroundStyle(LiquidTheme.onSurfaceVariant.opacity(0.85))
                .lineLimit(1)
        }
        .padding(14)
        .liquidGlass(cornerRadius: 26)
    }

    private var gradient: LinearGradient {
        switch stamp.coverStyle {
        case .aurora:
            LinearGradient(colors: [LiquidTheme.primaryGlow.opacity(0.45), Color.purple.opacity(0.30), LiquidTheme.surface], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .sunset:
            LinearGradient(colors: [LiquidTheme.secondaryGlow.opacity(0.40), Color.orange.opacity(0.28), LiquidTheme.surface], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .emerald:
            LinearGradient(colors: [LiquidTheme.tertiaryGlow.opacity(0.40), Color.teal.opacity(0.28), LiquidTheme.surface], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
}

#Preview {
    NavigationStack {
        AlbumPageView(page: StampsAlbum.samples[0].pages[0])
    }
}
