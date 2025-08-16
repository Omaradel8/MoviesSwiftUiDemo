//
//  GenreListView.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import SwiftUI

struct GenreListView: View {
    
    @Binding var selectedIndex: Int

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(HomeConstants.genres.indices, id: \.self) { index in
                    GenreCapsuleView(
                        genreTitle: HomeConstants.genres[index],
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
    GenreListView(selectedIndex: .constant(0))
}
