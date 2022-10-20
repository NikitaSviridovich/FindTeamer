//
//  SignUpModelValidator.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 28.09.22.
//

import SwiftUI
import Combine

final class SignUpModelValidator: ObservableObject {
    // MARK: - Internal properties

    @Published var modelState: SignUpModel
    var isNameValidPublisher: AnyPublisher<Bool, Never> {
        modelState.$userName
            .map { name in
                return name.count > self.minNameLength
            }
            .eraseToAnyPublisher()
    }
    var isEmailValidPublisher: AnyPublisher<Bool, Never> {
        modelState.$userEmail
            .map { email in
                return NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
                    .evaluate(with: email)
            }
            .eraseToAnyPublisher()
    }
    var isPasswordValidPublisher: AnyPublisher<Bool, Never> {
        modelState.$userPassword
            .map { password in
                return password.count >= self.minPasswordLength || password.count < self.maxPasswordLength
            }
            .eraseToAnyPublisher()
    }
    var isPasswordMatchesValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(modelState.$userPassword, modelState.$userRepeatPassword)
            .map { password, repeatPassword in
                return password == repeatPassword
            }.eraseToAnyPublisher()
    }

    // MARK: - Private properties

    private let minNameLength = 2
    private let minPasswordLength = 8
    private let maxPasswordLength = 24

    // MARK: - Initializators

    init(modelState: SignUpModel = SignUpModel()) {
        self.modelState = modelState
    }
}
