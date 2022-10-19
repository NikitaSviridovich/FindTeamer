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
    private var buttonOpacity: Double {
        return signUpViewModel.isFormValid ? 1 : 0.5
    }
    private let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

    // MARK: - Initializators

    init(signUpViewModel: SignUpViewModel = SignUpViewModel(authManager: FirebaseAuthService())) {
        self.signUpViewModel = signUpViewModel
    }

    // MARK: - Body

    var body: some View {
        Text("Registration")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
        Image("WelcomeIcon")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipped()
            .cornerRadius(10)
            .padding(.bottom, 35)
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
        Button(action: registerClicked) {
            Text("Let's Go!")
                .font(.callout)
                .foregroundColor(.white)
                .padding()
                .frame(width: 330, height: 40)
                .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(45.0)
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

    // MARK: - Methods

    func registerClicked() {
        signUpViewModel.createUser(completionBlock: { (success) in
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
    }
}
