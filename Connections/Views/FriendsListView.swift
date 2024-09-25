//
//  FriendsListView.swift
//  Connections
//
//  Created by Nowroz Islam on 25/9/24.
//

import SwiftData
import SwiftUI

struct FriendsListView: View {
    @Query private var cachedUsers: [CachedUser]
    
    var user: CachedUser
    
    var body: some View {
        ForEach(user.friends.sorted()) { friend in
            NavigationLink(value: getUser(friend.id)) {
                VStack(alignment: .leading) {
                    Text(friend.name)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 10))
            }
        }
    }
    
    func getUser(_ id: UUID) -> CachedUser {
        let user = cachedUsers.first { $0.id == id }
        
        guard let user else {
            fatalError("User not found")
        }
        
        return user
    }
}

#Preview(traits: .sampleData) {
    @Previewable @Query var cachedUsers: [CachedUser]
    
    FriendsListView(user: cachedUsers[0])
}
