//
//  EventsViewModelTests.swift
//  EventsViewModelTests
//
//  Created by Nikita Sviridovich on 20.10.22.
//

import XCTest
@testable import FindTeamer

class EventsViewModelTests: XCTestCase {
    var eventsViewModel: EventsViewModel!
    var eventManagerMock: EventManagerMock!

    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }

    func testEvents_ShouldBeNotNil_WhenViewModelIntitialized() throws {
        eventsViewModel = EventsViewModel(eventManager: eventManagerMock)
        XCTAssertNotNil(eventsViewModel.events)
    }
}
