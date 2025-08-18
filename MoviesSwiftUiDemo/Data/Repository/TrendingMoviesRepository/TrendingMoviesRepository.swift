//
//  TrendingMoviesRepository.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 17/08/2025.
//

import Foundation
import CoreData

// MARK: - TrendingMoviesRepository Protocol
protocol TrendingMoviesRepositoryProtocol {
    func getTrendingMovies<T: Codable>(with data: Any?) async throws -> T
    func saveMoviesIfNeeded(_ model: [Movie], context: NSManagedObjectContext)
    func fetchLocalMovies(context: NSManagedObjectContext) -> [Movie]
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
        trendingMoviesConfig.updateRequestData(with: data)
        return try await networkManager.request(request: trendingMoviesConfig.request)
    }
    
    func saveMoviesIfNeeded(_ model: [Movie], context: NSManagedObjectContext) {
        CoreDataMovieManager.shared.saveMovies(model)
    }
    
    func fetchLocalMovies(context: NSManagedObjectContext) -> [Movie] {
        CoreDataMovieManager.shared.fetchAllMovies()
    }
}
