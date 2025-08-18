//
//  TrendingMoviesUseCase.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 17/08/2025.
//

import Foundation
import CoreData

// MARK: - TrendingMoviesUseCase Protocol
protocol TrendingMoviesUseCaseProtocol {
    func getTrendingMovies<T: Codable>(with data: Any?) async throws -> T
    func saveMoviesIfNeeded(_ model: [Movie], context: NSManagedObjectContext)
    func fetchLocalMovies(context: NSManagedObjectContext) -> [Movie]
}

class TrendingMoviesUseCase: TrendingMoviesUseCaseProtocol {
    
    private let trendingMoviesRepository: TrendingMoviesRepositoryProtocol
    
    init(trendingMoviesRepository: TrendingMoviesRepositoryProtocol) {
        self.trendingMoviesRepository = trendingMoviesRepository
    }
    
    func getTrendingMovies<T>(with data: Any?) async throws -> T where T : Decodable, T : Encodable {
        try await trendingMoviesRepository.getTrendingMovies(with: data)
    }
    
    func saveMoviesIfNeeded(_ model: [Movie], context: NSManagedObjectContext) {
        trendingMoviesRepository.saveMoviesIfNeeded(model, context: context)
    }
    
    func fetchLocalMovies(context: NSManagedObjectContext) -> [Movie] {
        trendingMoviesRepository.fetchLocalMovies(context: context)
    }
}
