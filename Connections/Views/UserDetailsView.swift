//
//  UserDetailView.swift
//  Connections
//
//  Created by Nowroz Islam on 24/9/24.
//

import SwiftData
import SwiftUI

struct UserDetailsView: View {
    @Environment(\.navigationState) private var navigationState
    
    let user: CachedUser
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    Text(user.name)
                        .font(.title.weight(.semibold))
                    Text("\(user.age) years old")
                    
                    LabeledContent {
                        Text(user.company)
                    } label: {
                        Label("Company", systemImage: "briefcase")
                    }
                    
                    LabeledContent {
                        Text(user.email)
                    } label: {
                        Label("Email", systemImage: "envelope")
                    }
                    
                    LabeledContent {
                        Text(user.isActive ? "Active" : "Inactive")
                            .foregroundStyle(user.isActive ? .green : .red)
                    } label: {
                        Label("Active Status", systemImage: "dot.circle.fill")
                    }
                    
                    LabeledContent {
                        Text(user.registered, format: .dateTime.day().month().year())
                    } label: {
                        Label("Date Registered", systemImage: "calendar.and.person")
                    }
                }
                
                customSection(header: "ADDRESS", text: user.address)
                
                customSection(header: "ABOUT ME", text: user.about)
                
                Section {
                    FriendsListView(user: user)
                } header: {
                    Text("FRIENDS")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.secondary)
                        .padding(.top)
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Home", systemImage: "house.fill", action: gotoHome)
        }
    }
    
    private func gotoHome() {
        navigationState.path = []
    }
    
    private func customSection(header: String, text: String) -> some View {
        Section {
            Text(text)
                .padding(.top, 10)
                .padding(.bottom, 30)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 10))
        } header: {
            Text(header)
                .foregroundStyle(.secondary)
                .padding(.top)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview(traits: .sampleData) {
    @Previewable @Query var cachedUsers: [CachedUser]
    
    NavigationStack {
        UserDetailsView(user: cachedUsers[0])
    }
}
