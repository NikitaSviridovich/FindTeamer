//
//  LoginView.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 16.08.22.
//

import SwiftUI

struct LoginView: View {
    // MARK: - Private properties

    @State private var presentAlert = false
    @State private var successLogin = false
    @ObservedObject private var logInViewModel: LogInViewModel = LogInViewModel(authManager: FirebaseAuthService())
    private let alertModel: AlertModel = AlertModel()

    // MARK: - Initializators

    init() { }

    // MARK: - Body

    var body: some View {
        NavigationView {
            VStack {
                Image("WelcomeIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 260)
                    .clipped()
                    .cornerRadius(10)
                    .padding(.bottom, 35)
                Text("Login to continue")
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                Text("Welcome back! You have been missed!")
                    .font(.system(size: 12))
                    .foregroundColor(Color.gray)
                    .fontWeight(.medium)
                    .padding(.bottom, 20)
                TextField("Email", text: $logInViewModel.modelState.email)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
                SecureField("Password", text: $logInViewModel.modelState.password)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                NavigationLink(destination: MainContentView(eventManager: FirebaseEventService()), isActive: self.$successLogin) {
                    Button(action: logInClicked) {
                        Text("Login")
                            .foregroundColor(Color.white)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(45)
                    }
                    .padding(EdgeInsets(top: 30, leading: 10, bottom: 0, trailing: 10))
                    .alert(isPresented: $presentAlert) {
                        return Alert(
                            title: Text(alertModel.title),
                            message: Text(alertModel.message),
                            dismissButton: .destructive(Text(alertModel.buttonNaming))
                        )
                    }.accessibilityIdentifier("loginButton")
                }
                NavigationLink(destination: SignUpView()) {
                    Text("Don't have an account? Create a one")
                        .font(.system(size: 12))
                        .foregroundColor(.green)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
            }.navigationBarHidden(true)
        }
    }

    // MARK: - Methods

    func logInClicked() {
        logInViewModel.signIn(completionBlock: { error in
            if let error = error {
                presentAlert = true
                alertModel.title = "Sign In Failed"
                alertModel.message = error.localizedDescription
                alertModel.buttonNaming = "OK :("
            } else {
                successLogin = true
            }
        })
    }
}
