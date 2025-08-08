//
//  PasswordValidatorTests.swift
//  CleanAuthArchitectureTests
//
//  Created by hari krishna on 08/08/2025.
//

@testable import CleanAuthArchitecture
import XCTest

final class PasswordValidatorTests: XCTestCase {
    func testPasswordValidatorMinLengthErrorWhenEmpty() {
        let validator = PasswordValidator()

        let result = validator.validate("")
        let errorMessage = PasswordValidator.PassordValidationError.tooShort.localizedDescription
        XCTAssertNotNil(result.error)
        XCTAssertTrue(result.error!.localizedDescription.contains(errorMessage))
        XCTAssertFalse(result.isValid)
    }

    func testPasswordValidatorMinLengthErrorWhenLessThanEightDigit() {
        let validator = PasswordValidator()

        let result = validator.validate("Ab@1")
        let errorMessage = PasswordValidator.PassordValidationError.tooShort.localizedDescription
        XCTAssertNotNil(result.error)
        XCTAssertTrue(result.error!.localizedDescription.contains(errorMessage))
        XCTAssertFalse(result.isValid)
    }

    func testPasswordValidatorMaxLengthError() {
        let validator = PasswordValidator()

        let result = validator.validate(Array(0 ... 65).map(String.init).joined())
        let errorMessage = PasswordValidator.PassordValidationError.tooLong.localizedDescription
        XCTAssertNotNil(result.error)
        XCTAssertTrue(result.error!.localizedDescription.contains(errorMessage))
        XCTAssertFalse(result.isValid)
    }
    
    func testPasswordValidatorErrorWhenSpaceInPassword() {
        let validator = PasswordValidator()
        
        let result = validator.validate("Clean@Aut h_1234")
        let errorMessage = PasswordValidator.PassordValidationError.containsWhitespace.localizedDescription
        XCTAssertNotNil(result.error)
        XCTAssertTrue(result.error!.localizedDescription.contains(errorMessage))
        XCTAssertFalse(result.isValid)
    }
    
    func testPasswordValidatorErrorWhenNoUpperCase() {
        let validator = PasswordValidator()
        
        let result = validator.validate("clean@auth_1234")
        let errorMessage = PasswordValidator.PassordValidationError.noUppercase.localizedDescription
        XCTAssertNotNil(result.error)
        XCTAssertTrue(result.error!.localizedDescription.contains(errorMessage))
        XCTAssertFalse(result.isValid)
    }
    
    func testPasswordValidatorErrorWhenNoLowerCase() {
        let validator = PasswordValidator()
        
        let result = validator.validate("CLEAN@AUTH_1234")
        let errorMessage = PasswordValidator.PassordValidationError.noLowercase.localizedDescription
        XCTAssertNotNil(result.error)
        XCTAssertTrue(result.error!.localizedDescription.contains(errorMessage))
        XCTAssertFalse(result.isValid)
    }
    
    func testPasswordValidatorErrorWhenNoDigit() {
        let validator = PasswordValidator()
        
        let result = validator.validate("Clean@Auth_")
        let errorMessage = PasswordValidator.PassordValidationError.noDigit.localizedDescription
        XCTAssertNotNil(result.error)
        XCTAssertTrue(result.error!.localizedDescription.contains(errorMessage))
        XCTAssertFalse(result.isValid)
    }
    
    func testPasswordValidatorErrorWhenNoSpecialCharacter() {
        let validator = PasswordValidator()
        
        let result = validator.validate("CleanAuth1234")
        let errorMessage = PasswordValidator.PassordValidationError.noSpecialCharacter.localizedDescription
        XCTAssertNotNil(result.error)
        XCTAssertTrue(result.error!.localizedDescription.contains(errorMessage))
        XCTAssertFalse(result.isValid)
    }
    
    func testPasswordValidatorSucceed() {
        let validator = PasswordValidator()
        
        let result = validator.validate("Clean@Auth_1234")
        XCTAssertNil(result.error)
        XCTAssertTrue(result.isValid)
    }
}
