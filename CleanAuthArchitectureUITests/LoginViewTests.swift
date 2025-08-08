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

    func testLoginViewExists() throws {
        XCTAssertTrue(app.textFields["emailTextField"].exists)
        XCTAssertTrue(app.secureTextFields["passwordTextField"].exists)
        XCTAssertTrue(app.buttons["loginButton"].exists)
    }

}
