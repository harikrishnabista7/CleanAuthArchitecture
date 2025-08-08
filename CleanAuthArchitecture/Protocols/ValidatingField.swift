//
//  ValidatingField.swift
//  CleanFormValidation
//
//  Created by hari krishna on 08/08/2025.
//

import Foundation

protocol ValidatingField: ObservableObject {
    var text: String { get set }
    var error: Error? { get }

    func validate() -> Bool
    func clear()
}
