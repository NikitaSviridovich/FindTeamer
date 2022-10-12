//
//  AuthManager.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 30.09.22.
//

import Combine

protocol AuthManager {
    func createUser(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void)
    func signIn(email: String, password: String, completionBlock : @escaping (_ error: Error?) -> Void)
    func signOut()
    func observeAuthenticationChanges() -> AnyPublisher<Bool, Never>
}
