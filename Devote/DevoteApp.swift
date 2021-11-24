//
//  DevoteApp.swift
//  Devote
//
//  Created by Yok on 24/11/2564 BE.
//

import SwiftUI

@main
struct DevoteApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
