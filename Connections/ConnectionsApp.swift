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
    @State private var navigationState: NavigationState = .init()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.navigationState, navigationState)
        }
        .modelContainer(for: CachedUser.self)
    }
}
