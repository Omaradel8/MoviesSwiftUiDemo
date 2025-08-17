//
//  HomeViewModel.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import Foundation

// MARK: - typealias
typealias HomeViewModelProtocol = HomeViewModelInput & HomeViewModelOutput

class HomeViewModel: ObservableObject, HomeViewModelProtocol {
    
    // MARK: - Variables
    private let coordiantor: HomeCoordinator
    private let genreUseCase: GenreUseCaseProtocol
    
    // MARK: - Initiliazer
    init(coordiantor: HomeCoordinator, genreUseCase: GenreUseCaseProtocol) {
        self.coordiantor = coordiantor
        self.genreUseCase = genreUseCase
    }
}

// MARK: - HomeViewModel Input
extension HomeViewModel {
    func didTapMovie() {
        coordiantor.navigateToDetailsScreen()
    }
}

// MARK: - HomeViewModel Output
extension HomeViewModel {
    
}
