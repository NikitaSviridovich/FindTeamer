//
//  EventViewModelTests.swift
//  EventViewModelTests
//
//  Created by Nikita Sviridovich on 10.08.22.
//

import XCTest
import Combine
@testable import FindTeamer

class EventViewModelTests: XCTestCase {
    var event: EventModel!
    var eventViewModel: EventViewModel!
    var eventsViewModel: EventsViewModel!
    var eventManagerMock: EventManagerMock!
    private var cancellable = Set<AnyCancellable>()

    override func setUpWithError() throws {
        try super.setUpWithError()
        event = EventModel()
        eventManagerMock = EventManagerMock()
        eventViewModel = EventViewModel(event: event, eventManager: eventManagerMock)
    }

    override func tearDownWithError() throws {
        eventViewModel = nil
        event = nil
        try super.tearDownWithError()
    }

    func eventTitle_ShouldBeInstalled_WhenGivenValue() throws {
        let expected = "Footbal indoor"
        event.eventTitle = "Footbal indoor"
        XCTAssertEqual(eventViewModel.event.eventTitle, expected)
    }

    func eventDescription_ShouldBeInstalled_WhenGivenValue() throws {
        let expected = "Desc_Desc_Desc_Desc_Desc"
        event.eventDescription = "Desc_Desc_Desc_Desc_Desc"
        XCTAssertEqual(eventViewModel.event.eventDescription, expected)
    }

    func eventType_ShouldBeInstalled_WhenGivenValue() throws {
        let expected = "Tennis"
        event.eventType = "Tennis"
        XCTAssertEqual(eventViewModel.event.eventType, expected)
    }

    func eventEmail_ShouldBeInstalled_WhenGivenValue() throws {
        let expected = "test@gmail.com"
        event.eventEmail = "test@gmail.com"
        XCTAssertEqual(eventViewModel.event.eventEmail, expected)
    }

    func eventPhoneNumber_ShouldBeInstalled_WhenGivenValue() throws {
        let expected = "+48902789123"
        event.eventPhoneNumber = "+48902789123"
        XCTAssertEqual(eventViewModel.event.eventPhoneNumber, expected)
    }

    func eventAddress_ShouldBeInstalled_WhenGivenValue() throws {
        let expected = "Test Address"
        event.eventAddress = "Test Address"
        XCTAssertEqual(eventViewModel.event.eventAddress, expected)
    }


    func isFormValid_ShouldBeTrue_WhenEventModelIsNotEmpty() throws {
        RunLoop.main.run(mode: .default, before: .distantPast) // make UT wait for one event
        XCTAssert(eventViewModel.isFormValid, "Form absolutely valid!")
    }

    func addEventCalled_ShouldBeTrue_WhenHandleDoneTapped() throws {
        eventViewModel.handleDoneTapped()
        XCTAssertEqual(eventManagerMock.addEventCalled, true)
    }

    func events_ShouldBeNotNil_WhenViewModelIntitialized() throws {
        eventsViewModel = EventsViewModel(eventManager: eventManagerMock)
        XCTAssertNotNil(eventsViewModel.events)
    }
}
