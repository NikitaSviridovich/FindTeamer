//
//  EventsViewModel.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 1.09.22.
//

import Combine

final class EventsViewModel: ObservableObject {
    // MARK: Publishers
    @Published var events = [EventModel]()
    // MARK: Private fields
    private var cancellable = Set<AnyCancellable>()
    private let eventManager: EventManager
    // MARK: Initializator
    init(eventManager: EventManager) {
        self.eventManager = eventManager
        self.eventManager.eventsPublisher.sink { [weak self] data in
            guard let strongSelf = self else { return }
            strongSelf.events = data
        }
        .store(in: &cancellable)
    }
    // MARK: Methods
    func loadEventsData() {
        eventManager.addEventsListener()
    }
}
