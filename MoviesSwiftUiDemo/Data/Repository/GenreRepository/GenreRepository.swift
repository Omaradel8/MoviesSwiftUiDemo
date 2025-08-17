//
//  GenreRepository.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 17/08/2025.
//

import Foundation

// MARK: - GenreRepository Protocol
protocol GenreRepositoryProtocol {
    func getGenres<T: Codable>(with data: Any?) async throws -> T
}

// MARK: - GenreRepository
class GenreRepository: GenreRepositoryProtocol {
    
    private let networkManager: NetworkManagerProtocol
    private let genreConfig: APIEndpointConfig
    
    init(networkManager: NetworkManagerProtocol, genreConfig: APIEndpointConfig) {
        self.networkManager = networkManager
        self.genreConfig = genreConfig
    }
    
    func getGenres<T>(with data: Any?) async throws -> T where T : Decodable, T : Encodable {
        try await networkManager.request(request: genreConfig.request)
    }
}
