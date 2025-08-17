//
//  GenreListView.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import SwiftUI

struct GenreListView<HomeViewModel: HomeViewModelProtocol>: View where HomeViewModel: ObservableObject {
    
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(viewModel.genres.indices, id: \.self) { index in
                    GenreCapsuleView(
                        genreTitle: viewModel.genres[index].name ?? "",
                        isSelected: viewModel.selectedIndex == index
                    )
                    .onTapGesture {
                        if viewModel.selectedIndex != index {
                            viewModel.setSelectedGenre(at: index)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

//#Preview {
//    GenreListView(selectedIndex: .constant(0), genres: [])
//}
