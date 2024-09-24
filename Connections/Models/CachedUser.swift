//
//  CachedUser.swift
//  Connections
//
//  Created by Nowroz Islam on 24/9/24.
//

import Foundation
import SwiftData

@Model final class CachedUser {
    @Attribute(.unique) var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var friends: [CachedFriend]
    
    init(id: UUID, isActive: Bool, name: String, age: Int, company: String, email: String, address: String, about: String, registered: Date, friends: [CachedFriend]) {
        self.id = id
        self.isActive = isActive
        self.name = name
        self.age = age
        self.company = company
        self.email = email
        self.address = address
        self.about = about
        self.registered = registered
        self.friends = friends
    }
}
