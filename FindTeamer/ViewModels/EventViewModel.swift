//
//  EventViewModel.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 28.08.22.
//

import Combine
import SwiftUI

final class EventViewModel {
    // MARK: - Internal properties
    @Published var event: EventModel
    @Published var isFormValid = false
    // will be from coreData
    let sports = ["Football",
                  "Basketball",
                  "Tennis",
                  "Chess",
                  "Gym"]
    // MARK: - Private properties
    @Published private var validator: EventModelValidator
    private let eventManager: EventManager
    private var cancellables = Set<AnyCancellable>()
    private var publishers = Set<AnyCancellable>()
    private var isEventFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest4(
            self.validator.isEventEmailValidPublisher,
            self.validator.isEventTitleValidPublisher,
            self.validator.isEventPhoneNumberValidPublisher,
            self.validator.isEventDescValidPublisher)
        .map { isEventEmailValid, isEventTitleValid, isEventPhoneNumber, isEventDescValid in
            return isEventEmailValid && isEventTitleValid && isEventPhoneNumber && isEventDescValid
        }
        .eraseToAnyPublisher()
    }
    // MARK: - Initializators
    init(event: EventModel = EventModel(), eventManager: EventManager) {
        self.event = event
        self.eventManager = eventManager
        self.validator = EventModelValidator(modelState: event)
        isEventFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isFormValid, on: self)
            .store(in: &publishers)
    }
    // MARK: - Methods
    func handleDoneTapped() {
        if isFormValid {
            eventManager.addEvent(event: event)
        }
    }
}
