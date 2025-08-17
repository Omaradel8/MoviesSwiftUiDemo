//
//  MovieDetailsDIContainer.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 17/08/2025.
//

import SwiftUI

class MovieDetailsDIContainer {
    static let shared = MovieDetailsDIContainer()
    private init() {}
    
    func getMovieDetailsViewModel(with pathBinding: Binding<NavigationPath>) -> MovieDetailsViewModel {
        MovieDetailsViewModel(coordiantor: getMovieDetailsCoordinator(with: pathBinding), movieDetailsUseCase: getMovieDetailsUseCase())
    }
    
    private func getMovieDetailsCoordinator(with pathBinding: Binding<NavigationPath>) -> MovieDetailsCoordinator {
        MovieDetailsCoordinator(pathBinding: pathBinding)
    }
    
    private func getMovieDetailsUseCase() -> MovieDetailsUseCaseProtocol {
        return MovieDetailsUseCase(movieDetailsRepository: getMovieDetailsRepository())
    }
    
    private func getMovieDetailsRepository() -> MovieDetailsRepositoryProtocol {
        return MovieDetailsRepository(networkManager: getNetworkManger(), movieDetailsConfig: getMovieDetailsApiConfig())
    }
    
    private func getNetworkManger() -> NetworkManagerProtocol {
        return NetworkManager()
    }
    
    private func getMovieDetailsApiConfig() -> APIEndpointConfig {
        return MovieDetailsConfig()
    }
}
