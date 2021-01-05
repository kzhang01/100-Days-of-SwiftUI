//
//  Users.swift
//  FriendFace
//
//  Created by Karina Zhang on 1/4/21.
//

import Foundation

class Users: ObservableObject {
    @Published var allUsers = [User]()

    init(users: [User]) {
        self.allUsers = users
    }

    init() {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }

        let request = URLRequest(url: url)

        let session = URLSession.shared.dataTask(with: request) { data, response, sessionError in
            guard let data = data else {
                print("Fetch failed: \(sessionError?.localizedDescription ?? "Unknown error")")
                return
            }
            do {
                var decoded = try JSONDecoder().decode([User].self, from: data)
                
                decoded.sort { $0.name < $1.name }
                for (i, _) in decoded.enumerated() {
                    decoded[i].friends.sort { $0.name < $1.name }
                }
                DispatchQueue.main.async { [weak self] in
                    self?.allUsers = decoded
                }
            } catch let decodingError {
                print("Decoding failed: \(decodingError.localizedDescription)")
            }
        }

        DispatchQueue.global().async {
            session.resume()
        }
    }

    func find(withId: String) -> User? {
        return allUsers.first { $0.id == withId }
    }
}
