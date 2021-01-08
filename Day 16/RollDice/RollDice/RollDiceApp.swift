//
//  RollDiceApp.swift
//  RollDice
//
//  Created by Karina Zhang on 1/8/21.
//

import SwiftUI

@main
struct RollDiceApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
