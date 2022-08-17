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
                print("TEST ::::::::::: TEST")
                return NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
                    .evaluate(with: email)
            }
            .eraseToAnyPublisher()
    }
    
    var isPasswordValidPublisher: AnyPublisher<Bool, Never> {
        $userEmail
            .map { password in
                print("TEST ::::::::::: TEST")
                return password.count >= 8
            }
            .eraseToAnyPublisher()
    }
    
    var isSignUpFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(
            isEmailValidPublisher,
            isPasswordValidPublisher)
          .map {isEmailValid, isPasswordValid in
              return isEmailValid && isPasswordValid
          }
          .eraseToAnyPublisher()
      }
}
