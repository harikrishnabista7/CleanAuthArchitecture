//
//  MockEmailValidator.swift
//  CleanAuthArchitecture
//
//  Created by hari krishna on 08/08/2025.
//

@testable import CleanAuthArchitecture
import Foundation

struct MockEmailValidator: Validator {
    enum MockEmailValidationCase {
        case valid
        case empty
        case invalidFormat
    }

    let scenario: MockEmailValidationCase

    init(scenario: MockEmailValidationCase) {
        self.scenario = scenario
    }

    func validate(_ value: String) -> ValidationResult {
        switch scenario {
        case .valid:
            return .init(isValid: true, error: nil)
        case .empty:
            return .init(isValid: false, error: MockError(errorMessage: "Email is required"))
        case .invalidFormat:
            return .init(isValid: false, error: MockError(errorMessage: "Invalid email format"))
        }
    }
}
