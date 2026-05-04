import Foundation
import Combine

@MainActor
final class AlbumsStore: ObservableObject {
    @Published private(set) var albums: [StampsAlbum]

    init(albums: [StampsAlbum] = StampsAlbum.samples) {
        self.albums = albums
    }

    @discardableResult
    func addAlbum(title: String, yearRange: String, coverStyle: AlbumCoverStyle) -> Bool {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedYearRange = yearRange.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTitle.isEmpty else { return false }

        albums.insert(
            StampsAlbum(
                id: UUID(),
                title: trimmedTitle,
                yearRange: trimmedYearRange,
                itemCount: 0,
                coverStyle: coverStyle
            ),
            at: 0
        )
        return true
    }
}
