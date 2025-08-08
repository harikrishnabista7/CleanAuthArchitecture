//
//  LoginForm.swift
//  CleanFormValidation
//
//  Created by hari krishna on 08/08/2025.
//

struct LoginForm: LoginFormComposition {
    typealias Field = AutoValidatingField

    var emailField: Field
    var passwordField: Field

    private(set) var error: Error?

    init(emailValidator: Validator, passwordValidator: Validator) {
        emailField = AutoValidatingField(validator: emailValidator)
        passwordField = AutoValidatingField(validator: passwordValidator)
    }

    func makeCredential() -> LoginCredential {
        return .init(email: emailField.text.trimmed, password: passwordField.text.trimmed)
    }

    func validateForm() -> ValidationResult {
        let emailValid = emailField.validate()
        let passwordValid = passwordField.validate()
        
        let isValid = emailValid && passwordValid

        let error = emailField.error ?? passwordField.error

        return .init(isValid: isValid, error: error)
    }

    func clearForm() {
        emailField.clear()
        passwordField.clear()
    }
}
