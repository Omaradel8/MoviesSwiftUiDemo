//
//  TrendingMoviesRepository.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 17/08/2025.
//

import Foundation

// MARK: - TrendingMoviesRepository Protocol
protocol TrendingMoviesRepositoryProtocol {
    func getTrendingMovies<T: Codable>(with data: Any?) async throws -> T
}

// MARK: - TrendingMoviesRepository
class TrendingMoviesRepository: TrendingMoviesRepositoryProtocol {
    
    private let networkManager: NetworkManagerProtocol
    private let trendingMoviesConfig: APIEndpointConfig
    
    init(networkManager: NetworkManagerProtocol, trendingMoviesConfig: APIEndpointConfig) {
        self.networkManager = networkManager
        self.trendingMoviesConfig = trendingMoviesConfig
    }
    
    func getTrendingMovies<T>(with data: Any?) async throws -> T where T : Decodable, T : Encodable {
        try await networkManager.request(request: trendingMoviesConfig.request)
    }
}
