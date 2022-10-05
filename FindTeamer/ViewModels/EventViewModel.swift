//
//  EventViewModel.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 28.08.22.
//

import Combine

final class EventViewModel {
    // MARK: - Internal properties
    @Published var event: EventModel
    @Published var modified = false
    // will be from coreData
    let sports = ["Football",
                  "Basketball",
                  "Tennis",
                  "Chess",
                  "Gym"]
    
    // MARK: - Private properties
    private let eventManager: EventManager
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initializators
    init(event: EventModel = EventModel(), eventManager: EventManager) {
        self.event = event
        self.eventManager = eventManager
    }
    
    // MARK: - Methods
    private func addEvent(_ event: EventModel) {
        eventManager.addEvent(event: event)
    }
    func handleDoneTapped() {
        self.addEvent(event)
    }
}
