//
//  SignUpModelValidator.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 28.09.22.
//

import SwiftUI
import Combine

class SignUpModelValidator: ObservableObject {
    var errorMessages: [String : String] = [:]
    // MARK: ObservedObject
    @ObservedObject var modelState: SignUpModel
    // MARK: Min and max fields length
    let minNameLength = 2
    let minPasswordLength = 8
    let maxPasswordLength = 24
    // MARK: Initializator
    init(modelState: SignUpModel = SignUpModel()) {
        self.modelState = modelState
    }
    // MARK: Name field validation
    var isNameValidPublisher: AnyPublisher<Bool, Never> {
        modelState.$userName
            .map { name in
                self.errorMessages.removeValue(forKey: ErrorTitle.nameError.rawValue)
                if name.count < self.minNameLength {
                    self.errorMessages[ErrorTitle.nameError.rawValue] = ErrorCases.nameError.localizedDescription
                }
                return name.count > self.minNameLength
            }
            .eraseToAnyPublisher()
    }
    // MARK: Email field validation
    var isEmailValidPublisher: AnyPublisher<Bool, Never> {
        modelState.$userEmail
            .map { email in
                self.errorMessages.removeValue(forKey: ErrorTitle.emailError.rawValue)
                if !NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
                    .evaluate(with: email) {
                    self.errorMessages[ErrorTitle.emailError.rawValue] = ErrorCases.emailError.localizedDescription
                }
                return NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
                    .evaluate(with: email)
            }
            .eraseToAnyPublisher()
    }
    // MARK: Password field validation
    var isPasswordValidPublisher: AnyPublisher<Bool, Never> {
        modelState.$userPassword
            .map { password in
                self.errorMessages.removeValue(forKey: ErrorTitle.shortPassword.rawValue)
                self.errorMessages.removeValue(forKey: ErrorTitle.longPassword.rawValue)
                if (password.count <= self.minPasswordLength || password.count > self.maxPasswordLength) {
                    self.errorMessages[password.count <= self.minPasswordLength ? ErrorTitle.shortPassword.rawValue : password.count > self.maxPasswordLength ? ErrorTitle.longPassword.rawValue : ""] = password.count <= self.minPasswordLength ?
                    ErrorCases.shortPassword.localizedDescription :
                    password.count > self.maxPasswordLength ? ErrorCases.longPassword.localizedDescription : ""
                }
                return password.count >= self.minPasswordLength || password.count < self.maxPasswordLength
            }
            .eraseToAnyPublisher()
    }
    // MARK: Password match validation
    var isPasswordMatchesValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(modelState.$userPassword, modelState.$userRepeatPassword)
            .map { password, repeatPassword in
                self.errorMessages.removeValue(forKey: ErrorTitle.repeatedPassword.rawValue)
                if password != repeatPassword {
                    self.errorMessages[ErrorTitle.repeatedPassword.rawValue] = ErrorCases.repeatedPassword.localizedDescription
                }
                return password == repeatPassword
            }.eraseToAnyPublisher()
    }
}
