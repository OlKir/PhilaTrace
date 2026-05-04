import Foundation

actor InMemoryAlbumsRepository: AlbumsRepository {
    private var albums: [StampsAlbum]
    private var observers: [UUID: @Sendable ([StampsAlbum]) -> Void] = [:]

    init(albums: [StampsAlbum] = StampsAlbum.samples) {
        self.albums = albums
    }

    nonisolated func observeAlbums(
        onChange: @escaping @Sendable ([StampsAlbum]) -> Void,
        onError: @escaping @Sendable (Error) -> Void
    ) -> AlbumsRepositoryListener {
        let token = UUID()
        Task { [weak self] in
            guard let self else { return }
            await self.addObserver(token: token, onChange: onChange)
        }
        return InMemoryListener { [weak self] in
            Task { [weak self] in
                await self?.removeObserver(token: token)
            }
        }
    }

    func createAlbum(_ album: StampsAlbum) async throws {
        albums.insert(album, at: 0)
        notify()
    }

    func updateAlbum(_ album: StampsAlbum) async throws {
        guard let index = albums.firstIndex(where: { $0.id == album.id }) else { return }
        albums[index] = album
        notify()
    }

    func deleteAlbum(id: String) async throws {
        albums.removeAll { $0.id == id }
        notify()
    }

    private func addObserver(token: UUID, onChange: @escaping @Sendable ([StampsAlbum]) -> Void) {
        observers[token] = onChange
        onChange(albums)
    }

    private func removeObserver(token: UUID) {
        observers[token] = nil
    }

    private func notify() {
        let current = albums
        observers.values.forEach { $0(current) }
    }
}

private final class InMemoryListener: AlbumsRepositoryListener {
    private let onRemove: () -> Void
    private var isRemoved = false

    init(onRemove: @escaping () -> Void) {
        self.onRemove = onRemove
    }

    func remove() {
        guard !isRemoved else { return }
        isRemoved = true
        onRemove()
    }
}

