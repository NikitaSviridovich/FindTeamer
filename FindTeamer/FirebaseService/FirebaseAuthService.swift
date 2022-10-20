//
//  FirebaseAuthManager.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 28.09.22.
//

import FirebaseAuth
import Combine

final class FirebaseAuthService: AuthManager {
    // MARK: - Internal properties

    @Published var isAuthorized: Bool = false

    // MARK: - Private properties

    private var handler: AuthStateDidChangeListenerHandle?

    // MARK: - Initializators

    init() { }

    // MARK: - Internal Methods

    func createUser(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, _) in
            if authResult?.user != nil {
                completionBlock(true)
            } else {
                completionBlock(false)
            }
        }
    }

    func signIn(email: String, password: String, completionBlock: @escaping (_ error: Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            completionBlock(error)
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }

    func observeAuthenticationChanges() -> AnyPublisher<Bool, Never> {
        Publishers.AuthenticationPublisher().eraseToAnyPublisher()
    }
}

extension Publishers {
    struct AuthenticationPublisher: Publisher {
        typealias Output = Bool
        typealias Failure = Never

        // MARK: - Methods

        func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
            let authSubscription = AuthenticationSubscription(subscriber: subscriber)
            subscriber.receive(subscription: authSubscription)
        }
    }
    class AuthenticationSubscription<S: Subscriber>: Subscription where S.Input == Bool, S.Failure == Never {
        // MARK: - Private properties

        private var subscriber: S?
        private var handler: AuthStateDidChangeListenerHandle?

        // MARK: - Initializators

        init(subscriber: S) {
            self.subscriber = subscriber
            handler = Auth.auth().addStateDidChangeListener { _, isLogged in
                _ = subscriber.receive(isLogged != nil)
            }
        }

        // MARK: - Methods

        func request(_ demand: Subscribers.Demand) { }
        func cancel() {
            subscriber = nil
            handler = nil
        }
    }
}
