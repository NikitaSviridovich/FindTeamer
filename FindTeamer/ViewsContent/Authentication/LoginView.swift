//
//  LoginView.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 16.08.22.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State private var presentAlert = false
    @State private var successLogin = false
    
    let signInManager: FirebaseManager = FirebaseManager()
    let alertModel: AlertModel = AlertModel()
    let viewModel: EventsViewModel = EventsViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                WelcomeText()
                WelcomeIcon()
                TextField("Email", text: $email)
                            .padding()
                            .background(lightGreyColor)
                            .cornerRadius(10.0)
                            .padding(.horizontal, 20)
                SecureField("Password", text: $password)
                            .padding()
                            .background(lightGreyColor)
                            .cornerRadius(10.0)
                            .padding(.horizontal, 20)
                NavigationLink(destination: MainContentView(), isActive: self.$successLogin) {
                    Button(action: logInClicked) {
                            LoginButtonContent()
                    }
                    .alert(isPresented: $presentAlert) {
                        return Alert (
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
                NavigationLink(destination: SignUpView()){
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
        signInManager.signIn(email: email, password: password, completionBlock: { (authResult, error) in
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
