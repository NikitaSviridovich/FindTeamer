//
//  LogInViewModelTests.swift
//  FindTeamerTests
//
//  Created by Nikita Sviridovich on 18.10.22.
//

import XCTest
import Combine
@testable import FindTeamer

class LogInViewModelTests: XCTestCase {
    var loginModel: LogInModel!
    var viewModel: LogInViewModel!
    var authManagerMock: AuthManagerMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        loginModel = LogInModel()
        authManagerMock = AuthManagerMock()
        viewModel = LogInViewModel(authManager: authManagerMock)
    }

    override func tearDownWithError() throws { }

    func user_ShouldBeCreated_WhenGivenLoginModel() throws {
        
    }

}
