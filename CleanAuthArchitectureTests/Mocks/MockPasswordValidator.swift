//
//  MockPasswordValidator.swift
//  CleanAuthArchitectureTests
//
//  Created by hari krishna on 08/08/2025.
//

import Foundation
@testable import CleanAuthArchitecture

struct MockPasswordValidator: Validator {
    enum MockPasswordValidationCase {
        case valid
        case empty
        case invalidFormat
    }
    
    let scenario: MockPasswordValidationCase
    
    func validate(_ value: String) -> ValidationResult {
        switch scenario {
        case .valid:
            return .init(isValid: true, error: nil)
        case .empty:
            return .init(isValid: false, error: MockError(errorMessage: "Password is required"))
        case .invalidFormat:
            return .init(isValid: false, error: MockError(errorMessage: "Invalid password format"))
        }
    }
}
