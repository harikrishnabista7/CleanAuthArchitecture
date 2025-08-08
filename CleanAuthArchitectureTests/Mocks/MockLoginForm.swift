//
//  MockLoginForm.swift
//  CleanAuthArchitecture
//
//  Created by hari krishna on 08/08/2025.
//

@testable import CleanAuthArchitecture

struct MockLoginForm<Field: ValidatingField>: LoginFormComposition {
    var emailField: Field

    var passwordField: Field

    func validateForm() -> ValidationResult {
        let isValid = [emailField, passwordField].allSatisfy { $0.validate() }

        let error = emailField.error ?? passwordField.error

        return .init(isValid: isValid, error: error)
    }

    func makeCredential() -> CleanAuthArchitecture.LoginCredential {
        .init(email: emailField.text, password: emailField.text)
    }

    func clearForm() {
        emailField.clear()
        passwordField.clear()
    }
}
