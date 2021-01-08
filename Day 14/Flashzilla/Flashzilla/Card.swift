//
//  Card.swift
//  Flashzilla
//
//  Created by Karina Zhang on 1/7/21.
//

import SwiftUI

struct Card: Codable {
    let prompt: String
    let answer: String

    static var example: Card {
        Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
    }
}
