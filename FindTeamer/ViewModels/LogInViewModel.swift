//
//  LogInViewModel.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 28.09.22.
//

import SwiftUI
import FirebaseAuth

class LogInViewModel: ObservableObject {
    private let firebaseAuthManager: FirebaseAuthManager
    // MARK: ObservedObject
    @ObservedObject var modelState: LogInModel
    // MARK: Initializator
    init(modelState: LogInModel = LogInModel(),
         firebaseAuthManager: FirebaseAuthManager = FirebaseAuthManager()) {
        self.modelState = modelState
        self.firebaseAuthManager = firebaseAuthManager
    }
    // MARK: Methods
    func signIn(email: String, password: String, completionBlock : @escaping (_ authResult: AuthDataResult?, _ error: Error?) -> Void) {
        firebaseAuthManager.signIn(email: email, password: password, completionBlock: { authResult, error in
            completionBlock(authResult, error)
        })
    }
}
