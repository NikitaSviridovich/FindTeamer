//
//  CreateEventView.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 28.08.22.
//

import SwiftUI

struct CreateEventView: View {
    // MARK: - Public properties
    @State var viewModel = EventViewModel(eventManager: FirebaseEventService())
    
    // MARK: - Private properties
    @Environment(\.presentationMode) private var presentationMode
    // MARK: - Initializators
    init() { }

    // MARK: - Body
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title")) {
                    TextField("Title", text: $viewModel.event.eventTitle.toUnwrapped(defaultValue: ""))
                }
                Section(header: Text("Kind of sport")) {
                    Picker("Select kind of sport", selection: $viewModel.event.eventType) {
                        ForEach(viewModel.sports, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.menu)
                }
                Section(header: Text("Address")) {
                    TextField("Address", text: $viewModel.event.eventAddress.toUnwrapped(defaultValue: ""))
                }
                Section(header: Text("Email Contact")) {
                    TextField("Email", text: $viewModel.event.eventEmail.toUnwrapped(defaultValue: ""))
                }
                Section(header: Text("Phone Number For Contact")) {
                    TextField("Phone Number", text: $viewModel.event.eventPhoneNumber.toUnwrapped(defaultValue: ""))
                }
                Section(header: Text("Date and Time")) {
                    DatePicker("Pick the time", selection: $viewModel.event.eventTime.toUnwrapped(defaultValue: Date()))
                        .datePickerStyle(.graphical)
                        .frame(maxHeight: 400)
                }
                Section(header: Text("Description")) {
                    TextField("Please add your additional contacts", text: $viewModel.event.eventDescription.toUnwrapped(defaultValue: ""))
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

    // MARK: - Private methods

    private func handleCancelTapped() {
        dismiss()
    }
    private func handleDoneTapped() {
        self.viewModel.handleDoneTapped()
        dismiss()
    }
    private func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
    }
}
