//
//  RootView.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 12.09.22.
//

import SwiftUI

struct RootView: View {
    @ObservedObject var viewModel: RootViewModel = RootViewModel()
    
    var body: some View {
        if viewModel.isAuthorized {
            AnyView(MainContentView())
        } else {
            AnyView(LoginView())
        }
    }
}
