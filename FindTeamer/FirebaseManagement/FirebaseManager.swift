//
//  FirebaseManager.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 22.08.22.
//

import Foundation
import FirebaseAuth
import UIKit

class FirebaseManager {
    func createUser(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let user = authResult?.user {
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
}
