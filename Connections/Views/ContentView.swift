//
//  ContentView.swift
//  Connections
//
//  Created by Nowroz Islam on 24/9/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: [
        SortDescriptor(\CachedUser.name),
        SortDescriptor(\CachedUser.company)
    ]) private var cachedUsers: [CachedUser]
    
    var body: some View {
        NavigationStack {
            List(cachedUsers) { cachedUser in
                NavigationLink(value: cachedUser) {
                    HStack {
                        Image(systemName: "person.crop.circle.badge.fill")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(cachedUser.isActive ? .green : .red, .secondary)
                        
                        VStack(alignment: .leading) {
                            Text(cachedUser.name)
                                .font(.headline)
                            
                            Text(cachedUser.company)
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("Users")
            .navigationDestination(for: CachedUser.self) { cachedUser in
                UserDetailsView(user: cachedUser)
            }
            .task {
                await loadData()
            }
        }
    }
    
    private func loadData() async {
        guard cachedUsers.isEmpty else { return }
        
        let users: [User] = await DataLoader().loadData(from: "https://www.hackingwithswift.com/samples/friendface.json")
        
        users.forEach { user in
            print("new user created")
            let newCachedUser = CachedUser(id: user.id, isActive: user.isActive, name: user.name, age: user.age, company: user.company, email: user.email, address: user.address, about: user.about, registered: user.registered, friends: [])
            
            user.friends.forEach { friend in
                let newCachedFriend = CachedFriend(id: friend.id, name: friend.name)
                newCachedUser.friends.append(newCachedFriend)
            }
            
            modelContext.insert(newCachedUser)
        }
    }
}

#Preview(traits: .previewContainer) {
    ContentView()
}
