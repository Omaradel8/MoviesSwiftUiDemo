//
//  MoviesEntity.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 18/08/2025.
//

import Foundation
import CoreData

@objc(MoviesEntity)
public class MoviesEntity: NSManagedObject {}

extension MoviesEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MoviesEntity> {
        return NSFetchRequest<MoviesEntity>(entityName: "Movies")
    }

    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var overview: String?
    @NSManaged public var originalTitle: String?
    @NSManaged public var originalLanguage: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var backdropPath: String?
    @NSManaged public var adult: Bool
    @NSManaged public var video: Bool
    @NSManaged public var voteAverage: Double
    @NSManaged public var voteCount: Int32
    @NSManaged public var popularity: Double
    @NSManaged public var genreIDS: [Int]? // Transformable
}
