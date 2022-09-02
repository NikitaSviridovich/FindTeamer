//
//  MainContentView.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 23.08.22.
//

import SwiftUI

struct MainContentView: View {
    @State var presentAddEventSheet = false
    @State var viewModel = EventsViewModel()
    
    init() { }

    var body: some View {
        ZStack {
            List(viewModel.events) { event in
                eventCellGenerator(event: event)
            }.onAppear() {
                viewModel.initialLoadData()
            }
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: self.$presentAddEventSheet) {
                    CreateEventView()
            }
            VStack { Spacer()
                HStack { Spacer()
                    plusButton(action: self.presentAddEventSheet)
                }
            }
        }
    }
}


struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
