//
//  FindTeamerApp.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 10.08.22.
//

import SwiftUI
import Firebase
import CoreData

@main
struct FindTeamerApp: App {
    let persistenceController = PersistenceController.shared
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environment(\.colorScheme, .dark)
        }
    }
}
