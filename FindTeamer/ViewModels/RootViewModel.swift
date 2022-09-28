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
    var handle: AuthStateDidChangeListenerHandle?
    // MARK: Publishers
    @Published var isAuthorized: Bool = false
    public init() {
        self.listen()
    }
    func listen() {
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
    func removeListener() {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
}
