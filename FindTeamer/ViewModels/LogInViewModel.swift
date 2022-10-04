//
//  LogInViewModel.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 28.09.22.
//

import Foundation

final class LogInViewModel: ObservableObject {
    // MARK: - Public properties
    @Published var modelState: LogInModel
    
    // MARK: - Private properties
    private let authManager: AuthManager
    
    // MARK: - Initializators
    init(modelState: LogInModel = LogInModel(),
         authManager: AuthManager) {
        self.modelState = modelState
        self.authManager = authManager
    }
    
    // MARK: - Methods
    func signIn(completionBlock : @escaping (_ error: Error?) -> Void) {
        authManager.signIn(email: modelState.email, password: modelState.password, completionBlock: { error in
            completionBlock(error)
        })
    }
}
