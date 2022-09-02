//
//  FirebaseManager.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 22.08.22.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class FirebaseManager {
    private var db = Firestore.firestore()
    func createUser(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let _ = authResult?.user {
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
    func addEvent(_ event: EventModel) {
        do {
            let _ = try db.collection("events").addDocument(from: event)
        }
        catch {
            print(error)
        }
    }
    func getEvents() {
        
    }
}
