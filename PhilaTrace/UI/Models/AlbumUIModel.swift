import SwiftUI

struct AlbumUIModel: Identifiable {
    let id: UUID
    let title: String
    let yearRange: String
    let itemCountText: String
    let cover: AlbumCoverStyle
}

enum AlbumCoverStyle {
    case aurora
    case sunset
    case emerald
}

extension AlbumUIModel {
    static let samples: [AlbumUIModel] = [
        AlbumUIModel(
            id: UUID(),
            title: "European Classics",
            yearRange: "1840 — 1900",
            itemCountText: "124 Items",
            cover: .aurora
        ),
        AlbumUIModel(
            id: UUID(),
            title: "USA 19th Century",
            yearRange: "1847 — 1899",
            itemCountText: "89 Items",
            cover: .sunset
        ),
        AlbumUIModel(
            id: UUID(),
            title: "British Commonwealth",
            yearRange: "1850 — 1930",
            itemCountText: "215 Items",
            cover: .emerald
        ),
    ]
}

