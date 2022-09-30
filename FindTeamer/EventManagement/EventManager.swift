//
//  EventManager.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 30.09.22.
//

import Foundation

protocol EventManager {
    var eventsPublisher: Published<[EventModel]>.Publisher { get }
    func addEvent(event: EventModel)
    func addEventsListener()
}
