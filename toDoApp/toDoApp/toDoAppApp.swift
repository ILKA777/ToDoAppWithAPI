//
//  toDoAppApp.swift
//  toDoApp
//
//  Created by Илья on 21.12.2023.
//

import SwiftUI

@main
struct toDoAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
