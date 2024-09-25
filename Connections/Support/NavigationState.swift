//
//  NavigationState.swift
//  Connections
//
//  Created by Nowroz Islam on 26/9/24.
//

import Foundation
import SwiftUI

@Observable final class NavigationState {
    var path: [CachedUser] = []
}

private struct NavigationStateKey: EnvironmentKey {
    static let defaultValue: NavigationState = .init()
}

extension EnvironmentValues {
    var navigationState: NavigationState {
        get { self[NavigationStateKey.self] }
        set { self[NavigationStateKey.self] = newValue }
    }
}
