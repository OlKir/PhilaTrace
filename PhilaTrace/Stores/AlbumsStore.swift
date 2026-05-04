import Foundation
import Combine

@MainActor
final class AlbumsStore: ObservableObject {
    @Published private(set) var albums: [StampsAlbum] = []
    @Published var errorMessage: String?

    private let repository: AlbumsRepository
    private var listener: (any AlbumsRepositoryListener)?

    init(repository: AlbumsRepository = AlbumsRepositoryFactory.makeDefault()) {
        self.repository = repository
        startObserving()
    }

    deinit {
        listener?.remove()
    }

    func startObserving() {
        listener?.remove()
        listener = repository.observeAlbums { [weak self] albums in
            guard let self else { return }
            Task { @MainActor in
                self.albums = albums
                self.errorMessage = nil
            }
        } onError: { [weak self] error in
            guard let self else { return }
            Task { @MainActor in
                self.errorMessage = error.localizedDescription
            }
        }
    }

    @discardableResult
    func addAlbum(title: String, yearRange: String, coverStyle: AlbumCoverStyle) async -> Bool {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedYearRange = yearRange.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTitle.isEmpty else { return false }

        let album = StampsAlbum(
            id: UUID().uuidString,
            title: trimmedTitle,
            yearRange: trimmedYearRange,
            itemCount: 0,
            coverStyle: coverStyle,
            pages: []
        )

        do {
            try await repository.createAlbum(album)
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
        return true
    }

    func deleteAlbum(id: String) async {
        do {
            try await repository.deleteAlbum(id: id)
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    @discardableResult
    func updateAlbum(id: String, title: String, yearRange: String, coverStyle: AlbumCoverStyle) async -> Bool {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedYearRange = yearRange.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTitle.isEmpty else { return false }

        guard let index = albums.firstIndex(where: { $0.id == id }) else { return false }

        var updated = albums[index]
        updated.title = trimmedTitle
        updated.yearRange = trimmedYearRange
        updated.coverStyle = coverStyle

        do {
            try await repository.updateAlbum(updated)
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }

    func album(id: String) -> StampsAlbum? {
        albums.first { $0.id == id }
    }
}
