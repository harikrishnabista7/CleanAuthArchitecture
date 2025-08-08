//
//  MockField.swift
//  CleanAuthArchitecture
//
//  Created by hari krishna on 08/08/2025.
//
@testable import CleanAuthArchitecture

class MockField: ValidatingField {
    var text: String = ""

    var error: (any Error)?

    let validator: Validator

    init(validator: Validator) {
        self.validator = validator
    }

    func validate() -> Bool {
        let result = validator.validate(text)
        error = result.error
        return validator.validate(text).isValid
    }

    func clear() {
        text = ""
    }
}
