//
//  SignUpModel.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 16.08.22.
//

import Foundation
import Combine

class SignUpModel : ObservableObject {
    @Published var userEmail = ""
    @Published var userPassword = ""
    @Published var userRepeatPassword = ""
    
    @Published var isFormValid = false
    
    var errorMessages: Dictionary<String, String> = [:]
    
    private var publishers = Set<AnyCancellable>()
    
    init() {
        isSignUpFormValidPublisher
          .receive(on: RunLoop.main)
          .assign(to: \.isFormValid, on: self)
          .store(in: &publishers)
      }
}
private extension SignUpModel {
    var isEmailValidPublisher: AnyPublisher<Bool, Never> {
        $userEmail
            .map { email in
                self.errorMessages.removeValue(forKey: ErrorNaming.emailError.rawValue)
                if !NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
                    .evaluate(with: email) {
                    self.errorMessages[ErrorNaming.emailError.rawValue] = ErrorConfigurator.emailError.localizedDescription
                }
                return NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
                    .evaluate(with: email)
            }
            .eraseToAnyPublisher()
    }
    
    var isPasswordValidPublisher: AnyPublisher<Bool, Never> {
        $userPassword
            .map { password in
                self.errorMessages.removeValue(forKey: ErrorNaming.shortPassword.rawValue)
                self.errorMessages.removeValue(forKey: ErrorNaming.longPassword.rawValue)
                if (password.count <= 8 || password.count > 24) {
                    self.errorMessages[password.count <= 8 ? ErrorNaming.shortPassword.rawValue : password.count > 24 ? ErrorNaming.longPassword.rawValue : ""] = password.count <= 8 ?
                    ErrorConfigurator.shortPassword.localizedDescription :
                    password.count > 24 ? ErrorConfigurator.longPassword.localizedDescription : ""
                }
                return password.count >= 8 || password.count < 24
            }
            .eraseToAnyPublisher()
    }
    
    var isPasswordMatchesValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($userPassword, $userRepeatPassword)
            .map { password, repeatPassword in
                self.errorMessages.removeValue(forKey: ErrorNaming.repeatedPassword.rawValue)
                if password != repeatPassword {
                    self.errorMessages[ErrorNaming.repeatedPassword.rawValue] = ErrorConfigurator.repeatedPassword.localizedDescription
                }
                return password == repeatPassword
        }.eraseToAnyPublisher()
    }
    
    var isSignUpFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3(
            isEmailValidPublisher,
            isPasswordValidPublisher,
            isPasswordMatchesValidPublisher)
          .map {isEmailValid, isPasswordValid, passwordMatches in
              return isEmailValid && isPasswordValid && passwordMatches
          }
          .eraseToAnyPublisher()
      }
}
