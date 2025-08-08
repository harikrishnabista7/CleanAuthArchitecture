//
//  MockAuthenticationService.swift
//  CleanAuthArchitectureTests
//
//  Created by hari krishna on 08/08/2025.
//

@testable import CleanAuthArchitecture

struct MockAuthenticationService: AuthenticationService {
    enum AuthenticationError: Error {
        case invalidCredentials
    }

    let returnError: Bool
    let returningUser: MockUser

    init(returnError: Bool = false, returningUser: MockUser) {
        self.returnError = returnError
        self.returningUser = returningUser
    }

    func authenticate(credential: LoginCredential) async throws -> User {
        try await Task.sleep(for: .seconds(1))
        if returnError {
            throw MockError(errorMessage: "Invalid credentials")
        }
        return returningUser
    }
}
