//
//  AuthManagerMock.swift
//  FindTeamerTests
//
//  Created by Nikita Sviridovich on 18.10.22.
//

import Foundation
import Combine
@testable import FindTeamer

class AuthManagerMock: AuthManager {
    func createUser(email: String, password: String, completionBlock: @escaping (Bool) -> Void) {
        <#code#>
    }

    func signIn(email: String, password: String, completionBlock: @escaping (Error?) -> Void) {
        <#code#>
    }

    func signOut() {
        <#code#>
    }

    func observeAuthenticationChanges() -> AnyPublisher<Bool, Never> {
        <#code#>
    }

    
}
