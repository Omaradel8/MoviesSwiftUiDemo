//
//  MovieDetailsView.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import SwiftUI

struct MovieDetailsView: View {
    
    @StateObject var viewModel: MovieDetailsViewModel
    
    var body: some View {
        ZStack {
            
            loadingView
            
            ScrollView {
                // TOP POSTER
                
                AsyncImage(url: URL(string: viewModel.movieDetails.backdropFullPath ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .frame(height: 350)
                } placeholder: {
                    ProgressView()
                        .frame(height: 350)
                }
                
                // MOVIE HEADER VIEW
                MovieHeaderView(viewModel: viewModel)
                
                // DESCRIPTION
                Text(viewModel.movieDetails.overview ?? "")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                Spacer(minLength: 100)
                
                // FOOTER SECTION
                MovieFooterView(viewModel: viewModel)
                
                Spacer(minLength: 50)
            }
            .background(Color.black)
            .ignoresSafeArea()
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
    
    MovieDetailsView(viewModel: MovieDetailsViewModel(coordiantor: MovieDetailsCoordinator(pathBinding: pathBinding), movieDetailsUseCase: MovieDetailsUseCase(movieDetailsRepository: MovieDetailsRepository(networkManager: NetworkManager(), movieDetailsConfig: MovieDetailsConfig()))))
}
