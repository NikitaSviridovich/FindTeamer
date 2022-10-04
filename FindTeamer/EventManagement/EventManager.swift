//
//  EventManager.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 30.09.22.
//

import Combine

protocol EventManager {
    func addEvent(event: EventModel)
    func observeEvents() -> AnyPublisher<[EventModel], Never>
}
