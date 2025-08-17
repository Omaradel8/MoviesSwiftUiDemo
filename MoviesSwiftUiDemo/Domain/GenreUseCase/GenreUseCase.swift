//
//  GenreUseCase.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 17/08/2025.
//

import Foundation

// MARK: - GenreUseCase Protocol
protocol GenreUseCaseProtocol {
    func getGenres<T: Codable>(with data: Any?) async throws -> T
}

class GenreUseCase: GenreUseCaseProtocol {
    
    private let genreRepository: GenreRepositoryProtocol
    
    init(genreRepository: GenreRepositoryProtocol) {
        self.genreRepository = genreRepository
    }
    
    func getGenres<T>(with data: Any?) async throws -> T where T : Decodable, T : Encodable {
        try await genreRepository.getGenres(with: data)
    }
}
