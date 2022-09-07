//
//  CommonComponents.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 28.08.22.
//

import SwiftUI

//COLORS

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

// TEXT


struct WelcomeText : View {
    var body: some View {
        return Text("FindTeamer")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
    }
}

// ICONS

struct WelcomeIcon : View {
    var body: some View {
        return Image("WelcomeIcon")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipped()
            .cornerRadius(10)
            .padding(.bottom, 35)
    }
}

// BUTTONS

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
