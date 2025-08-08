//
//  PasswordValidator.swift
//  CleanAuthArchitecture
//
//  Created by hari krishna on 08/08/2025.
//

import Foundation

struct PasswordValidator: Validator {
    // Regex patterns for validation
    private struct RegexPatterns {
        static let minLength = ".{8,}"
        static let maxLength = "^.{0,64}$"
        static let hasUppercase = ".*[A-Z].*"
        static let hasLowercase = ".*[a-z].*"
        static let hasDigit = ".*[0-9].*"
        static let noWhitespace = "^[^\\s]*$"
        static let hasSpecialChar = ".*[!@#$%^&*()_+\\-=\\[\\]{}|;:,.<>?].*"
    }

    enum PassordValidationError: LocalizedError {
        case tooShort
        case tooLong
        case noUppercase
        case noLowercase
        case noDigit
        case noSpecialCharacter
        case containsWhitespace
        case custom(String)

        var errorDescription: String? {
            switch self {
            case .tooShort:
                return "must be at least 8 characters long"
            case .tooLong:
                return "must not exceed 64 characters"
            case .noUppercase:
                return "must contain at least one uppercase letter (A-Z)"
            case .noLowercase:
                return "must contain at least one lowercase letter (a-z)"
            case .noDigit:
                return "must contain at least one digit (0-9)"
            case .noSpecialCharacter:
                return "must contain at least one special character (!@#$%^&*()_+-=[]{}|;:,.<>?)"
            case .containsWhitespace:
                return "must not contain whitespace characters"
            case let .custom(desc):
                return desc
            }
        }
    }

    func validate(_ value: String) -> ValidationResult {
        var errors: [PassordValidationError] = []

        if !matches(value, pattern: RegexPatterns.minLength) {
            errors.append(.tooShort)
        }

        // Check maximum length
        if !matches(value, pattern: RegexPatterns.maxLength) {
            errors.append(.tooLong)
        }

        // Check for uppercase letter
        if !matches(value, pattern: RegexPatterns.hasUppercase) {
            errors.append(.noUppercase)
        }

        // Check for lowercase letter
        if !matches(value, pattern: RegexPatterns.hasLowercase) {
            errors.append(.noLowercase)
        }

        // Check for digit
        if !matches(value, pattern: RegexPatterns.hasDigit) {
            errors.append(.noDigit)
        }

        // Check for special character
        if !matches(value, pattern: RegexPatterns.hasSpecialChar) {
            errors.append(.noSpecialCharacter)
        }

        // Check for whitespace
        if !matches(value, pattern: RegexPatterns.noWhitespace) {
            errors.append(.containsWhitespace)
        }

        let errorMessage = "Password " + errors.map { $0.localizedDescription }.joined(separator: ", ")
        let finalError = errors.isEmpty ? nil : PassordValidationError.custom(errorMessage)
        return .init(isValid: errors.isEmpty, error: finalError)
    }

    private func matches(_ string: String, pattern: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let range = NSRange(location: 0, length: string.utf16.count)
            return regex.firstMatch(in: string, options: [], range: range) != nil
        } catch {
            print("Regex error: \(error)")
            return false
        }
    }
}
