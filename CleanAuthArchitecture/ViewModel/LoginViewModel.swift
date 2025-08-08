//
//  LoginViewModel.swift
//  CleanFormValidation
//
//  Created by hari krishna on 07/08/2025.
//
import Foundation

@MainActor
class LoginViewModel<LoginForm: LoginFormComposition>: ObservableObject {
    var loginForm: LoginForm
    private let authenticationService: AuthenticationService

    @Published var error: String?
    @Published var isLoading = false
    @Published var loggedInUser: User?
    @Published var alertError: String?

    init(loginForm: LoginForm, authenticationService: AuthenticationService) {
        self.loginForm = loginForm
        self.authenticationService = authenticationService
    }

    func performLogin() async {
        let result = loginForm.validateForm()
        guard result.isValid else {
            error = result.error?.localizedDescription
            return
        }
        
        isLoading = true
        defer { isLoading = false }

        // perform login
        do {
            loggedInUser = try await authenticationService.authenticate(credential: loginForm.makeCredential())
            loginForm.clearForm()
        } catch {
            self.alertError = error.localizedDescription
        }
    }
}
