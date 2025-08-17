//
//  MovieHeaderView.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import SwiftUI

struct MovieHeaderView: View {
    
    @ObservedObject var viewModel: MovieDetailsViewModel
    
    var body: some View {
        HStack(alignment: .top) {
            
            AsyncImage(url: URL(string: viewModel.movieDetails.posterFullPath ?? "")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            } placeholder: {
                ProgressView()
                    .frame(width: 100, height: 100)
            }
            
            VStack(alignment: .leading) {
                Text(viewModel.movieDetails.originalTitle ?? "")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(viewModel.movieDetails.allGenres ?? "")
                    .font(.caption)
                    .foregroundColor(.white)
            }
            
            Spacer()
        }
        .padding()
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
    
    MovieHeaderView(viewModel: MovieDetailsViewModel(coordiantor: MovieDetailsCoordinator(pathBinding: pathBinding), movieDetailsUseCase: MovieDetailsUseCase(movieDetailsRepository: MovieDetailsRepository(networkManager: NetworkManager(), movieDetailsConfig: MovieDetailsConfig()))))
}
