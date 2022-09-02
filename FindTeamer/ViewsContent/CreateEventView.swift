//
//  CreateEventView.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 28.08.22.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase

struct CreateEventView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var viewModel = EventViewModel()
    
    @State private var selectionEventType = ""
    @State private var selectionEventDate = Date()
    
    let sports = ["Football", "Basketball", "Tennis", "Chess", "Gym"]
    var ref: DatabaseReference!
    init() {
        ref = Database.database().reference()
    }
    
    var body: some View {
        NavigationView {
              Form {
                  Section(header: Text("Title")) {
                      TextField("Title", text: $viewModel.event.eventTitle)
                  }
                  Section(header: Text("Kind of sport")) {
                      Picker("Select kind of sport", selection: $selectionEventType) {
                          ForEach(sports, id: \.self) {
                              Text($0)
                          }
                      }.pickerStyle(.menu)
                  }
                  Section(header: Text("Address")) {
                      TextField("Address", text: $viewModel.event.eventAddress)
                  }
                  
                  Section(header: Text("Number of players")) {
                      Text(viewModel.event.eventUserCounter)
                  }
                  
                  Section(header: Text("Date and Time")) {
                      DatePicker("Pick the time", selection: $selectionEventDate)
                          .datePickerStyle(.graphical)
                            .frame(maxHeight: 400)
                  }
                  Section(header: Text("Description")) {
                      TextField("", text: $viewModel.event.eventDescription)
                          .frame(height: 150, alignment: .topLeading)
                  }
              }
              .navigationBarTitle("New event", displayMode: .inline)
              .navigationBarItems(leading:
                  Button(action: { self.handleCancelTapped() }) {
                      Text("Cancel")
                  }, trailing:
                  Button(action: { self.handleDoneTapped() }) {
                      Text("Done")
                  }
                  .disabled(false))
        }
    }
    func handleCancelTapped() {
        dismiss()
      }
      
    func handleDoneTapped() {
        self.viewModel.event.eventTime = selectionEventDate
        self.viewModel.event.eventType = selectionEventType
        self.viewModel.handleDoneTapped()
        dismiss()
      }
      
      func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
      }
}

struct CreateEventView_Previews: PreviewProvider {
    static var previews: some View {
        CreateEventView()
    }
}
