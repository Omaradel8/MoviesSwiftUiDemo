//
//  MovieDetailsCoreDataManager.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 18/08/2025.
//

import CoreData
import UIKit

final class MovieDetailsCoreDataManager {

    // MARK: - Singleton
    static let shared = MovieDetailsCoreDataManager()
    private init() {}

    // MARK: - Persistent Container
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Movies")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: - Save Context
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("❌ Error saving context: \(error)")
            }
        }
    }

    func fetchMovieDetails(by id: Int) -> MovieDetailsModel? {
        let request: NSFetchRequest<MovieDetailsEntity> = MovieDetailsEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        request.fetchLimit = 1

        do {
            guard let entity = try context.fetch(request).first else {
                return nil
            }

            // Build the MovieDetailsModel from the entity
            return MovieDetailsModel(
                adult: entity.adult,
                backdropPath: entity.backdropPath,
                budget: Int(entity.budget),
                genres: nil,
                homepage: entity.homepage,
                id: Int(entity.id),
                imdbID: entity.imdbID,
                originCountry: entity.originCountry as? [String],
                originalLanguage: entity.originalLanguage,
                originalTitle: entity.originalTitle,
                overview: entity.overview,
                popularity: entity.popularity,
                posterPath: entity.posterPath,
                productionCompanies: [],
                productionCountries: [],
                releaseDate: entity.releaseDate,
                revenue: Int(entity.revenue),
                runtime: Int(entity.runtime),
                spokenLanguages: [],
                status: entity.status,
                tagline: entity.tagline,
                title: entity.title,
                video: entity.video,
                voteAverage: entity.voteAverage,
                voteCount: Int(entity.voteCount)
            )

        } catch {
            print("❌ Error fetching movie details by ID: \(error)")
            return nil
        }
    }
}


extension MovieDetailsEntity {
    
    @objc(addGenresObject:)
    @NSManaged public func addToGenres(_ value: MoviesGenre)

    @objc(removeGenresObject:)
    @NSManaged public func removeFromGenres(_ value: MoviesGenre)

    @objc(addGenres:)
    @NSManaged public func addToGenres(_ values: NSSet)

    @objc(removeGenres:)
    @NSManaged public func removeFromGenres(_ values: NSSet)
}
