//
//  ContentView.swift
//  FriendFace
//
//  Created by Karina Zhang on 1/4/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject var users = Users()

    var body: some View {
        NavigationView {
            List {
                ForEach(users.allUsers) { user in
                    NavigationLink(destination: DetailView(users: self.users, user: user)) {
                        VStack(alignment: HorizontalAlignment.leading) {
                            Text(user.name)
                                .font(.headline)
                            Text(user.email)
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationBarTitle("FriendFace")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let defaultUser = User(id: "123", isActive: false, name: "Jane Doe", age: 32, company: "Apple", email: "jane.doe@apple.com", address: "Cupertino", tags: [], friends: [])

    static var previews: some View {
        DetailView(users: Users(users: [defaultUser]), user: defaultUser)
    }
}
