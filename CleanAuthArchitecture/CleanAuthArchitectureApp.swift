//
//  CleanAuthArchitectureApp.swift
//  CleanAuthArchitecture
//
//  Created by hari krishna on 08/08/2025.
//

import SwiftUI

@main
struct CleanAuthArchitectureApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView(loginForm: LoginForm(emailValidator: EmailValidator(), passwordValidator: PasswordValidator()), authService: UserService())
        }
    }
}
