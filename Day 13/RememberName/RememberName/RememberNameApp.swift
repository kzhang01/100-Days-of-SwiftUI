//
//  RememberNameApp.swift
//  RememberName
//
//  Created by Karina Zhang on 1/6/21.
//

import SwiftUI

@main
struct RememberNameApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
