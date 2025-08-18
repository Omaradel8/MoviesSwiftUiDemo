//
//  HomeView.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import SwiftUI

struct HomeView: View {
    
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
                
            loadingView
            
            Color.black
                .ignoresSafeArea()
            
            ScrollView {
                
                TextField("Search TMDB", text: $viewModel.searchText)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                GenreListView(viewModel: viewModel)
                
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.filteredMovies.indices, id: \.self) { index in
                        let movie = viewModel.filteredMovies[index]
                        FilmCardView(movie: movie)
                            .onTapGesture {
                                self.viewModel.didTapMovie(at: index)
                            }
                            .onAppear {
                                if index == viewModel.filteredMovies.count - 1 {
                                    viewModel.getTrendingMovies()
                                }
                            }
                    }
                }
                .padding(.horizontal)
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
        .showErrorAlert(isPresented: $viewModel.showErrorAlert, errorMessage: viewModel.apiRequestError)
    }
    
    @ViewBuilder
    var loadingView: some View {
        if viewModel.isLoading() {
            ProgressView()
                .scaleEffect(3)
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
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
    
    HomeView(viewModel: HomeViewModel(coordinator: HomeCoordinator(pathBinding: pathBinding), genreUseCase: GenreUseCase(genreRepository: GenreRepository(networkManager: NetworkManager(), genreConfig: GenreConfig())), trendingMoviesUseCase: TrendingMoviesUseCase(trendingMoviesRepository: TrendingMoviesRepository(networkManager: NetworkManager(), trendingMoviesConfig: TrendingMoviesConfig()))))
}
