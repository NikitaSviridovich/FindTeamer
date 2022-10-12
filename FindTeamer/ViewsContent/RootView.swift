//
//  RootView.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 12.09.22.
//

import SwiftUI

struct RootView: View {
    // MARK: - Internal properties
    @ObservedObject var viewModel: RootViewModel = RootViewModel(authManager: FirebaseAuthService())
    
    // MARK: - Body
    var body: some View {
        if viewModel.isAuthorized || !NetworkReachability.isConnectedToNetwork() {
            NavigationView { MainContentView(eventManager: NetworkReachability.isConnectedToNetwork() ? FirebaseEventService() : CoreDataService()) }
        } else {
            LoginView()
        }
        //LoginView()
    }
}
