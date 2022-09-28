//
//  SingUpViewModel.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 25.09.22.
//

import SwiftUI
import Combine

final class SignUpViewModel: ObservableObject {
    let firebaseManager: FirebaseManager = FirebaseManager()
    // MARK: Publishers
    @Published var validator: SignUpModelValidator
    @Published var isFormValid = false
    // MARK: ObservedObject
    @ObservedObject var modelState: SignUpModel
    // MARK: Private props
    private var publishers = Set<AnyCancellable>()
    init(signUpModel: SignUpModel = SignUpModel()) {
        self.modelState = signUpModel
        self.validator = SignUpModelValidator(modelState: signUpModel)
        isSignUpFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isFormValid, on: self)
            .store(in: &publishers)
    }
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
    // MARK: Methods
    func createUser(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        firebaseManager.createUser(email: email, password: password, completionBlock: completionBlock)
    }
}
