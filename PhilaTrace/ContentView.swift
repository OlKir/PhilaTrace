// ContentView.swift
// PhilaTrace
//
// Created by Oleksii Kirizii on 04.05.26.
//


import SwiftUI

struct ContentView: View {
    @StateObject private var albumsStore = AlbumsStore()
    @State private var isShowingError = false

    var body: some View {
        NavigationStack {
            AlbumsListView()
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.hidden, for: .navigationBar)
        }
        .environmentObject(albumsStore)
        .onChange(of: albumsStore.errorMessage) { newValue in
            isShowingError = newValue != nil
        }
        .alert("Firestore Error", isPresented: $isShowingError) {
            Button("OK") { albumsStore.errorMessage = nil }
        } message: {
            Text(albumsStore.errorMessage ?? "Unknown error")
        }
    }
}

#Preview {
    ContentView()
}
