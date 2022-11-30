//
//  Todo_AppApp.swift
//  Todo App
//
//  Created by Pusiewicz, M. (Mateusz) on 28/11/2022.
//

import SwiftUI

@main
struct Todo_AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
