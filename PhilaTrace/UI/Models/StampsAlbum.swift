import Foundation

struct StampsAlbum: Identifiable, Equatable {
    let id: UUID
    var title: String
    var yearRange: String
    var itemCount: Int
    var coverStyle: AlbumCoverStyle
}

enum AlbumCoverStyle: CaseIterable {
    case aurora
    case sunset
    case emerald
}

extension StampsAlbum {
    var itemCountText: String {
        "\(itemCount) Items"
    }
}

extension StampsAlbum {
    static let samples: [StampsAlbum] = [
        StampsAlbum(
            id: UUID(),
            title: "Classic Europe",
            yearRange: "1900–1945",
            itemCount: 128,
            coverStyle: .aurora
        )
    ]
}

