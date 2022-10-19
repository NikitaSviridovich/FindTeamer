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

    override func tearDownWithError() throws { }

    func testSignUpButton() throws {
        let signUp = app.buttons["SIGN UP"]
        XCTAssert(signUp.exists)
    }

    func testSignUpView() throws {
        let signUp = app.buttons["SIGN UP"]
        signUp.tap()

        let registrationText = app.staticTexts.element(boundBy: 0)
        XCTAssert(registrationText.exists)
        XCTAssertEqual(registrationText.label, "Registration")

        let name = app.textFields["Name"]
        XCTAssert(name.exists)
        let email = app.secureTextFields["Email"]
        XCTAssert(email.exists)
        let password = app.secureTextFields["Password"]
        XCTAssert(password.exists)
        let repeatPassword = app.secureTextFields["Repeat Password"]
        XCTAssert(repeatPassword.exists)
        let letsGoButton = app.buttons["Let's Go!"]
        XCTAssert(letsGoButton.exists)
    }

    func testSignUpViewValidation() throws {
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
