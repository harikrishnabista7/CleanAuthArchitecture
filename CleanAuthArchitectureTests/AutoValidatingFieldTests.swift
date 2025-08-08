//
//  AutoValidatingFieldTests.swift
//  CleanAuthArchitectureTests
//
//  Created by hari krishna on 08/08/2025.
//

@testable import CleanAuthArchitecture
import Combine
import XCTest

final class AutoValidatingFieldTests: XCTestCase {
    func testErrorNotNilWhenValidationFailed() {
        let validator = MockEmailValidator(scenario: .empty)
        let field = AutoValidatingField(validator: validator)
        let expectation = XCTestExpectation(description: "Wait for error to emit")

        var cancellables = Set<AnyCancellable>()

        field.$error
            .dropFirst() // ignore the initial nil
            .sink { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        field.text = "" // trigger validation

        wait(for: [expectation], timeout: 1.0)
    }

    func testErrorNilWhenValidationSucceed() {
        let validator = MockEmailValidator(scenario: .valid)
        let field = AutoValidatingField(validator: validator)
        let expectation = XCTestExpectation(description: "Wait for error to emit")

        var cancellables = Set<AnyCancellable>()

        field.$error
            .dropFirst() // ignore the initial nil
            .sink { error in
                XCTAssertNil(error)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        field.text = "abc@email.com" // trigger validation

        wait(for: [expectation], timeout: 1.0)
    }
    
    func testErrorUpdateWhenValidateIsTriggered() {
        let validator = MockEmailValidator(scenario: .valid)
        let field = AutoValidatingField(validator: validator)
        let expectation = XCTestExpectation(description: "Wait for error to emit")

        var cancellables = Set<AnyCancellable>()

        field.$error
            .dropFirst() // ignore the initial nil
            .sink { error in
                expectation.fulfill()
            }
            .store(in: &cancellables)

        _ = field.validate()

        wait(for: [expectation], timeout: 1.0)
    }
    
    func testClearMethodResetsTextAndError() {
        let validator = MockEmailValidator(scenario: .valid)
        let field = AutoValidatingField(validator: validator)
        field.error = MockError(errorMessage: "some error")
        field.text = "some text"
        
        field.clear()
        XCTAssertNil(field.error)
        XCTAssertTrue(field.text.isEmpty)
    }
}
