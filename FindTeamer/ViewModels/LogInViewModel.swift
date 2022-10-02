//
//  LogInViewModel.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 28.09.22.
//

import SwiftUI
import FirebaseAuth

final class LogInViewModel: ObservableObject {
    // MARK: - Public properties
    @ObservedObject var modelState: LogInModel
    
    // MARK: - Private properties
    private let authManager: AuthManager
    
    // MARK: - Initializators
    init(modelState: LogInModel = LogInModel(),
         authManager: AuthManager) {
        self.modelState = modelState
        self.authManager = authManager
    }
    
    // MARK: - Methods
    func signIn(email: String, password: String, completionBlock : @escaping (_ authResult: AuthDataResult?, _ error: Error?) -> Void) {
        authManager.signIn(email: email, password: password, completionBlock: { authResult, error in
            completionBlock(authResult, error)
        })
    }
}
