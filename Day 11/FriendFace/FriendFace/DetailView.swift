//
//  DetailView.swift
//  FriendFace
//
//  Created by Karina Zhang on 1/4/21.
//

import SwiftUI

struct FriendView: View {
    @ObservedObject var users: Users
    var friend: Friend

    var body: some View {
        if let foundFriend = self.users.find(withId: friend.id) {
            return AnyView(LinkedFriendView(users: users, friend: foundFriend))
        }
        else {
            return AnyView(Text(friend.name))
        }
    }
}

struct LinkedFriendView: View {
    @ObservedObject var users: Users
    var friend: User

    var body: some View {
        NavigationLink(destination: DetailView(users: users, user: friend)) {
            VStack(alignment: HorizontalAlignment.leading) {
                Text(friend.name)
                    .font(.headline)
                Text(friend.email)
                    .font(.subheadline)
            }
        }
    }
}

struct DetailView: View {
    @ObservedObject var users: Users
    var user: User

    var body: some View {
        List {
            Section(header: Text("Name")) {
                HStack {
                    Text(user.name)
                    Circle()
                        .frame(width: 10, height: 10, alignment: .center)
                        .foregroundColor(user.isActive ? .green : .gray)
                }
                
            }
            Section(header: Text("Age")) {
                Text(String(user.age))
            }
            Section(header: Text("Works at")) {
                Text(user.company)
            }
            Section(header: Text("Interests")) {
                UserTagsView(tags: user.tags)
            }
            Section(header: Text("Friends")) {
                ForEach(user.friends) { friend in
                    FriendView(users: self.users, friend: friend)
                }
            }
        }
        .navigationBarTitle("\(user.name)", displayMode: .inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static let defaultUser = User(id: "123", isActive: false, name: "Jane Doe", age: 32, company: "Apple", email: "jane.doe@apple.com", address: "Cupertino", tags: [], friends: [])

    static var previews: some View {
        DetailView(users: Users(users: [defaultUser]), user: defaultUser)
    }
}
