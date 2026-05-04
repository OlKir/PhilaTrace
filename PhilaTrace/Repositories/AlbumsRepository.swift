import Foundation

protocol AlbumsRepository: Sendable {
    func observeAlbums(onChange: @escaping @Sendable ([StampsAlbum]) -> Void, onError: @escaping @Sendable (Error) -> Void) -> AlbumsRepositoryListener
    func createAlbum(_ album: StampsAlbum) async throws
    func updateAlbum(_ album: StampsAlbum) async throws
    func deleteAlbum(id: String) async throws
}

protocol AlbumsRepositoryListener: AnyObject, Sendable {
    func remove()
}

