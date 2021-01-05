//
//  User.swift
//  FriendFace
//
//  Created by Karina Zhang on 1/4/21.
//

import Foundation

struct User: Codable, Identifiable {
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var tags: [String]
    var friends: [Friend]
}
