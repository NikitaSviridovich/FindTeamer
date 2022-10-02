//
//  FirebaseAuthManager.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 28.09.22.
//

import FirebaseAuth
import Combine

final class FirebaseAuthService : AuthManager {
    // MARK: - Public properties
    @Published var isAuthorized: Bool = false
    var isAuthorizedPublisher: Published<Bool>.Publisher { $isAuthorized }
    
    // MARK: - Private properties
    private var handler: AuthStateDidChangeListenerHandle?
    
    // MARK: - Initializators
    init() { }
    
    // MARK: - Methods
    func createUser(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, _) in
            if authResult?.user != nil {
                completionBlock(true)
            } else {
                completionBlock(false)
            }
        }
    }
    func signIn(email: String, password: String, completionBlock : @escaping (_ authResult: AuthDataResult?, _ error: Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            completionBlock(authResult, error)
        }
    }
    func observeAuthenticationChanges() -> AnyPublisher<User?, Never> {
        Publishers.AuthenticationPublisher().eraseToAnyPublisher()
    }
}
