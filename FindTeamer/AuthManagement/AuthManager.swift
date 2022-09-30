//
//  AuthManager.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 30.09.22.
//

import FirebaseAuth

protocol AuthManager {
    var isAuthorizedPublisher: Published<Bool>.Publisher { get }
    func createUser(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void)
    func signIn(email: String, password: String, completionBlock : @escaping (_ authResult: AuthDataResult?, _ error: Error?) -> Void)
    func listener()
    func removeListener()
}
