import Foundation

struct StampsAlbum: Identifiable, Equatable {
    let id: UUID
    var title: String
    var yearRange: String
    var itemCount: Int
    var coverStyle: AlbumCoverStyle
    var pages: [AlbumPage]
}

struct AlbumPage: Identifiable, Equatable {
    let id: UUID
    var title: String
    var coverStyle: AlbumCoverStyle
    var imageName: String?
    var stamps: [Stamp]
}

struct Stamp: Identifiable, Equatable {
    let id: UUID
    var title: String
    var country: String
    var year: Int
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

extension AlbumPage {
    var stampCount: Int { stamps.count }

    var mountedCountText: String {
        "\(stampCount) Stamps Mounted"
    }
}

extension StampsAlbum {
    static let samples: [StampsAlbum] = [
        StampsAlbum(
            id: UUID(),
            title: "Classic Europe",
            yearRange: "1900–1945",
            itemCount: 128,
            coverStyle: .aurora,
            pages: [
                AlbumPage(
                    id: UUID(),
                    title: "Great Britain (1840–41)",
                    coverStyle: .aurora,
                    imageName: "Sample-page-1",
                    stamps: [
                        Stamp(id: UUID(), title: "Penny Black", country: "Great Britain", year: 1840, coverStyle: .aurora),
                        Stamp(id: UUID(), title: "Two Pence Blue", country: "Great Britain", year: 1840, coverStyle: .sunset),
                        Stamp(id: UUID(), title: "Penny Red", country: "Great Britain", year: 1841, coverStyle: .emerald),
                    ]
                ),
                AlbumPage(
                    id: UUID(),
                    title: "Canada & Provinces",
                    coverStyle: .sunset,
                    imageName: "Sample-page-2",
                    stamps: [
                        Stamp(id: UUID(), title: "Three Penny Beaver", country: "Canada", year: 1851, coverStyle: .sunset),
                        Stamp(id: UUID(), title: "Six Pence Consort", country: "Canada", year: 1851, coverStyle: .aurora),
                    ]
                ),
                AlbumPage(
                    id: UUID(),
                    title: "Australian States",
                    coverStyle: .emerald,
                    imageName: "Sample-page-3",
                    stamps: [
                        Stamp(id: UUID(), title: "Sydney View", country: "New South Wales", year: 1850, coverStyle: .emerald),
                        Stamp(id: UUID(), title: "Black Swan", country: "Western Australia", year: 1854, coverStyle: .aurora),
                        Stamp(id: UUID(), title: "Half Length", country: "Victoria", year: 1850, coverStyle: .sunset),
                        Stamp(id: UUID(), title: "Chalon Head", country: "Tasmania", year: 1855, coverStyle: .emerald),
                    ]
                ),
            ]
        )
    ]
}

