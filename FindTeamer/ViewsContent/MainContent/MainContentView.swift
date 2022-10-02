//
//  MainContentView.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 23.08.22.
//

import SwiftUI

struct MainContentView: View {
    @State var presentAddEventSheet = false
    @ObservedObject var viewModel = EventsViewModel(eventManager: FirebaseEventService())
    init() { }
    var body: some View {
        ZStack {
            List(viewModel.events) { event in
                EventCellGenerator(event: event)
            }
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: self.$presentAddEventSheet) {
                    CreateEventView()
            }
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
        }
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
