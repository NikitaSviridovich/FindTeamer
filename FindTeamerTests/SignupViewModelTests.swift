//
//  SignupViewModelTests.swift
//  SignupViewModelTests
//
//  Created by Nikita Sviridovich on 20.10.22.
//

import XCTest
import Combine
@testable import FindTeamer

class SignupViewModelTests: XCTestCase {
    var signupModel = SignUpModel()
    var signUpViewModel: SignUpViewModel!
    var authManagerMock: AuthManagerMock!

    override func setUpWithError() throws {
        signupModel = SignUpModel()
        authManagerMock = AuthManagerMock()
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
        RunLoop.main.run(mode: .default, before: .distantPast)
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
}
