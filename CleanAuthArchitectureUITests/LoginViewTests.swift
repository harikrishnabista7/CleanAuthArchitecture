//
//  LoginViewTests.swift
//  CleanAuthArchitectureUITests
//
//  Created by hari krishna on 08/08/2025.
//

import XCTest

final class LoginViewTests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testLoginViewExists() {
        XCTAssertTrue(app.textFields["emailTextField"].exists)
        XCTAssertTrue(app.secureTextFields["passwordTextField"].exists)
        XCTAssertTrue(app.buttons["loginButton"].exists)
    }

    func testLoginViewEmailErrorShownWhenTypingBeginInitially() {
        let expectation = XCTestExpectation(description: "Wait for error to show below email field")

        XCTAssertFalse(app.staticTexts["Email is required"].exists)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.app.staticTexts["Email is required"].exists)
            expectation.fulfill()
        }
        app.textFields["emailTextField"].tap()

        wait(for: [expectation], timeout: 2)
    }

    func testLoginViewPasswordErrorShownWhenTypingBeginInitially() {
        let expectation = XCTestExpectation(description: "Wait for error to show below password field")

        let emailfield = app.textFields["emailTextField"]
        emailfield.tap()
        emailfield.typeText("test@test.com")

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.app.staticTexts.beginningWithText("Password must be").exists)
            expectation.fulfill()
        }
        app.secureTextFields["passwordTextField"].tap()

        wait(for: [expectation], timeout: 2)
    }

    func testLoginViewErrorShownWhenEmailHasInvalidFormat() {
        let expectation = XCTestExpectation(description: "Wait for error to show below email field")

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.app.staticTexts["Invalid email format"].exists)
            expectation.fulfill()
        }
        let field = app.textFields["emailTextField"]
        field.tap()
        field.typeText("acasd")

        wait(for: [expectation], timeout: 2.0)
    }

    func testLoginViewShowErrorWhenLoginButtonTap() {
        let expectation = XCTestExpectation(description: "Wait for error to show below email field and password field")

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.app.staticTexts["Email is required"].exists)
            XCTAssertTrue(self.app.staticTexts.beginningWithText("Password must be").exists)
            expectation.fulfill()
        }

        app.buttons["loginButton"].tap()

        wait(for: [expectation], timeout: 2)
    }
    
    func testLoginViewLoginSuccess() {
        let expectation = XCTestExpectation(description: "Wait for error to show below email field and password field")
        
        let emailField = app.textFields["emailTextField"]
        let passwordField = app.secureTextFields["passwordTextField"]
        
        emailField.tap()
        emailField.typeText("test@email.com")
        
        passwordField.tap()
        passwordField.typeText("Clean@Auth123")

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            XCTAssertTrue(self.app.staticTexts["Login Successful"].exists)
            expectation.fulfill()
        }

        app.buttons["loginButton"].tap()

        wait(for: [expectation], timeout: 4)
    }
}


extension XCUIElementQuery {
    func containingText(_ text: String) -> XCUIElement {
        return containing(NSPredicate(format: "label CONTAINS %@", text)).firstMatch
    }
    
    func beginningWithText(_ text: String) -> XCUIElement {
        return containing(NSPredicate(format: "label BEGINSWITH %@", text)).firstMatch
    }
}
