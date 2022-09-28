//
//  SignUpView.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 16.08.22.
//

import SwiftUI
import Combine

struct SignUpView: View {
    let alertModel: AlertModel = AlertModel()
    // MARK: State variables
    @State var errors: String = ""
    @State private var presentAlert = false
    @State private var activeAlert: ActiveAlert = .first
    // MARK: ObservedObject
    @ObservedObject var signUpViewModel: SignUpViewModel
    // MARK: Environment
    @Environment(\.presentationMode) var presentationMode
    // MARK: Initializator
    init(signUpViewModel: SignUpViewModel = SignUpViewModel()) {
        self.signUpViewModel = signUpViewModel
    }
    // MARK: Body
    var body: some View {
        WelcomeIcon()
        TextField("Name", text: $signUpViewModel.modelState.userName)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.horizontal, 20)
        TextField("Email", text: $signUpViewModel.modelState.userEmail)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.horizontal, 20)
        SecureField("Password", text: $signUpViewModel.modelState.userPassword)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.horizontal, 20)
        SecureField("Repeat Password", text: $signUpViewModel.modelState.userRepeatPassword)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.horizontal, 20)
        Text(errors)
            .opacity(0.5)
            .foregroundColor(.red)
            .padding()
        Button(action: registerClicked) {
            ButtonContent(text: "Let's Go!")
        }.opacity(buttonOpacity)
            .alert(isPresented: $presentAlert) {
                switch activeAlert {
                case .first:
                    return Alert(
                        title: Text(alertModel.title),
                        message: Text(alertModel.message),
                        dismissButton: .default(Text(alertModel.buttonNaming)) {
                            presentationMode.wrappedValue.dismiss()
                        })
                case .second:
                    return Alert(
                        title: Text(alertModel.title),
                        message: Text(alertModel.message),
                        dismissButton: .default(Text(alertModel.buttonNaming)))
                }
            }
    }
    var buttonOpacity: Double {
        return signUpViewModel.isFormValid &&
        signUpViewModel.validator.errorMessages.isEmpty ? 1 : 0.5
    }
    func registerClicked() {
        self.errors = ""
        if self.signUpViewModel.isFormValid && self.signUpViewModel.validator.errorMessages.isEmpty {
            signUpViewModel.createUser(email: self.signUpViewModel.modelState.userEmail, password: self.signUpViewModel.modelState.userPassword, completionBlock: { (success) in
                presentAlert = true
                if (success) {
                    activeAlert = .first
                    alertModel.title = "Success"
                    alertModel.message = "Registration complete!"
                } else {
                    activeAlert = .second
                    alertModel.title = "Error"
                    alertModel.message = "Registration failed. Please try again!"
                    alertModel.buttonNaming = "OK"
                }
            })
        } else {
            for num in self.signUpViewModel.validator.errorMessages {
                self.errors += " " + num.value
            }
        }
    }
}
