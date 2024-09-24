//
//  ConnectionsApp.swift
//  Connections
//
//  Created by Nowroz Islam on 24/9/24.
//

import SwiftData
import SwiftUI

@main
struct ConnectionsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: CachedUser.self)
    }
}
