//
//  EventModel.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 28.08.22.
//

import Foundation

struct EventModel: Identifiable {
    var id: String = UUID().uuidString
    var eventType: String
    var eventTitle : String
    var eventEmail: String
    var eventPhoneNumber: String
    var eventAddress: String
    var eventTime: Date
    var eventDescription: String
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
}
