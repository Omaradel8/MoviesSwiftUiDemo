//
//  MoviesCoreDataManager.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 18/08/2025.
//

import Foundation
import CoreData

final class CoreDataMovieManager {
    
    static let shared = CoreDataMovieManager()
    private let context = PersistenceController.shared.container.viewContext

    private init() {}

    // MARK: - Save Movie if Not Exists
    func saveMovies(_ movies: [Movie]) {
        let movieIDs = movies.compactMap { $0.id }

        // Fetch all existing movies with matching IDs
        let fetchRequest: NSFetchRequest<MoviesEntity> = MoviesEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id IN %@", movieIDs)

        do {
            let existingMovies = try context.fetch(fetchRequest)
            let existingIDs = Set(existingMovies.map { Int($0.id) })

            // Filter out movies that already exist
            let newMovies = movies.filter { movie in
                guard let id = movie.id else { return false }
                return !existingIDs.contains(id)
            }

            for movie in newMovies {
                let newMovie = MoviesEntity(context: context)
                newMovie.id = Int32(movie.id ?? 0)
                newMovie.title = movie.title
                newMovie.overview = movie.overview
                newMovie.originalTitle = movie.originalTitle
                newMovie.originalLanguage = movie.originalLanguage
                newMovie.releaseDate = movie.releaseDate
                newMovie.posterPath = movie.posterPath
                newMovie.backdropPath = movie.backdropPath
                newMovie.adult = movie.adult ?? false
                newMovie.video = movie.video ?? false
                newMovie.voteAverage = movie.voteAverage ?? 0
                newMovie.voteCount = Int32(movie.voteCount ?? 0)
                newMovie.popularity = movie.popularity ?? 0
                newMovie.genreIDS = movie.genreIDS
            }

            if context.hasChanges {
                try context.save()
                print("✅ Saved \(newMovies.count) new movies.")
            } else {
                print("ℹ️ No new movies to save.")
            }
        } catch {
            print("❌ Failed to save movies: \(error)")
        }
    }

    // MARK: - Fetch All Movies
    func fetchAllMovies() -> [MoviesEntity] {
        let fetchRequest: NSFetchRequest<MoviesEntity> = MoviesEntity.fetchRequest()

        do {
            let movies = try context.fetch(fetchRequest)
            return movies
        } catch {
            print("❌ Failed to fetch movies: \(error)")
            return []
        }
    }
}
