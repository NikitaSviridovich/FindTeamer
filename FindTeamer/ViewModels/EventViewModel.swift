//
//  EventViewModel.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 28.08.22.
//

import Combine

final class EventViewModel {
    // MARK: Publishers
    @Published var event: EventModel
    @Published var modified = false
    // MARK: Private fields
    private let eventManager: EventManager
    private var cancellables = Set<AnyCancellable>()
    // MARK: Initializator
    init(event: EventModel = EventModel(), eventManager: EventManager) {
        self.event = event
        self.eventManager = eventManager
    }
    // MARK: Methods
    private func addEvent(_ event: EventModel) {
        eventManager.addEvent(event: event)
    }
    func handleDoneTapped() {
        self.addEvent(event)
    }
}
