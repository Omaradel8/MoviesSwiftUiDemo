//
//  GenreUseCase.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 17/08/2025.
//

import Foundation
import CoreData

// MARK: - GenreUseCase Protocol
protocol GenreUseCaseProtocol {
    func getGenres<T: Codable>(with data: Any?) async throws -> T
    func saveGenresIfNeeded(_ model: GenreModel, context: NSManagedObjectContext)
    func fetchLocalGenres(context: NSManagedObjectContext) -> [MoviesGenre]
}

class GenreUseCase: GenreUseCaseProtocol {
    
    private let genreRepository: GenreRepositoryProtocol
    
    init(genreRepository: GenreRepositoryProtocol) {
        self.genreRepository = genreRepository
    }
    
    func getGenres<T>(with data: Any?) async throws -> T where T : Decodable, T : Encodable {
        try await genreRepository.getGenres(with: data)
    }
    
    func saveGenresIfNeeded(_ model: GenreModel, context: NSManagedObjectContext) {
        genreRepository.saveGenresIfNeeded(model, context: context)
    }
    
    func fetchLocalGenres(context: NSManagedObjectContext) -> [MoviesGenre] {
        genreRepository.fetchLocalGenres(context: context)
    }
}
