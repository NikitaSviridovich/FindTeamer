//
//  EventModel.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 28.08.22.
//

import Foundation
import FirebaseFirestoreSwift

class EventModel: Identifiable, Codable {
    @DocumentID var id: String?
    var eventType = ""
    var eventTitle = ""
    var eventUserCounter = ""
    var eventAddress = ""
    var eventTime: Date = Date()
    var eventDescription = ""
}
