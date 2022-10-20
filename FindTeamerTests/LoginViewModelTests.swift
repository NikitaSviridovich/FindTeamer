//
//  LoginViewModelTests.swift
//  LoginViewModelTests
//
//  Created by Nikita Sviridovich on 18.10.22.
//

import XCTest
import Combine
@testable import FindTeamer

class LoginViewModelTests: XCTestCase {
    var loginModel: LogInModel!
    var loginViewModel: LogInViewModel!
    var authManagerMock: AuthManagerMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        loginModel = LogInModel()
        authManagerMock = AuthManagerMock()
        loginViewModel = LogInViewModel(modelState: loginModel, authManager: authManagerMock)
    }

    override func tearDownWithError() throws { }

    func testUser_ShouldBeSignIn_WhenLogInModelIsNotEmpty() throws {
        loginModel.email = "Qwe@qwe.wee"
        loginModel.password = "123123123"
        loginViewModel.signIn(completionBlock: { error in
            XCTAssertNotNil(error!.localizedDescription)
        })
    }

    func testUser_ShouldBeSignOuted_WhenMethodCalled() throws {
        loginViewModel.signOut()
        XCTAssertTrue(authManagerMock.signOutFlag)
    }
}
