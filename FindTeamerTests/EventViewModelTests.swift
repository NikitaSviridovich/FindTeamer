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

    func testEventTitle_ShouldBeInstalled_WhenGivenValue() throws {
        let expected = "Footbal indoor"
        event.eventTitle = "Footbal indoor"
        XCTAssertEqual(eventViewModel.event.eventTitle, expected)
    }

    func testEventDescription_ShouldBeInstalled_WhenGivenValue() throws {
        let expected = "Desc_Desc_Desc_Desc_Desc"
        event.eventDescription = "Desc_Desc_Desc_Desc_Desc"
        XCTAssertEqual(eventViewModel.event.eventDescription, expected)
    }

    func testEventType_ShouldBeInstalled_WhenGivenValue() throws {
        let expected = "Tennis"
        event.eventType = "Tennis"
        XCTAssertEqual(eventViewModel.event.eventType, expected)
    }

    func testEventEmail_ShouldBeInstalled_WhenGivenValue() throws {
        let expected = "test@gmail.com"
        event.eventEmail = "test@gmail.com"
        XCTAssertEqual(eventViewModel.event.eventEmail, expected)
    }

    func testEventPhoneNumber_ShouldBeInstalled_WhenGivenValue() throws {
        let expected = "+48902789123"
        event.eventPhoneNumber = "+48902789123"
        XCTAssertEqual(eventViewModel.event.eventPhoneNumber, expected)
    }

    func testEventAddress_ShouldBeInstalled_WhenGivenValue() throws {
        let expected = "Test Address"
        event.eventAddress = "Test Address"
        XCTAssertEqual(eventViewModel.event.eventAddress, expected)
    }


    func testIsFormValid_ShouldBeTrue_WhenEventModelIsNotEmpty() throws {
        event.eventTitle = "Footbal indoor"
        event.eventDescription = "Desc_Desc_Desc_Desc_Desc"
        event.eventType = "Tennis"
        event.eventEmail = "test@gmail.com"
        event.eventPhoneNumber = "+48902789123"
        event.eventAddress = "Test Address"
        RunLoop.main.run(mode: .default, before: .distantPast)
        XCTAssert(eventViewModel.isFormValid, "Form absolutely valid!")
    }

    func testAddEventCalled_ShouldBeTrue_WhenHandleDoneTapped() throws {
        event.eventTitle = "Footbal indoor"
        event.eventDescription = "Desc_Desc_Desc_Desc_Desc"
        event.eventType = "Tennis"
        event.eventEmail = "test@gmail.com"
        event.eventPhoneNumber = "+48902789123"
        event.eventAddress = "Test Address"
        RunLoop.main.run(mode: .default, before: .distantPast)
        eventViewModel.handleDoneTapped()
        XCTAssertEqual(eventManagerMock.addEventCalled, true)
    }
}
