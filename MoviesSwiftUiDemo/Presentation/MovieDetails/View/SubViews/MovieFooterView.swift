//
//  MovieFooterView.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import SwiftUI

struct MovieFooterView: View {
    
    @ObservedObject var viewModel: MovieDetailsViewModel
    
    var body: some View {
        HStack(spacing: 4) {
            Text("Home page:")
                .foregroundColor(.white)
                .font(.footnote)
            
            if let homepage = viewModel.movieDetails.homepage,
               let url = URL(string: homepage) {
                Link(homepage, destination: url)
                    .foregroundColor(.blue)
                    .font(.footnote)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        
        HStack(spacing: 4) {
            Text("Languages:")
            
            Text(viewModel.movieDetails.allSpokenLanguages ?? "")
            
            Spacer()
        }
        .font(.footnote)
        .foregroundColor(.white)
        .padding(.horizontal)
        
        HStack {
            HStack(spacing: 4) {
                Text("Status:")
                
                Text(viewModel.movieDetails.releaseDate ?? "")
                
                Spacer()
            }
            .font(.footnote)
            .foregroundColor(.white)
            .padding(.horizontal)
            
            Spacer()
            
            HStack(spacing: 4) {
                Text("Runtime:")
                
                Text("\(viewModel.movieDetails.runtime ?? 0) minutes")
                
                Spacer()
            }
            .font(.footnote)
            .foregroundColor(.white)
            .padding(.horizontal)
        }
        
        HStack {
            HStack(spacing: 4) {
                Text("Budget:")
                
                Text("\(viewModel.movieDetails.budget ?? 0) $")
                
                Spacer()
            }
            .font(.footnote)
            .foregroundColor(.white)
            .padding(.horizontal)
            
            Spacer()
            
            HStack(spacing: 4) {
                Text("Revenue:")
                
                Text("\(viewModel.movieDetails.revenue ?? 0) $")
                
                Spacer()
            }
            .font(.footnote)
            .foregroundColor(.white)
            .padding(.horizontal)
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
    
    MovieFooterView(viewModel: MovieDetailsViewModel(coordiantor: MovieDetailsCoordinator(pathBinding: pathBinding), movieDetailsUseCase: MovieDetailsUseCase(movieDetailsRepository: MovieDetailsRepository(networkManager: NetworkManager(), movieDetailsConfig: MovieDetailsConfig()))))
}
