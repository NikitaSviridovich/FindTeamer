//
//  EventsViewModel.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 1.09.22.
//

import Combine

class EventsViewModel: ObservableObject {
    // MARK: Publishers
    @Published var events = [EventModel]()
    // MARK: Private fields
    private var cancellable: AnyCancellable!
    private var firebaseEventManager: FirebaseEventManager
    // MARK: Initializator
    init(firebaseEventManager: FirebaseEventManager = FirebaseEventManager()) {
        self.firebaseEventManager = firebaseEventManager
        cancellable = firebaseEventManager.$events.sink { [weak self] data in
        guard let strongSelf = self else { return }
            strongSelf.events = data
        }
    }
    // MARK: Methods
    func loadEventsData() {
        firebaseEventManager.getEvents(events: events)
    }
}
