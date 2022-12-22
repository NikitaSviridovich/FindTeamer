//
//  MainContentView.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 23.08.22.
//

import SwiftUI

struct MainContentView: View {
    // MARK: - Private properties
    @State private var showMenu: Bool = false
    @State private var presentAddEventSheet = false
    @ObservedObject private var viewModel: EventsViewModel

    // MARK: - Initializators

    init(eventManager: EventManager) {
        self.viewModel = EventsViewModel(eventManager: eventManager)
    }

    // MARK: - Body

    var body: some View {
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
                    withAnimation {
                        self.showMenu = false
                    }
                }
            }
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
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
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            if !self.showMenu {
                                Button(action: {
                                    self.showMenu = true
                                }) {
                                    Image(systemName: "line.horizontal.3")
                                        .imageScale(.large)
                                }
                            }
                        }
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .offset(x: self.showMenu ? geometry.size.width/2 : 0)
            .disabled(self.showMenu ? true : false)
            if self.showMenu {
                MenuView()
                    .frame(width: geometry.size.width/2)
                    .transition(.move(edge: .leading))
            }
        }
        .gesture(drag)
    }
}
