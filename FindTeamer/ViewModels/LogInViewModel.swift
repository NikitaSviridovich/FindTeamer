//
//  LogInViewModel.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 28.09.22.
//

import SwiftUI
import FirebaseAuth

class LogInViewModel: ObservableObject {
    private let firebaseManager: FirebaseManager = FirebaseManager()
    // MARK: ObservedObject
    @ObservedObject var modelState: LogInModel
    // MARK: Initializator
    init(modelState: LogInModel = LogInModel()) {
        self.modelState = modelState
    }
    // MARK: Methods
    func signIn(email: String, password: String, completionBlock : @escaping (_ authResult: AuthDataResult?, _ error: Error?) -> Void) {
        firebaseManager.signIn(email: email, password: password, completionBlock: { authResult, error in
            completionBlock(authResult, error)
        })
    }
}
