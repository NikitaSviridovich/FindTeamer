//
//  EventManagerMock.swift
//  FindTeamerTests
//
//  Created by Nikita Sviridovich on 18.10.22.
//

import Foundation
import Combine
@testable import FindTeamer


class EventManagerMock: EventManager {

    var addEventCalled = false
    var observeEventsResult: AnyPublisher<[EventModel], Never>!

    func addEvent(event: EventModel) {
        addEventCalled = true
    }

    func observeEvents() -> AnyPublisher<[EventModel], Never> {
        let subject = CurrentValueSubject<[EventModel], Never>([EventModel]())
        subject.send(getEvents())
        return subject.eraseToAnyPublisher()
    }
    private func getEvents() -> [EventModel] {
        return [EventModel()]
    }
}
