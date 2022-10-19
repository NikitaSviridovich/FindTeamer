//
//  FindTeamerUITests.swift
//  FindTeamerUITests
//
//  Created by Nikita Sviridovich on 10.08.22.
//

import XCTest

class LogInUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    override func tearDownWithError() throws {
        app.terminate()
    }

    func testWelcomeTest() throws {
        let welcome = app.staticTexts.element(boundBy: 0)
        XCTAssert(welcome.exists)
        XCTAssertEqual(welcome.label, "FindTeamer")
    }

    func testLogInButton() throws {
        let logIn = app.buttons["loginButton"]
        XCTAssert(logIn.exists)
        XCTAssertEqual(logIn.label, "LOG IN")
    }

    func testSignUpButton() throws {
        let signUp = app.buttons["SIGN UP"]
        XCTAssert(signUp.exists)
    }

    func testTapOnLogIn() throws {
        try login(email: "", password: "")
        XCTAssert(app.alerts.element.waitForExistence(timeout: 1.5))
        let alertTitle = app.staticTexts["Sign In Failed"]
        XCTAssertEqual(alertTitle.label, "Sign In Failed")
        app.alerts.element.buttons["OK :("].tap()
        XCTAssertFalse(app.alerts.element.exists)
    }

    func testTapOnSignUp() throws {
        let loginButton = app.buttons["loginButton"]
        let signUp = app.buttons["SIGN UP"]
        XCTAssert(signUp.exists)
        signUp.tap()
        XCTAssertFalse(loginButton.waitForExistence(timeout: 1.0))
    }

    func testLogIn() throws {
        let email = app.textFields["Email"]
        XCTAssert(email.exists)
        let password = app.secureTextFields["Password"]
        XCTAssert(password.exists)

        try login(email: "test", password: "test")

        XCTAssert(app.alerts.element.waitForExistence(timeout: 2.0))

        let alertTitle = app.staticTexts["Sign In Failed"]
        XCTAssertEqual(alertTitle.label, "Sign In Failed")

        app.alerts.element.buttons["OK :("].tap()
        XCTAssertFalse(app.alerts.element.exists)
    }

    func testCorrectLogIn() throws {
        let email = app.textFields["Email"]
        XCTAssert(email.exists)
        let password = app.secureTextFields["Password"]
        XCTAssert(password.exists)
        let loginButton = app.buttons["loginButton"]
        XCTAssert(loginButton.exists)

        try login(email: "Qwe@qwe.wee", password: "123123123")
        XCTAssertFalse(loginButton.waitForExistence(timeout: 3.0)) // ??
    }

    private func login(email: String, password: String) throws {
        app.textFields["Email"].tap()
        app.textFields["Email"].typeText(email)
        XCTAssertNotEqual(app.textFields["Email"].value as! String, "")

        app.secureTextFields["Password"].tap()
        app.secureTextFields["Password"].typeText(password)
        XCTAssertNotEqual(app.secureTextFields["Password"].value as! String, "")

        app.buttons["loginButton"].tap()
    }
}
