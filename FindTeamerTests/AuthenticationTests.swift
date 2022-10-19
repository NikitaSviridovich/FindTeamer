//
//  AuthenticationTests.swift
//  AuthenticationTests
//
//  Created by Nikita Sviridovich on 18.10.22.
//

import XCTest
import Combine

@testable import FindTeamer
class AuthenticationTests: XCTestCase {
    var loginModel: LogInModel!
    var signupModel = SignUpModel()
    var loginViewModel: LogInViewModel!
    var signUpViewModel: SignUpViewModel!
    var rootViewMobel: RootViewModel!
    var authManagerMock: AuthManagerMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        loginModel = LogInModel()
        signupModel = SignUpModel()
        authManagerMock = AuthManagerMock()
        loginViewModel = LogInViewModel(modelState: loginModel, authManager: authManagerMock)
        signUpViewModel = SignUpViewModel(signUpModel: signupModel, authManager: authManagerMock)
    }

    override func tearDownWithError() throws { }

    func testUserName_ShouldBeInstalled_WhenGivenValue() throws {
        let expected = "Mikita"
        signupModel.userName = "Mikita"
        XCTAssertEqual(signUpViewModel.modelState.userName, expected)
    }

    func testUserEmail_ShouldBeInstalled_WhenGivenValue() throws {
        let expected = "test@test.com"
        signupModel.userEmail = "test@test.com"
        XCTAssertEqual(signUpViewModel.modelState.userEmail, expected)
    }

    func testUserPassword_ShouldBeInstalled_WhenGivenValue() throws {
        let expected = "Test123123"
        signupModel.userPassword = "Test123123"
        XCTAssertEqual(signUpViewModel.modelState.userPassword, expected)
    }

    func testUserRepeatPassword_ShouldBeAsPassword_WhenGivenValue() throws {
        let expected = "Test123123"
        signupModel.userRepeatPassword = "Test123123"
        XCTAssertEqual(signUpViewModel.modelState.userRepeatPassword, expected)
    }

    func testIsFormValid_ShouldBeTrue_WhenSignUpModelIsNotEmpty() throws {
        signupModel.userName = "Mikita"
        signupModel.userEmail = "test@test.com"
        signupModel.userPassword = "Test123123"
        signupModel.userRepeatPassword = "Test123123"
        RunLoop.main.run(mode: .default, before: .distantPast) // make UT wait for one event
        XCTAssert(signUpViewModel.isFormValid, "Form absolutely valid!")
    }

    func testUser_ShouldBeCreated_WhenGivenLoginModel() throws {
        signupModel.userName = "Mikita"
        signupModel.userEmail = "test@test.com"
        signupModel.userPassword = "Test123123"
        signupModel.userRepeatPassword = "Test123123"
        RunLoop.main.run(mode: .default, before: .distantPast) 
        signUpViewModel.createUser(completionBlock: { flag in
            XCTAssertTrue(flag)
        })
    }

    func testUser_ShouldBeSignIn_WhenLogInModelIsNotEmpty() throws {
        loginModel.email = "Qwe@qwe.wee"
        loginModel.password = "123123123"
        loginViewModel.signIn(completionBlock: { error in
            XCTAssertNotNil(error!.localizedDescription)
        })
    }

    func testAuthObserver_ShouldBeNotNil_WhenUserHasLoggedIn() throws {
        rootViewMobel = RootViewModel(authManager: authManagerMock)
        XCTAssertTrue(rootViewMobel.isAuthorized)
    }

    func testUser_ShouldBeSignOuted_WhenMethodCalled() throws {
        loginViewModel.signOut()
        XCTAssertTrue(authManagerMock.signOutFlag)
    }

}
