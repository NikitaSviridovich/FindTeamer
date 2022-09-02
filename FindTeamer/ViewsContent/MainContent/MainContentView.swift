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
    
    init() {
        viewModel.initialLoadData()
    }
    
    private func eventRowView(event: EventModel) -> some View {
          VStack(alignment: .leading) {
              Text(event.eventTitle)
              .font(.headline)
              Text(event.eventType)
              .font(.subheadline)
              Text(event.eventTime.formatted(.dateTime))
              .font(.subheadline)
          }
    }
    
    var body: some View {
        ZStack {
            List(viewModel.events) { event in
                VStack {
                    eventRowView(event: event)
            }
        }.navigationBarBackButtonHidden(true)
        .sheet(isPresented: self.$presentAddEventSheet) {
            CreateEventView()
        }
        
        VStack {
            Spacer()
            HStack {
                Spacer()
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
        }
    }
}


struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}

struct AddEventButton: View {
  var action: () -> Void
  var body: some View {
    Button(action: { self.action() }) {
      Image(systemName: "plus")
    }
  }
}
