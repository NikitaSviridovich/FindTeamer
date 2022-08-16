//
//  SignUpView.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 16.08.22.
//

import SwiftUI
import Firebase


struct SignUpView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var repeatedPassword: String = ""
    
    var body: some View {
        WelcomeIcon()
        RegText()
        TextField("Email", text: $email)
                    .padding()
                    .background(lightGreyColor)
                    .cornerRadius(5.0)
                    .padding(.horizontal, 20)
        SecureField("Password", text: $password)
                    .padding()
                    .background(lightGreyColor)
                    .cornerRadius(5.0)
                    .padding(.horizontal, 20)
        SecureField("Repeat Password", text: $password)
                    .padding()
                    .background(lightGreyColor)
                    .cornerRadius(5.0)
                    .padding(.horizontal, 20)
        Button(action: {print("Button tapped")}) {
                   FinishButtonContent()
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

struct FinishButtonContent : View {
    var body: some View {
        Text("Let's Go!")
                        .font(.callout)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 330, height: 40)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(45.0)
    }
}

struct RegText : View {
    var body: some View {
        return Text("Fill The Form")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
    }
}
