//
//  View+Extension.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 17/08/2025.
//

import SwiftUI

extension View {
    func showErrorAlert(isPresented: Binding<Bool>, errorMessage: String, okAction: (() -> Void)? = nil) -> some View {
        alert("Error", isPresented: isPresented) {Button("OK", role: .cancel)
            {
                okAction?()
            }
        } message: {
            Text(errorMessage)
        }
    }
}
