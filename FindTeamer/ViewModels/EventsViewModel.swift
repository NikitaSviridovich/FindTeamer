//
//  EventsViewModel.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 1.09.22.
//

import Combine

final class EventsViewModel: ObservableObject {
    // MARK: - Internal properties
    @Published var events = [EventModel]()
    
    // MARK: - Private properties
    private var cancellable = Set<AnyCancellable>()
    private let eventManager: EventManager
    private let coreDataService: CoreDataService = CoreDataService()

    // MARK: - Initializators
    init(eventManager: EventManager) {
        self.eventManager = eventManager
        self.eventManager.observeEvents().sink { [weak self] data in
            guard let strongSelf = self else { return }
            strongSelf.events = data
            strongSelf.coreDataService.storeEventsInCoreData(fromFirebase: strongSelf.events)
        }.store(in: &cancellable)
    }
}
