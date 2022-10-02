//
//  AuthManager.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 30.09.22.
//

import Combine
import FirebaseAuth

protocol AuthManager {
    var isAuthorizedPublisher: Published<Bool>.Publisher { get }
    func createUser(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void)
    func signIn(email: String, password: String, completionBlock : @escaping (_ authResult: AuthDataResult?, _ error: Error?) -> Void)
    func observeAuthenticationChanges() -> AnyPublisher<User?, Never>
}

extension Publishers {
    struct AuthenticationPublisher: Publisher {
        typealias Output = User?
        typealias Failure = Never
        func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
            let authSubscription = AuthenticationSubscription(subscriber: subscriber)
            subscriber.receive(subscription: authSubscription)
        }
    }
    class AuthenticationSubscription<S: Subscriber>: Subscription where S.Input == User?, S.Failure == Never {
        private var subscriber: S?
        private var handler: AuthStateDidChangeListenerHandle?
        init(subscriber: S) {
            self.subscriber = subscriber
            handler = Auth.auth().addStateDidChangeListener { _, user in
                _ = subscriber.receive(user)
            }
        }
        func request(_ demand: Subscribers.Demand) { }
        func cancel() {
            subscriber = nil
            handler = nil
        }
    }
}
