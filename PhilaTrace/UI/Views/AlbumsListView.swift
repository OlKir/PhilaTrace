import SwiftUI

struct AlbumsListView: View {
    @EnvironmentObject private var albumsStore: AlbumsStore
    @State private var activeSheet: AlbumsSheet?

    private enum AlbumsSheet: Identifiable, Equatable {
        case add
        case edit(String)

        var id: String {
            switch self {
            case .add:
                return "add"
            case .edit(let id):
                return "edit-\(id)"
            }
        }
    }

    var body: some View {
        ZStack {
            LiquidBackgroundView()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    header
                        .padding(.top, 8)

                    VStack(spacing: 16) {
                        ForEach(albumsStore.albums) { album in
                            NavigationLink {
                                AlbumDetailsView(album: album)
                                    .navigationBarTitleDisplayMode(.inline)
                            } label: {
                                AlbumCardView(
                                    album: album,
                                    onEdit: { activeSheet = .edit(album.id) },
                                    onDelete: {
                                        Task { await albumsStore.deleteAlbum(id: album.id) }
                                    }
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 96)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button { activeSheet = .add } label: {
                    Image(systemName: "plus")
                        .font(.system(.headline, design: .rounded).weight(.bold))
                        .foregroundStyle(LiquidTheme.primaryGlow)
                        .padding(8)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Add album")
            }
        }
        .sheet(item: $activeSheet) { sheet in
            NavigationStack {
                sheetView(sheet)
                    .toolbarBackground(.hidden, for: .navigationBar)
            }
            .environmentObject(albumsStore)
        }
    }

    @ViewBuilder
    private func sheetView(_ sheet: AlbumsSheet) -> some View {
        switch sheet {
        case .add:
            AddNewAlbumView(mode: .add)
                .navigationBarTitleDisplayMode(.inline)
        case .edit(let id):
            if let album = albumsStore.album(id: id) {
                AddNewAlbumView(mode: .edit(album))
                    .navigationBarTitleDisplayMode(.inline)
            } else {
                Text("Album not found")
                    .liquidForeground()
                    .navigationBarTitleDisplayMode(.inline)
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
    let album: StampsAlbum
    let onEdit: () -> Void
    let onDelete: () -> Void

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
                    .foregroundStyle(LiquidTheme.primary)
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

                Menu {
                    Button("Edit") { onEdit() }
                    Button("Delete", role: .destructive) { onDelete() }
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.system(.title3, design: .rounded).weight(.semibold))
                        .foregroundStyle(LiquidTheme.primaryGlow.opacity(0.65))
                        .padding(10)
                }
                .accessibilityLabel("More options")
            }
            .padding(18)
        }
        .liquidGlass(cornerRadius: 22)
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
    }

    @ViewBuilder
    private var cover: some View {
        Color.clear
            .overlay {
                if let imageName = album.pages.first?.imageName {
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                } else {
                    Rectangle().fill(coverGradient)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
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
    }

    private var coverGradient: LinearGradient {
        switch album.coverStyle {
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
