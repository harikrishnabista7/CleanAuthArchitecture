//
//  AutoValidatingField.swift
//  CleanFormValidation
//
//  Created by hari krishna on 08/08/2025.
//
import Foundation
import Combine

class AutoValidatingField: ValidatingField {
    @Published var text: String = ""
    @Published var error: Error?

    private let validator: Validator
    private var cancellables = Set<AnyCancellable>()

    init(validator: Validator) {
        self.validator = validator
        observeTextChange()
    }

    func clear() {
        cancellables.removeAll()
        text = ""
        error = nil
        observeTextChange()
    }

    private func observeTextChange() {
        $text
            .dropFirst()
            .map { self.validator.validate($0.trimmed) }
            .receive(on: RunLoop.main)
            .sink { [weak self] result in
                self?.error = result.isValid ? nil : result.error
            }
            .store(in: &cancellables)
    }

    func validate() -> Bool {
        let result = validator.validate(text)
        error = result.isValid ? nil : result.error
        return result.isValid
    }
}
