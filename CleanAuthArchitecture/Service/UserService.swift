//
//  UserService.swift
//  CleanAuthArchitecture
//
//  Created by hari krishna on 08/08/2025.
//

import Foundation

struct UserService: AuthenticationService {
    func authenticate(credential: LoginCredential) async throws -> any User {
        try? await Task.sleep(for: .seconds(2))
        return APIUser(id: "123", email: credential.email)
    }
}

