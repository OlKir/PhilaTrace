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

    func deleteAlbum(id: UUID) {
        albums.removeAll { $0.id == id }
    }

    @discardableResult
    func updateAlbum(id: UUID, title: String, yearRange: String, coverStyle: AlbumCoverStyle) -> Bool {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedYearRange = yearRange.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTitle.isEmpty else { return false }

        guard let index = albums.firstIndex(where: { $0.id == id }) else { return false }
        albums[index].title = trimmedTitle
        albums[index].yearRange = trimmedYearRange
        albums[index].coverStyle = coverStyle
        return true
    }

    func album(id: UUID) -> StampsAlbum? {
        albums.first { $0.id == id }
    }
}
