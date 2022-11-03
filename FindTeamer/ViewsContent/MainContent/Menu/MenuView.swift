//
//  MenuView.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 27.10.22.
//

import SwiftUI

struct MenuView: View {
    private let logInViewModel: LogInViewModel = LogInViewModel(authManager: FirebaseAuthService())
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("My profile")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding(.top, 100)
            HStack {
                Image(systemName: "bolt")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("My events")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding(.top, 30)
            Spacer()
            HStack {
                Image(systemName: "square.and.arrow.down")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Button(action: {
                    self.signOut()
                }) {
                    Text("Logout")
                }
            }
            .padding(.bottom, 50)

        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
        .edgesIgnoringSafeArea(.all)
    }

    private func signOut() {
        logInViewModel.signOut()
    }
}
