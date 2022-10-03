//
//  SingUpViewModel.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 25.09.22.
//

import SwiftUI
import Combine

final class SignUpViewModel: ObservableObject {
    // MARK: - Public properties
    @Published var validator: SignUpModelValidator
    @Published var isFormValid = false
    @Published var modelState: SignUpModel
    var isSignUpFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest4(
            self.validator.isNameValidPublisher,
            self.validator.isEmailValidPublisher,
            self.validator.isPasswordValidPublisher,
            self.validator.isPasswordMatchesValidPublisher)
        .map { isNameValid, isEmailValid, isPasswordValid, passwordMatches in
            return isNameValid && isEmailValid && isPasswordValid && passwordMatches
        }
        .eraseToAnyPublisher()
    }
    // MARK: - Private properties
    private let authManager: AuthManager
    private var publishers = Set<AnyCancellable>()
    private var cancellable: AnyCancellable!
    
    // MARK: - Initializators
    init(signUpModel: SignUpModel = SignUpModel(),
         authManager: AuthManager) {
        self.modelState = signUpModel
        self.validator = SignUpModelValidator(modelState: signUpModel)
        self.authManager = authManager
        isSignUpFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isFormValid, on: self)
            .store(in: &publishers)
    }

    // MARK: - Methods
    func createUser(completionBlock: @escaping (_ success: Bool) -> Void) {
        if self.isFormValid && self.validator.errorMessages.isEmpty {
            authManager.createUser(email: modelState.userEmail, password: modelState.userPassword, completionBlock: completionBlock)
        } else {
            for num in self.validator.errorMessages {
                //self.errors += " " + num.value
            }
        }
    }
}
