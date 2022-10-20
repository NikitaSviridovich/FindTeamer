//
//  RootViewModelTests.swift
//  RootViewModelTests
//
//  Created by Nikita Sviridovich on 20.10.22.
//

import XCTest
@testable import FindTeamer

class RootViewModelTests: XCTestCase {
    var rootViewModel: RootViewModel!
    var authManagerMock: AuthManagerMock!

    override func setUpWithError() throws {
        authManagerMock = AuthManagerMock()
    }
    
    func testAuthObserver_ShouldBeNotNil_WhenUserHasLoggedIn() throws {
        rootViewModel = RootViewModel(authManager: authManagerMock)
        XCTAssertTrue(rootViewModel.isAuthorized)
    }
}
