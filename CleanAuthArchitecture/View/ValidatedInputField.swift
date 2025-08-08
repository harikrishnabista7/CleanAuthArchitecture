//
//  ValidatedInputField.swift
//  CleanAuthArchitecture
//
//  Created by hari krishna on 08/08/2025.
//

import SwiftUI

struct ValidatedInputField<Content: View, Field: ValidatingField>: View {
    @ViewBuilder var content: () -> Content
    @ObservedObject var field: Field
    @State private var errorMessage: String?

    var body: some View {
        VStack(alignment: .leading) {
            content()
            if let errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .animation(.easeInOut)
                    .padding(.leading, 2)
            }
        }
        .onChange(of: field.error?.localizedDescription) { _, _ in
            withAnimation {
                errorMessage = field.error?.localizedDescription
            }
        }
    }
}
