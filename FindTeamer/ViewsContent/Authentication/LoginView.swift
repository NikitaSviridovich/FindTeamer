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
    private let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

    // MARK: - Initializators

    init() { }
    
    // MARK: - Body

    var body: some View {
        NavigationView {
            VStack {
                Text("FindTeamer")
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
                NavigationLink(destination: MainContentView(eventManager: FirebaseEventService()), isActive: self.$successLogin) {
                    Button(action: logInClicked) {
                        Text("LOG IN")
                            .font(.callout)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 330, height: 40)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(45.0)
                    }
                    .alert(isPresented: $presentAlert) {
                        return Alert(
                            title: Text(alertModel.title),
                            message: Text(alertModel.message),
                            dismissButton: .destructive(Text(alertModel.buttonNaming))
                        )
                    }.accessibilityIdentifier("loginButton")
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
                        .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]),
                                                   startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(40)
                        .font(.callout)
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
