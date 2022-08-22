//
//  FirebaseManager.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 22.08.22.
//

import Foundation
import FirebaseAuth

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
}
