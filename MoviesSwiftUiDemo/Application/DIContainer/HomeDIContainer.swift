//
//  HomeDIContainer.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import SwiftUI

class HomeDIContainer {
    static let shared = HomeDIContainer()
    private init() {}
    
    func getHomeViewModel(with pathBinding: Binding<NavigationPath>) -> HomeViewModel {
        HomeViewModel(coordiantor: getHomeCoordinator(with: pathBinding), genreUseCase: getGenreUseCase())
    }
    
    private func getHomeCoordinator(with pathBinding: Binding<NavigationPath>) -> HomeCoordinator {
        HomeCoordinator(pathBinding: pathBinding)
    }
    
    private func getGenreUseCase() -> GenreUseCaseProtocol {
        return GenreUseCase(genreRepository: getGenreRepository())
    }
    
    private func getGenreRepository() -> GenreRepositoryProtocol {
        return GenreRepository(networkManager: getNetworkManger(), genreConfig: getGenreApiConfig())
    }
    
    private func getNetworkManger() -> NetworkManagerProtocol {
        return NetworkManager()
    }
    
    private func getGenreApiConfig() -> APIEndpointConfig {
        return GenreConfig()
    }
}
