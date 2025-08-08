//
//  EmailValidator.swift
//  CleanFormValidation
//
//  Created by hari krishna on 07/08/2025.
//


import Foundation

struct EmailValidator: Validator {
    enum EmailValidationError: LocalizedError {
        case invalidFormat
        case isRequired

        var errorDescription: String? {
            switch self {
            case .invalidFormat:
                return "Invalid email format"
            case .isRequired:
                return "Email is required"
            }
        }
    }


    func validate(_ value: String) -> ValidationResult {
        if value.isEmpty {
            return .init(isValid: false, error: EmailValidationError.isRequired)
        }

        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let isValid = emailPredicate.evaluate(with: value)

        return isValid ? .init(isValid: true, error: nil) : .init(isValid: false, error: EmailValidationError.invalidFormat)
    }
}
