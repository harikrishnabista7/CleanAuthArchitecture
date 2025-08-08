//
//  LoginFormTests.swift
//  CleanAuthArchitectureTests
//
//  Created by hari krishna on 08/08/2025.
//

@testable import CleanAuthArchitecture
import XCTest

final class LoginFormTests: XCTestCase {
    func testEmailError() {
        let form = LoginForm(emailValidator: MockEmailValidator(scenario: .empty), passwordValidator: MockPasswordValidator(scenario: .empty))
        let result = form.validateForm()
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.error?.localizedDescription, MockError(errorMessage: "Email is required").errorDescription)
    }
    
    func testPasswordError() {
        let form = LoginForm(emailValidator: MockEmailValidator(scenario: .valid), passwordValidator: MockPasswordValidator(scenario: .empty))
        let result = form.validateForm()
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.error?.localizedDescription, MockError(errorMessage: "Password is required").errorDescription)
    }
    
}
