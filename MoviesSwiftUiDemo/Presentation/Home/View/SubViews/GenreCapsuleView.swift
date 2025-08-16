//
//  GenreCapsuleView.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import SwiftUI

struct GenreCapsuleView: View {
    
    var genreTitle: String
    var isSelected: Bool
    
    var body: some View {
        Text(genreTitle)
            .padding(.horizontal, 12)
            .padding(.vertical, 5)
            .background (
                capsuleBackground
            )
    }
    
    @ViewBuilder
    var capsuleBackground: some View {
        if isSelected {
            Capsule().fill(Color.yellow)
        } else {
            Capsule().stroke(Color.yellow, lineWidth: 1.5)
        }
    }

}


#Preview {
    GenreCapsuleView(genreTitle: "Genre", isSelected: false)
}
