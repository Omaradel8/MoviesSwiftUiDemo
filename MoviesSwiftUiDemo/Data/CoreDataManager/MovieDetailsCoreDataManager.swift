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
    
    func saveMovieDetails(_ model: MovieDetailsModel) {
        // Check if movie already exists to avoid duplicates
        let request: NSFetchRequest<MovieDetailsEntity> = MovieDetailsEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", model.id ?? 0)

        do {
            let results = try context.fetch(request)
            let movieEntity = results.first ?? MovieDetailsEntity(context: context)

            // Set properties
            movieEntity.id = Int64(model.id ?? 0)
            movieEntity.title = model.title
            movieEntity.adult = model.adult ?? false
            movieEntity.backdropPath = model.backdropPath
            movieEntity.budget = Int64(model.budget ?? 0)
            movieEntity.homepage = model.homepage
            movieEntity.imdbID = model.imdbID
            movieEntity.originCountry = model.originCountry as NSArray?
            movieEntity.originalLanguage = model.originalLanguage
            movieEntity.originalTitle = model.originalTitle
            movieEntity.overview = model.overview
            movieEntity.popularity = model.popularity ?? 0
            movieEntity.posterPath = model.posterPath
            movieEntity.releaseDate = model.releaseDate
            movieEntity.revenue = Int64(model.revenue ?? 0)
            movieEntity.runtime = Int64(model.runtime ?? 0)
            movieEntity.status = model.status
            movieEntity.tagline = model.tagline
            movieEntity.video = model.video ?? false
            movieEntity.voteAverage = model.voteAverage ?? 0
            movieEntity.voteCount = Int64(model.voteCount ?? 0)

            // MARK: - Save Genres
            if let genres = model.genres {
                for genre in genres {
                    let fetchGenreRequest: NSFetchRequest<MoviesGenre> = MoviesGenre.fetchRequest()
                    fetchGenreRequest.predicate = NSPredicate(format: "id == %d", genre.id ?? 0)

                    let existingGenres = try context.fetch(fetchGenreRequest)
                    let genreEntity = existingGenres.first ?? MoviesGenre(context: context)
                    genreEntity.name = genre.name

                    movieEntity.addToGenres(genreEntity)
                }
            }
            
            movieEntity.spokenLanguage = model.spokenLanguages?.compactMap({$0.englishName}) as? NSArray

            print("✅ Saved \(movieEntity.title ?? "") movie.")
            // Save to Core Data
            saveContext()

        } catch {
            print("❌ Error saving movie details: \(error)")
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

            let spokenLanguages: [SpokenLanguage] = (entity.spokenLanguage as? [String])?.map { code in
                SpokenLanguage(englishName: code, iso639_1: nil, name: nil)
            } ?? []
            
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
                spokenLanguages: spokenLanguages,
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
