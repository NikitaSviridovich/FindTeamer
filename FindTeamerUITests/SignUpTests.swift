//
//  SignUpTests.swift
//  FindTeamerUITests
//
//  Created by Nikita Sviridovich on 17.10.22.
//

import XCTest

class SignUpTests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        XCUIDevice.shared.press(.home)
        XCUIApplication().activate()
    }

    func test_ShouldBeSignupButton_WhenOpenLoginView() throws {
        let signUp = app.buttons["SIGN UP"]
        XCTAssert(signUp.exists)
    }

    func test_ShouldBeNameField_WhenUserOpenSignupView() throws {
        let signUp = app.buttons["SIGN UP"]
        signUp.tap()
        let name = app.textFields["Name"]
        XCTAssert(name.exists)
    }

    func test_ShouldBeEmailField_WhenUserOpenSignupView() throws {
        let signUp = app.buttons["SIGN UP"]
        signUp.tap()
        let email = app.textFields["Email"]
        XCTAssert(email.exists)
    }

    func test_ShouldBePasswordField_WhenUserOpenSignupView() throws {
        let signUp = app.buttons["SIGN UP"]
        signUp.tap()
        let password = app.secureTextFields["Password"]
        XCTAssert(password.exists)
    }

    func test_ShouldBeRepeatPasswordField_WhenUserOpenSignupView() throws {
        let signUp = app.buttons["SIGN UP"]
        signUp.tap()
        let repeatPassword = app.secureTextFields["Repeat Password"]
        XCTAssert(repeatPassword.exists)
    }

    func test_ShouldBeLetsGoButton_WhenUserOpenSignupView() throws {
        let signUp = app.buttons["SIGN UP"]
        signUp.tap()
        let letsGoButton = app.buttons["Let's Go!"]
        XCTAssert(letsGoButton.exists)
    }

    func test_ShouldBeAlert_WhenClickOnLetsGoButtonWithEmptyFields() throws {
        let signUp = app.buttons["SIGN UP"]
        signUp.tap()

        let letsGoButton = app.buttons["Let's Go!"]
        letsGoButton.tap()

        XCTAssert(app.alerts.element.waitForExistence(timeout: 1.0))
        let alertTitle = app.staticTexts["Error"]
        XCTAssert(alertTitle.exists)
        app.alerts.element.buttons["OK"].tap()
        XCTAssertFalse(app.alerts.element.exists)
    }
}
