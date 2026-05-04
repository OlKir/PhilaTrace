// PhilaTraceTests.swift
// PhilaTrace
//
// Created by Oleksii Kirizii on 04.05.26.
//


import Testing
@testable import PhilaTrace

struct PhilaTraceTests {

    @Test func albumsStore_addAlbum_persists() async throws {
        let repository = InMemoryAlbumsRepository(albums: [])
        let store = await MainActor.run { AlbumsStore(repository: repository) }

        let didAdd = await store.addAlbum(title: "Test Album", yearRange: "1900-1910", coverStyle: .aurora)
        #expect(didAdd)

        try await waitUntil(timeoutSeconds: 1.0) {
            await MainActor.run { store.albums.count == 1 }
        }

        let album = await MainActor.run { store.albums.first }
        #expect(album?.title == "Test Album")
        #expect(album?.yearRange == "1900-1910")
        #expect(album?.itemCount == 0)
    }

    @Test func albumsStore_updateAlbum_updatesFields() async throws {
        let seeded = StampsAlbum(id: "seed", title: "Old", yearRange: "1800", itemCount: 2, coverStyle: .sunset)
        let repository = InMemoryAlbumsRepository(albums: [seeded])
        let store = await MainActor.run { AlbumsStore(repository: repository) }

        try await waitUntil(timeoutSeconds: 1.0) {
            await MainActor.run { store.albums.count == 1 }
        }

        let didUpdate = await store.updateAlbum(id: "seed", title: "New", yearRange: "1850-1900", coverStyle: .emerald)
        #expect(didUpdate)

        try await waitUntil(timeoutSeconds: 1.0) {
            await MainActor.run { store.albums.first?.title == "New" }
        }

        let album = await MainActor.run { store.albums.first }
        #expect(album?.yearRange == "1850-1900")
        #expect(album?.coverStyle == .emerald)
    }

}

private func waitUntil(timeoutSeconds: Double, pollEveryNanoseconds: UInt64 = 25_000_000, _ condition: @escaping @Sendable () async -> Bool) async throws {
    let deadline = ContinuousClock.now + .seconds(timeoutSeconds)
    while ContinuousClock.now < deadline {
        if await condition() { return }
        try await Task.sleep(nanoseconds: pollEveryNanoseconds)
    }
    struct TimeoutError: Error {}
    throw TimeoutError()
}
