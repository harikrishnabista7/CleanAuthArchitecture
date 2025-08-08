//
//  EmailValidatorTests.swift
//  CleanAuthArchitectureTests
//
//  Created by hari krishna on 08/08/2025.
//

import XCTest
@testable import CleanAuthArchitecture

final class EmailValidatorTests: XCTestCase {
    func testEmptyEmail() {
        let validator = EmailValidator()
        
        let result = validator.validate("")
        
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.error as? EmailValidator.EmailValidationError, .isRequired)
    }
    
    func testInvalidEmail() {
        let validator = EmailValidator()
        
        let result = validator.validate("invalidemail")
        
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.error as? EmailValidator.EmailValidationError, .invalidFormat)
    }
    
    func testValidEmail() {
        let validator = EmailValidator()
        
        let result = validator.validate("valid@email.com")
        
        XCTAssertTrue(result.isValid)
        XCTAssertNil(result.error)
    }
}
