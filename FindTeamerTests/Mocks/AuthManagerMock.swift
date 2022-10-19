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
    var signOutFlag: Bool = false
    func createUser(email: String, password: String, completionBlock: @escaping (Bool) -> Void) {
        completionBlock(true)
    }

    func signIn(email: String, password: String, completionBlock: @escaping (Error?) -> Void) {
        let errorTemp = NSError(domain:"TEST", code: 200)
        completionBlock(errorTemp)
    }

    func signOut() {
        signOutFlag = true
    }

    func observeAuthenticationChanges() -> AnyPublisher<Bool, Never> {
        let subject = CurrentValueSubject<Bool, Never>(true)
        subject.send(true)
        return subject.eraseToAnyPublisher()
    }

    
}
