//
//  MovieDetailsUseCase.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 17/08/2025.
//

import Foundation
import CoreData

// MARK: - MovieDetailsUseCase Protocol
protocol MovieDetailsUseCaseProtocol {
    func getMovieDetails<T: Codable>(with data: Any?) async throws -> T
    func saveMovieDetailsIfNeeded(_ model: MovieDetailsModel)
}

class MovieDetailsUseCase: MovieDetailsUseCaseProtocol {
    
    private let movieDetailsRepository: MovieDetailsRepositoryProtocol
    
    init(movieDetailsRepository: MovieDetailsRepositoryProtocol) {
        self.movieDetailsRepository = movieDetailsRepository
    }
    
    func getMovieDetails<T>(with data: Any?) async throws -> T where T : Decodable, T : Encodable {
        try await movieDetailsRepository.getMovieDetails(with: data)
    }
    
    func saveMovieDetailsIfNeeded(_ model: MovieDetailsModel) {
        movieDetailsRepository.saveMovieDetailsIfNeeded(model)
    }
}
