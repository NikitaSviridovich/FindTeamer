//
//  LoginView.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 16.08.22.
//

import SwiftUI
import Firebase

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    
    
    var body: some View {
        NavigationView{
            VStack {
                WelcomeText()
                WelcomeIcon()
                TextField("Username", text: $email)
                            .padding()
                            .background(lightGreyColor)
                            .cornerRadius(5.0)
                            .padding(.horizontal, 20)
                        SecureField("Password", text: $password)
                            .padding()
                            .background(lightGreyColor)
                            .cornerRadius(5.0)
                            .padding(.horizontal, 20)
                Button(action: {print("Button tapped")}) {
                           LoginButtonContent()
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
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct WelcomeText : View {
    var body: some View {
        return Text("FindTeamer")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
    }
}

struct WelcomeIcon : View {
    var body: some View {
        return Image("WelcomeIcon")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipped()
            .cornerRadius(10)
            .padding(.bottom, 75)
    }
}

struct LoginButtonContent : View {
    var body: some View {
        Text("LOG IN")
                        .font(.callout)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 330, height: 40)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(45.0)
    }
}
