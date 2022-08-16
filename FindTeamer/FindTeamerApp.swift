//
//  FindTeamerApp.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 10.08.22.
//

import SwiftUI
import Firebase

@main
struct FindTeamerApp: App {
    let persistenceController = PersistenceController.shared
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
