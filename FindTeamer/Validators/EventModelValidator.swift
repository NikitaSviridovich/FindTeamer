//
//  EventModelValidator.swift
//  FindTeamer
//
//  Created by Mikita Svirydovich on 12/10/2022.
//

import SwiftUI
import Combine

final class EventModelValidator: ObservableObject {
    // MARK: - Internal properties
    @Published var modelState: EventModel
    var isEventTypeValidPublisher: AnyPublisher<Bool, Never> {
        modelState.$eventType
            .map { eventType in
                guard let eventType = eventType else { return false }
                return !eventType.isEmpty
            }
            .eraseToAnyPublisher()
    }
    var isEventEmailValidPublisher: AnyPublisher<Bool, Never> {
        modelState.$eventEmail
            .map { email in
                return NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
                    .evaluate(with: email)
            }
            .eraseToAnyPublisher()
    }
    var isEventTitleValidPublisher: AnyPublisher<Bool, Never> {
        modelState.$eventTitle
            .map { eventTitle in
                guard let eventTitle = eventTitle else { return false }
                return eventTitle.count > self.minFieldLength

            }
            .eraseToAnyPublisher()
    }
    var isEventPhoneNumberValidPublisher: AnyPublisher<Bool, Never> {
        modelState.$eventPhoneNumber
            .map { eventPhoneNumber in
                return NSPredicate(format:"SELF MATCHES %@", "^[0-9+]{0,1}+[0-9]{5,16}$")
                    .evaluate(with: eventPhoneNumber)
            }
            .eraseToAnyPublisher()
    }

    // MARK: - Private properties
    private let minFieldLength = 3
    private let minDescLength = 16
    
    // MARK: - Initializators
    init(modelState: EventModel = EventModel()) {
        self.modelState = modelState
    }
}
