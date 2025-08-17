//
//  GenreListView.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import SwiftUI

struct GenreListView: View {
    
    @Binding var selectedIndex: Int
    var genres: [Genre]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(genres.indices, id: \.self) { index in
                    GenreCapsuleView(
                        genreTitle: genres[index].name ?? "",
                        isSelected: selectedIndex == index
                    )
                    .onTapGesture {
                        if selectedIndex != index {
                            selectedIndex = index
                        }
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    GenreListView(selectedIndex: .constant(0), genres: [])
}
