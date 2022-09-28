//
//  RootViewModel.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 12.09.22.
//

import SwiftUI
import Firebase

class RootViewModel: ObservableObject {
    private var handle: AuthStateDidChangeListenerHandle?
    // MARK: Publishers
    @Published var isAuthorized: Bool = false
    // MARK: Initializator
    public init() {
        self.listen()
    }
    // MARK: Methods
    private func listen() {
        handle = Auth.auth().addStateDidChangeListener { [weak self] (_, user) in
            guard let strongSelf = self else { return }
            if user != nil {
                strongSelf.isAuthorized = true
            } else {
                strongSelf.isAuthorized = false
            }
        }
        removeListener()
    }
    private func removeListener() {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
}
