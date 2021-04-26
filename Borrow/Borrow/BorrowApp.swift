//
//  BorrowApp.swift
//  Borrow
//
//  Created by Casey on 1/20/21.
//

import SwiftUI

@main
struct BorrowApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            LoginScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext).environmentObject(UserAuth())
        }
    }
}
