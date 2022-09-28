//
//  LoginView.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 16.08.22.
//

import SwiftUI

struct LoginView: View {
    @State private var presentAlert = false
    @State private var successLogin = false
    let alertModel: AlertModel = AlertModel()
    @ObservedObject var logInViewModel: LogInViewModel = LogInViewModel()
    init(logInViewModel: LogInViewModel = LogInViewModel()) {
        self.logInViewModel = logInViewModel
    }
    var body: some View {
        NavigationView {
            VStack {
                WelcomeText()
                WelcomeIcon()
                TextField("Email", text: $logInViewModel.modelState.email)
                            .padding()
                            .background(lightGreyColor)
                            .cornerRadius(10.0)
                            .padding(.horizontal, 20)
                SecureField("Password", text: $logInViewModel.modelState.password)
                            .padding()
                            .background(lightGreyColor)
                            .cornerRadius(10.0)
                            .padding(.horizontal, 20)
                NavigationLink(destination: MainContentView(), isActive: self.$successLogin) {
                    Button(action: logInClicked) {
                            LoginButtonContent()
                    }
                    .alert(isPresented: $presentAlert) {
                        return Alert(
                            title: Text(alertModel.title),
                            message: Text(alertModel.message),
                            dismissButton: .destructive(Text(alertModel.buttonNaming))
                        )
                    }
                }
                Text("OR")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .padding(.all, 30)
                NavigationLink(destination: SignUpView()) {
                    Text("SIGN UP")
                            .frame(width: 300, height: 10)
                            .padding()
                            .foregroundColor(.white)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(40)
                            .font(.callout)
                }
            }.navigationBarHidden(true)
        }
    }
    func logInClicked() {
        logInViewModel.signIn(email: logInViewModel.modelState.email,
                              password: logInViewModel.modelState.password, completionBlock: { (authResult, error) in
            if let error = error, authResult == nil {
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
