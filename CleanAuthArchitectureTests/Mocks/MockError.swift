//
//  MockError.swift
//  CleanAuthArchitecture
//
//  Created by hari krishna on 08/08/2025.
//
import Foundation

struct MockError: LocalizedError {
    let errormessage: String

    init(errorMessage: String) {
        errormessage = errorMessage
    }

    var errorDescription: String? {
        return errormessage
    }
}
