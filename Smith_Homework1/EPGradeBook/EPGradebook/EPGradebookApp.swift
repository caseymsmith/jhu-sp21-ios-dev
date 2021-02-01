//
//  EPGradebookApp.swift
//  EPGradebook
//
//  Created by Teacher on 1/20/21.
//

import SwiftUI

@main
struct EPGradebookApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
