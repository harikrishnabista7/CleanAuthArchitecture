//
//  LoginViewModelTests.swift
//  CleanAuthArchitectureTests
//
//  Created by hari krishna on 08/08/2025.
//

@testable import CleanAuthArchitecture
import XCTest

final class LoginViewModelTests: XCTestCase {
    @MainActor
    func testLoginFailsWithEmptyEmail() async {
        let emailField = MockField(validator: MockEmailValidator(scenario: .empty))
        let passwordField = MockField(validator: MockPasswordValidator(scenario: .empty))

        let form = MockLoginForm(emailField: emailField, passwordField: passwordField)
        let authService = MockAuthenticationService(returnError: false, returningUser: .init(id: "123", email: emailField.text))

        let viewModel = LoginViewModel(loginForm: form, authenticationService: authService)

        await viewModel.performLogin()

        XCTAssertTrue(viewModel.error == MockError(errorMessage: "Email is required").localizedDescription)
    }

    @MainActor
    func testLoginFailsWithInvalidEmail() async {
        let emailField = MockField(validator: MockEmailValidator(scenario: .invalidFormat))
        let passwordField = MockField(validator: MockPasswordValidator(scenario: .empty))

        let form = MockLoginForm(emailField: emailField, passwordField: passwordField)
        let authService = MockAuthenticationService(returnError: false, returningUser: .init(id: "123", email: emailField.text))

        let viewModel = LoginViewModel(loginForm: form, authenticationService: authService)

        await viewModel.performLogin()

        XCTAssertTrue(viewModel.error == MockError(errorMessage: "Invalid email format").localizedDescription)
    }

    @MainActor
    func testLoginFailsWithEmptyPassword() async {
        let emailField = MockField(validator: MockEmailValidator(scenario: .valid))
        let passwordField = MockField(validator: MockPasswordValidator(scenario: .empty))

        let form = MockLoginForm(emailField: emailField, passwordField: passwordField)
        let authService = MockAuthenticationService(returnError: false, returningUser: .init(id: "123", email: emailField.text))

        let viewModel = LoginViewModel(loginForm: form, authenticationService: authService)

        await viewModel.performLogin()

        XCTAssertTrue(viewModel.error == MockError(errorMessage: "Password is required").localizedDescription)
    }
    
    @MainActor
    func testLoginFailsWithInvalidFormatPassword() async {
        let emailField = MockField(validator: MockEmailValidator(scenario: .valid))
        let passwordField = MockField(validator: MockPasswordValidator(scenario: .invalidFormat))

        let form = MockLoginForm(emailField: emailField, passwordField: passwordField)
        let authService = MockAuthenticationService(returnError: false, returningUser: .init(id: "123", email: emailField.text))

        let viewModel = LoginViewModel(loginForm: form, authenticationService: authService)

        await viewModel.performLogin()

        XCTAssertTrue(viewModel.error == MockError(errorMessage: "Invalid password format").localizedDescription)
    }

    @MainActor
    func testLoginFailsWithInvalidCredentials() async {
        let emailField = MockField(validator: MockEmailValidator(scenario: .valid))
        let passwordField = MockField(validator: MockPasswordValidator(scenario: .valid))

        let form = MockLoginForm(emailField: emailField, passwordField: passwordField)
        let authService = MockAuthenticationService(returnError: true, returningUser: .init(id: "123", email: emailField.text))

        let viewModel = LoginViewModel(loginForm: form, authenticationService: authService)

        await viewModel.performLogin()
 
        XCTAssertTrue(viewModel.alertError == MockError(errorMessage: "Invalid credentials").localizedDescription)
    }

    @MainActor
    func testLoginSucceeds() async {
        let emailField = MockField(validator: MockEmailValidator(scenario: .valid))
        let passwordField = MockField(validator: MockPasswordValidator(scenario: .valid))

        let form = MockLoginForm(emailField: emailField, passwordField: passwordField)
        let authService = MockAuthenticationService(returnError: false, returningUser: .init(id: "123", email: emailField.text))

        let viewModel = LoginViewModel(loginForm: form, authenticationService: authService)

        await viewModel.performLogin()

        XCTAssertNil(viewModel.alertError)
        XCTAssertNil(viewModel.error)
        XCTAssertTrue(viewModel.loggedInUser?.id == "123")
    }
}
