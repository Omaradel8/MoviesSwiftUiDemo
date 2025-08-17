//
//  HomeView.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import SwiftUI

struct HomeView<HomeViewModel: HomeViewModelProtocol>: View where HomeViewModel: ObservableObject {
    
    @State private var selectedIndex: Int = 0
    @State private var searchText: String = ""
    
    @StateObject var viewModel: HomeViewModel
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var filteredFilms: [(String, String, String)] {
        if searchText.isEmpty {
            return HomeConstants.films
        } else {
            return HomeConstants.films.filter { $0.0.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            ScrollView {
                
                TextField("Search TMDB", text: $searchText)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                GenreListView(selectedIndex: $selectedIndex, genres: viewModel.genres)
                
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(filteredFilms, id: \.0) { title, year, imageName in
                        FilmCardView(imageName: imageName, filmTitle: title, fileReleaseYear: year)
                            .onTapGesture {
                                self.viewModel.didTapMovie()
                            }
                    }
                }
                .padding(.horizontal)
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

#Preview {
    var path = NavigationPath()
    var pathBinding: Binding<NavigationPath> {
        Binding(
            get: { path },
            set: { path = $0}
        )
    }
    
    HomeView(viewModel: HomeViewModel(coordiantor: HomeCoordinator(pathBinding: pathBinding), genreUseCase: GenreUseCase(genreRepository: GenreRepository(networkManager: NetworkManager(), genreConfig: GenreConfig()))))
}
