//
//  MovieDetailsRepository.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 17/08/2025.
//

import Foundation

// MARK: - MovieDetailsRepository Protocol
protocol MovieDetailsRepositoryProtocol {
    func getMovieDetails<T: Codable>(with data: Any?) async throws -> T
}

// MARK: - MovieDetailsRepository
class MovieDetailsRepository: MovieDetailsRepositoryProtocol {
    
    private let networkManager: NetworkManagerProtocol
    private let movieDetailsConfig: APIEndpointConfig
    
    init(networkManager: NetworkManagerProtocol, movieDetailsConfig: APIEndpointConfig) {
        self.networkManager = networkManager
        self.movieDetailsConfig = movieDetailsConfig
    }
    
    func getMovieDetails<T>(with data: Any?) async throws -> T where T : Decodable, T : Encodable {
        movieDetailsConfig.updateRequestData(with: data)
        return try await networkManager.request(request: movieDetailsConfig.request)
    }
}
