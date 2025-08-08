//
//  LoginFormComposition.swift
//  CleanFormValidation
//
//  Created by hari krishna on 08/08/2025.
//

import Foundation

protocol LoginFormComposition {
    associatedtype Field: ValidatingField
    var emailField: Field { get set }
    var passwordField: Field { get set }

    func validateForm() -> ValidationResult
    func makeCredential() -> LoginCredential
    func clearForm()
}
