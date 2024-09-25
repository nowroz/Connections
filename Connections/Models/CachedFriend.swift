//
//  CachedFriend.swift
//  Connections
//
//  Created by Nowroz Islam on 24/9/24.
//

import Foundation
import SwiftData

@Model final class CachedFriend {
    @Attribute(.unique) var id: UUID
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}

extension CachedFriend: Comparable {
    static func <(lhs: CachedFriend, rhs: CachedFriend) -> Bool {
        lhs.name < rhs.name
    }
}
