//
//  CoreDataManager.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 18/08/2025.
//

import CoreData
import UIKit

import CoreData

final class GenreCoreDataManager {
    
    // MARK: - Fetch All Saved Genres
    func fetchAllGenres(context: NSManagedObjectContext) -> [MoviesGenre] {
        let fetchRequest: NSFetchRequest<MoviesGenre> = MoviesGenre.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch genres: \(error)")
            return []
        }
    }
    
    // MARK: - Save Genres If Not Already Stored
    func saveGenresIfNeeded(from genreModel: GenreModel, context: NSManagedObjectContext) {
        guard let genres = genreModel.genres else { return }

        // Get existing genre IDs
        let existingGenres = fetchAllGenres(context: context)
        let existingIDs = Set(existingGenres.compactMap { $0.id?.intValue })

        for genre in genres {
            guard let id = genre.id, let name = genre.name else { continue }

            // Skip if genre already exists
            if existingIDs.contains(id) { continue }

            // Create new MoviesGenre entity
            let newGenre = MoviesGenre(context: context)
            newGenre.id = NSDecimalNumber(value: id)
            newGenre.name = name
        }

        // Save context
        do {
            try context.save()
            print("Genres saved successfully.")
        } catch {
            print("Failed to save genres: \(error)")
        }
    }
}
