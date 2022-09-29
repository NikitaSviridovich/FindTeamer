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
    private let firebaseEventManager: FirebaseEventManager
    private var cancellables = Set<AnyCancellable>()
    // MARK: Initializator
    init(event: EventModel = EventModel(), firebaseEventManager: FirebaseEventManager = FirebaseEventManager()) {
        self.event = event
        self.firebaseEventManager = FirebaseEventManager()
    }
    // MARK: Methods
    private func addEvent(_ event: EventModel) {
        firebaseEventManager.addEvent(event)
    }
    func handleDoneTapped() {
        self.addEvent(event)
    }
}
