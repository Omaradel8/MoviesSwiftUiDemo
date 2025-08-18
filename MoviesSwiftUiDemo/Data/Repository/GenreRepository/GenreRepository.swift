//
//  GenreRepository.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 17/08/2025.
//

import Foundation
import CoreData

// MARK: - GenreRepository Protocol
protocol GenreRepositoryProtocol {
    func getGenres<T: Codable>(with data: Any?) async throws -> T
    func saveGenresIfNeeded(_ model: GenreModel, context: NSManagedObjectContext)
    func fetchLocalGenres(context: NSManagedObjectContext) -> [MoviesGenre]
}

// MARK: - GenreRepository
class GenreRepository: GenreRepositoryProtocol {
    
    private let networkManager: NetworkManagerProtocol
    private let genreConfig: APIEndpointConfig
    private let genreCoreDataManager: GenreCoreDataManager
    
    init(networkManager: NetworkManagerProtocol, genreConfig: APIEndpointConfig, genreCoreDataManager: GenreCoreDataManager = GenreCoreDataManager()) {
        self.networkManager = networkManager
        self.genreConfig = genreConfig
        self.genreCoreDataManager = genreCoreDataManager
    }
    
    func getGenres<T>(with data: Any?) async throws -> T where T : Decodable, T : Encodable {
        try await networkManager.request(request: genreConfig.request)
    }
    
    func saveGenresIfNeeded(_ model: GenreModel, context: NSManagedObjectContext) {
        genreCoreDataManager.saveGenresIfNeeded(from: model, context: context)
    }
    
    func fetchLocalGenres(context: NSManagedObjectContext) -> [MoviesGenre] {
        genreCoreDataManager.fetchAllGenres(context: context)
    }
}
