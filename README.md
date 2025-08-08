# CleanAuthArchitecture

A clean, scalable login form architecture in Swift using **MVVM**, **Combine**, and **async/await**.  
This project demonstrates best practices for handling user authentication, form validation, and reactive UI logic in a testable and maintainable way.

---

## 🚀 Features

- ✅ MVVM architecture with protocol-oriented design
- ✅ `Combine`-based field validation (live feedback as user types)
- ✅ `async/await`-based login flow with error handling
- ✅ Clean separation of concerns (validation, form state, business logic)
- ✅ Easily extendable to Signup, Reset Password, etc.
- ✅ Fully testable and dependency-injected services

---

## 🧱 Architecture Overview

```swift
LoginViewModel
├── LoginFormComposition (Protocol)
│   └── LoginForm (Implements validation + fields)
│       └── AutoValidatingField (Reactive input with Combine)
├── AuthenticationService (Protocol)
│   └── Mock or Real Login Service

