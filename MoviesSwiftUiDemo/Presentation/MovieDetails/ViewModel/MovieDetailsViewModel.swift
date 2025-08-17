//
//  MovieDetailsViewModel.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 17/08/2025.
//

import Foundation

// MARK: - typealias
typealias MovieDetailsViewModelProtocol = MovieDetailsViewModelInput & MovieDetailsViewModelOutput

class MovieDetailsViewModel: ObservableObject, MovieDetailsViewModelProtocol {
    
    // MARK: - Variables
    private let coordiantor: MovieDetailsCoordinator
    private var movieId: Int?
    private let movieDetailsUseCase: MovieDetailsUseCaseProtocol
    
    // MARK: - Initiliazer
    init(coordiantor: MovieDetailsCoordinator, movieDetailsUseCase: MovieDetailsUseCaseProtocol) {
        self.coordiantor = coordiantor
        self.movieDetailsUseCase = movieDetailsUseCase
    }
    
    func setupMovieId(movieId: Int) {
        self.movieId = movieId
    }
}

// MARK: - MovieDetailsViewModel Input
extension MovieDetailsViewModel {
    
}

