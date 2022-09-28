//
//  RootViewModel.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 12.09.22.
//

import SwiftUI
import Combine
import Firebase

class RootViewModel: ObservableObject {
    @Published var isAuthorized: Bool = false
    var handle: AuthStateDidChangeListenerHandle?
    public init() {
        self.linten()
    }
    func linten() {
        handle = Auth.auth().addStateDidChangeListener {(auth, user) in
            if user != nil {
                self.isAuthorized = true
            } else {
                self.isAuthorized = false
            }
        }
        removeListener()
    }
    func removeListener() {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
}

