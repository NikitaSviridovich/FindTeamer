//
//  SignUpView.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 16.08.22.
//

import SwiftUI
import Combine

struct SignUpView: View {
    // MARK: - Private properties

    private let alertModel: AlertModel = AlertModel()
    @State private var presentAlert = false
    @State private var activeAlert: ActiveAlert = .first
    @ObservedObject private var signUpViewModel: SignUpViewModel
    @Environment(\.presentationMode) private var presentationMode

    // MARK: - Initializators

    init(signUpViewModel: SignUpViewModel = SignUpViewModel(authManager: FirebaseAuthService())) {
        self.signUpViewModel = signUpViewModel
    }

    // MARK: - Body

    var body: some View {
        VStack {
            Spacer().frame(height: 300)
            Text("Create your own account!")
                .font(.system(size: 24))
                .fontWeight(.semibold)
            Text("Please, fill all fields")
                .font(.system(size: 12))
                .foregroundColor(Color.gray)
                .fontWeight(.medium)
                .padding(.bottom, 20)
            TextField("Name", text: $signUpViewModel.modelState.userName)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
            TextField("Email", text: $signUpViewModel.modelState.userEmail)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
            SecureField("Password", text: $signUpViewModel.modelState.userPassword)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
            SecureField("Repeat Password", text: $signUpViewModel.modelState.userRepeatPassword)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
            Button(action: registerClicked) {
                Text("Create an account")
                    .foregroundColor(Color.white)
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(45)
            }
            .padding(EdgeInsets(top: 30, leading: 10, bottom: 0, trailing: 10))
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
            Spacer().frame(height: 100)
        }
        .background(image, alignment: .topLeading)
        .ignoresSafeArea()

    }

    var image: some View {
        Image("RegistrationIcon")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .clipped()
    }

    // MARK: - Methods

    func registerClicked() {
        signUpViewModel.createUser(completionBlock: { (success) in
            presentAlert = true
            if success {
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
    }
}
