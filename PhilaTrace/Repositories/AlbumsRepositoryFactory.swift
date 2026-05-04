import Foundation

#if canImport(FirebaseCore)
import FirebaseCore
#endif

enum AlbumsRepositoryFactory {
    static func makeDefault() -> any AlbumsRepository {
        #if canImport(FirebaseCore) && canImport(FirebaseFirestore)
        if FirebaseApp.app() != nil {
            return FirestoreAlbumsRepository()
        }
        #endif

        return InMemoryAlbumsRepository()
    }
}
