//
//  MainContentView.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 23.08.22.
//

import SwiftUI

struct MainContentView: View {
    // MARK: - Private properties

    @State private var presentAddEventSheet = false
    @ObservedObject private var viewModel: EventsViewModel
    private let logInViewModel: LogInViewModel = LogInViewModel(authManager: FirebaseAuthService())

    // MARK: - Initializators

    init(eventManager: EventManager) {
        self.viewModel = EventsViewModel(eventManager: eventManager)
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            List(viewModel.events) { event in
                EventCell(event: event)
            }
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: self.$presentAddEventSheet) {
                CreateEventView()
            }
            if NetworkReachability.isConnectedToNetwork() {
                VStack { Spacer()
                    HStack { Spacer()
                        Button(action: {
                            self.presentAddEventSheet.toggle()
                        }, label: {
                            Text("+")
                                .font(.system(.largeTitle))
                                .frame(width: 77, height: 70)
                                .foregroundColor(Color.white)
                                .padding(.bottom, 7)
                        })
                        .background(Color.green)
                        .cornerRadius(38.5)
                        .padding()
                        .shadow(color: Color.black.opacity(0.3),
                                radius: 3,
                                x: 3,
                                y: 3)
                    }
                }.navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                self.signOut()
                            }) {
                                Image(systemName: "line.horizontal.3")
                                    .imageScale(.large)
                            }
                        }
                    }
            }
        }
    }

    private func signOut() {
        logInViewModel.signOut()
    }
}
