//
//  EventModel.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 28.08.22.
//

import Foundation

struct EventModel: Identifiable {
    @Published var id: String = UUID().uuidString
    @Published var eventType: String
    @Published var eventTitle : String
    @Published var eventEmail: String
    @Published var eventPhoneNumber: String
    @Published var eventAddress: String
    @Published var eventTime: Date
    @Published var eventDescription: String
    // MARK: Initializator
    init(eventType: String = "", eventTitle: String = "",
         eventEmail: String = "", eventPhoneNumber: String = "",
         eventAddress: String = "", eventTime: Date = Date(),
         eventDescription: String = "") {
        self.eventType = eventType
        self.eventTitle = eventTitle
        self.eventEmail = eventEmail
        self.eventPhoneNumber = eventPhoneNumber
        self.eventAddress = eventAddress
        self.eventTime = eventTime
        self.eventDescription = eventDescription
    }
    
    init(from event: Event) {
        self.eventType = event.eventType ?? ""
        self.eventTitle = event.eventTitle ?? ""
        self.eventEmail = event.eventEmail ?? ""
        self.eventPhoneNumber = event.eventPhoneNumber ?? ""
        self.eventAddress = event.eventAddress ?? ""
        self.eventTime = event.eventTime ?? Date()
        self.eventDescription = event.eventDescription ?? ""
    }
}
