import SwiftUI

struct AlbumsListView: View {
    private let albums = AlbumUIModel.samples

    var body: some View {
        ZStack {
            LiquidBackgroundView()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    header
                        .padding(.top, 8)

                    VStack(spacing: 16) {
                        ForEach(albums) { album in
                            AlbumCardView(album: album)
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 96)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button { } label: {
                    Image(systemName: "plus")
                        .font(.system(.headline, design: .rounded).weight(.bold))
                        .foregroundStyle(LiquidTheme.primaryGlow)
                        .padding(8)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Add album")
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Collection Library")
                .font(.system(.largeTitle, design: .rounded).weight(.bold))
                .glossyText()
                .accessibilityAddTraits(.isHeader)

            Text("Archived treasures and philatelic history curated by you.")
                .font(.system(.body))
                .foregroundStyle(LiquidTheme.onSurfaceVariant.opacity(0.9))
        }
    }
}

private struct AlbumCardView: View {
    let album: AlbumUIModel

    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .topTrailing) {
                cover
                    .frame(height: 220)
                    .overlay(alignment: .bottom) {
                        LinearGradient(colors: [.black.opacity(0.65), .clear], startPoint: .bottom, endPoint: .top)
                            .frame(height: 140)
                    }

                Text(album.itemCountText.uppercased())
                    .font(.system(.caption2).weight(.bold))
                    .tracking(2.5)
                    .foregroundStyle(LiquidTheme.primaryGlow)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(.thinMaterial, in: Capsule())
                    .overlay { Capsule().strokeBorder(.white.opacity(0.18), lineWidth: 1) }
                    .padding(16)
            }

            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(album.title)
                        .font(.system(.title3, design: .rounded).weight(.semibold))
                        .glossyText()

                    HStack(spacing: 8) {
                        Image(systemName: "calendar")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(LiquidTheme.onSurfaceVariant.opacity(0.9))
                        Text(album.yearRange)
                            .font(.system(.subheadline).weight(.medium))
                            .foregroundStyle(LiquidTheme.onSurfaceVariant.opacity(0.9))
                    }
                }

                Spacer()

                Button { } label: {
                    Image(systemName: "ellipsis")
                        .font(.system(.title3, design: .rounded).weight(.semibold))
                        .foregroundStyle(LiquidTheme.primaryGlow.opacity(0.65))
                        .padding(10)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("More options")
            }
            .padding(18)
        }
        .liquidGlass(cornerRadius: 22)
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
    }

    @ViewBuilder
    private var cover: some View {
        RoundedRectangle(cornerRadius: 22, style: .continuous)
            .fill(coverGradient)
            .overlay {
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .strokeBorder(.white.opacity(0.10), lineWidth: 1)
            }
            .overlay(alignment: .topLeading) {
                Circle()
                    .fill(.white.opacity(0.08))
                    .frame(width: 220, height: 220)
                    .blur(radius: 30)
                    .offset(x: -70, y: -120)
            }
            .padding(0)
            .clipShape(Rectangle())
    }

    private var coverGradient: LinearGradient {
        switch album.cover {
        case .aurora:
            LinearGradient(colors: [LiquidTheme.primaryGlow.opacity(0.55), Color.purple.opacity(0.35), LiquidTheme.surface], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .sunset:
            LinearGradient(colors: [LiquidTheme.secondaryGlow.opacity(0.45), Color.orange.opacity(0.30), LiquidTheme.surface], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .emerald:
            LinearGradient(colors: [LiquidTheme.tertiaryGlow.opacity(0.42), Color.teal.opacity(0.28), LiquidTheme.surface], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
}

#Preview {
    AlbumsListView()
}
