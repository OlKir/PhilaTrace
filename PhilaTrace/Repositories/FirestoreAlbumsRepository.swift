import Foundation
import FirebaseFirestore

final class FirestoreAlbumsRepository: AlbumsRepository {
    private let db: Firestore

    init(db: Firestore = Firestore.firestore()) {
        self.db = db
    }

    private var albumsCollection: CollectionReference {
        db.collection("albums")
    }

    func observeAlbums(
        onChange: @escaping @Sendable ([StampsAlbum]) -> Void,
        onError: @escaping @Sendable (Error) -> Void
    ) -> AlbumsRepositoryListener {
        let registration = albumsCollection
            .order(by: "title")
            .addSnapshotListener { snapshot, error in
                if let error {
                    onError(error)
                    return
                }

                guard let snapshot else {
                    onChange([])
                    return
                }

                let albums: [StampsAlbum] = snapshot.documents.compactMap { document in
                    try? document.data(as: StampsAlbum.self)
                }
                onChange(albums)
            }

        return FirestoreListener(registration: registration)
    }

    func createAlbum(_ album: StampsAlbum) async throws {
        try albumsCollection.document(album.id).setData(from: album)
    }

    func updateAlbum(_ album: StampsAlbum) async throws {
        try albumsCollection.document(album.id).setData(from: album, merge: true)
    }

    func deleteAlbum(id: String) async throws {
        try await albumsCollection.document(id).delete()
    }
}

private final class FirestoreListener: AlbumsRepositoryListener {
    private let registration: ListenerRegistration

    init(registration: ListenerRegistration) {
        self.registration = registration
    }

    func remove() {
        registration.remove()
    }
}

