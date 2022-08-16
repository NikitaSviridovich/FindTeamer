//
//  LoginView.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 16.08.22.
//

import SwiftUI
import Firebase

struct LoginView: View {
    var body: some View {
        VStack {
            WelcomeText()
            WelcomeIcon()
            
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
        return Text("Hi there!")
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
