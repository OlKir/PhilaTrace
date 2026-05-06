import SwiftUI

struct DesignShowcaseView: View {
    var body: some View {
        TabView {
            AlbumsListView()
                .tabItem { Label("Albums", systemImage: "square.grid.2x2") }

            AlbumDetailsView(album: StampsAlbum.samples[0])
                .tabItem { Label("Details", systemImage: "rectangle.stack") }

            AddNewAlbumView()
                .tabItem { Label("New Album", systemImage: "plus.rectangle.on.folder") }

            NavigationStack {
                AddPageView()
            }
            .tabItem { Label("New Page", systemImage: "doc.badge.plus") }
        }
        .tint(LiquidTheme.primaryGlow)
    }
}

#Preview {
    DesignShowcaseView()
}
