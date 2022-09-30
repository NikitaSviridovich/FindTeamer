//
//  FirebaseAuthManager.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 28.09.22.
//

import FirebaseAuth

final class FirebaseAuthService : AuthManager {
    // MARK: - Properties
    @Published var isAuthorized: Bool = false
    var isAuthorizedPublisher: Published<Bool>.Publisher { $isAuthorized }
    private var handle: AuthStateDidChangeListenerHandle?
    
    // MARK: - Initializators
    init() {
        self.listener()
    }
    
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
    func listener() {
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
