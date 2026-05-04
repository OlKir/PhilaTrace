// ContentView.swift
// PhilaTrace
//
// Created by Oleksii Kirizii on 04.05.26.
//


import SwiftUI

struct ContentView: View {
    @StateObject private var albumsStore = AlbumsStore()

    var body: some View {
        NavigationStack {
            AlbumsListView()
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.hidden, for: .navigationBar)
        }
        .environmentObject(albumsStore)
    }
}

#Preview {
    ContentView()
}
