//
//  FindTeamerApp.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 10.08.22.
//

import SwiftUI

@main
struct FindTeamerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
