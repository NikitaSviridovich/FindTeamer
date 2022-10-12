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
    @Published var modified = false
    // will be from coreData
    let sports = ["Football",
                  "Basketball",
                  "Tennis",
                  "Chess",
                  "Gym"]
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: Event.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Event.eventType, ascending: true)
        ]
    )
    var events: FetchedResults<Event>
    // MARK: - Private properties
    private let eventManager: EventManager
    private var cancellables = Set<AnyCancellable>()
    var repository:CoreDataService!
    // MARK: - Initializators
    init(event: EventModel = EventModel(), eventManager: EventManager, repository: CoreDataService) {
        self.event = event
        self.eventManager = eventManager
        self.repository = repository
    }
    // MARK: - Methods
    private func addEvent(_ event: EventModel) {
        eventManager.addEvent(event: event)
    }
    func handleDoneTapped() {
        self.addEvent(event)
    }
}
