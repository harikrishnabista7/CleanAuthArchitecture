//
//  ContentView.swift
//  CleanAuthArchitecture
//
//  Created by hari krishna on 08/08/2025.
//

import SwiftUI

struct LoginView<LoginForm: LoginFormComposition>: View {
    @StateObject var viewModel: LoginViewModel<LoginForm>

    init(loginForm: LoginForm, authService: AuthenticationService) {
        _viewModel = StateObject(wrappedValue: LoginViewModel(loginForm: loginForm, authenticationService: authService))
    }

    // MARK: - Error Binding

    var binding: Binding<Bool> {
        Binding {
            viewModel.error != nil
        } set: { _ in
            viewModel.error = nil
        }
    }

    // MARK: - Body

    var body: some View {
        VStack(spacing: 15) {
            if viewModel.loggedInUser != nil {
                Text("Login Successful")
            }
            emailfield

            passwordField

            loginButton
        }
        .padding()
        .frame(height: 300)
        .background(Color.secondary.opacity(0.2))
        .cornerRadius(20)
        .padding()
        .alert("Error", isPresented: binding) {
            Button("OK") {}
        } message: {
            if let error = viewModel.error {
                Text(error)
            }
        }
        .disabled(viewModel.isLoading)
    }

    // MARK: - EmailField

    var emailfield: some View {
        ValidatedInputField(content: {
            TextField("Email", text: $viewModel.loginForm.emailField.text)
                .accessibilityIdentifier("emailTextField")
                .textFieldStyle(.roundedBorder)
        }, field: viewModel.loginForm.emailField)
    }

    // MARK: - PasswordField

    var passwordField: some View {
        ValidatedInputField(content: {
            SecureField("Password", text: $viewModel.loginForm.passwordField.text)
                .accessibilityIdentifier("passwordTextField")
                .textFieldStyle(.roundedBorder)
        }, field: viewModel.loginForm.passwordField)
    }

    // MARK: - Login Button

    var loginButton: some View {
        Button {
            Task {
                viewModel.loggedInUser = nil // just to reset here in this project to test again and again
                await viewModel.performLogin()
            }
        } label: {
            if viewModel.isLoading {
                ProgressView()
                    .colorScheme(.dark)

            } else {
                Text("Login")
                    .bold()
                    .font(.title2)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
            }
        }
        .frame(width: 180, height: 50)
        .foregroundStyle(.white)
        .background(Color.blue)
        .cornerRadius(10)
        .padding(.top)
        .accessibilityIdentifier("loginButton")
    }
}

#Preview {
    let form = LoginForm(emailValidator: EmailValidator(), passwordValidator: PasswordValidator())
    LoginView(loginForm: form, authService: UserService())
}
