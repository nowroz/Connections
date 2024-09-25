//
//  SampleData.swift
//  Connections
//
//  Created by Nowroz Islam on 24/9/24.
//

import Foundation
import SwiftData
import SwiftUI

struct SampleData: PreviewModifier {
    typealias Context = ModelContainer
    
    static func makeSharedContext() async throws -> Context {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let modelContainer = try ModelContainer(for: CachedUser.self, configurations: config)
        
        if try modelContainer.mainContext.fetch(FetchDescriptor<CachedUser>()).isEmpty {
            let users: [User] = await DataLoader().loadData(from: "https://www.hackingwithswift.com/samples/friendface.json")
            
            users.forEach { user in
                print("new user created")
                let newCachedUser = CachedUser(id: user.id, isActive: user.isActive, name: user.name, age: user.age, company: user.company, email: user.email, address: user.address, about: user.about, registered: user.registered, friends: [])
                
                user.friends.forEach { friend in
                    let newCachedFriend = CachedFriend(id: friend.id, name: friend.name)
                    newCachedUser.friends.append(newCachedFriend)
                }
                
                modelContainer.mainContext.insert(newCachedUser)
            }
        }
        
        return modelContainer
    }
    
    func body(content: Content, context: Context) -> some View {
        content
            .modelContainer(context)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    static var sampleData: Self = .modifier(SampleData())
}
