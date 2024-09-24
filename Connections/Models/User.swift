//
//  User.swift
//  Connections
//
//  Created by Nowroz Islam on 24/9/24.
//

import Foundation

struct User: Identifiable, Decodable {
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let friends: [Friend]
}
