//
//  SignUpView.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 16.08.22.
//

import SwiftUI
import Firebase
import Combine


struct SignUpView: View {
    @State var errorArray: String = ""
    
    @ObservedObject var formModel: SignUpModel
    
    init(formModel: SignUpModel = SignUpModel()) {
          self.formModel = formModel
    }
    
    var body: some View {
        WelcomeIcon()
        TextField("Email", text: $formModel.userEmail)
                    .padding()
                    .background(lightGreyColor)
                    .cornerRadius(5.0)
                    .padding(.horizontal, 20)
        SecureField("Password", text: $formModel.userPassword)
                    .padding()
                    .background(lightGreyColor)
                    .cornerRadius(5.0)
                    .padding(.horizontal, 20)
        SecureField("Repeat Password", text: $formModel.userRepeatPassword)
                    .padding()
                    .background(lightGreyColor)
                    .cornerRadius(5.0)
                    .padding(.horizontal, 20)
        Text(errorArray)
            .opacity(0.5)
            .foregroundColor(.red)
            .padding()
        Button(action: registerClicked) {
                   FinishButtonContent()
        }.opacity(buttonOpacity)
    }
    
    var buttonOpacity: Double {
        return formModel.isFormValid &&
                formModel.errorMessages.count == 0 ? 1 : 0.5
    }
    
    func registerClicked() {
        self.errorArray = ""
        if self.formModel.isFormValid && self.formModel.errorMessages.count == 0 {
            
        } else {
            for i in self.formModel.errorMessages {
                self.errorArray += " " + i.value
            }

        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SignUpView()
            SignUpView()
        }
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