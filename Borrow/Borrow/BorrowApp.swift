//
//  BorrowApp.swift
//  Borrow
//
//  Created by Casey on 4/5/21.
//

import SwiftUI

@main
struct BorrowApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
