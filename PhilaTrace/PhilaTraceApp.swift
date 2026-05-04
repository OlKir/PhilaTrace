// PhilaTraceApp.swift
// PhilaTrace
//
// Created by Oleksii Kirizii on 04.05.26.
//


import SwiftUI
import FirebaseCore

@main
struct PhilaTraceApp: App {
    init() {
        FirebaseConfigurator.configureIfPossible()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

private enum FirebaseConfigurator {
    static func configureIfPossible() {
        guard FirebaseApp.app() == nil else { return }
        guard let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") else { return }
        guard let options = FirebaseOptions(contentsOfFile: path) else { return }
        FirebaseApp.configure(options: options)
    }
}
