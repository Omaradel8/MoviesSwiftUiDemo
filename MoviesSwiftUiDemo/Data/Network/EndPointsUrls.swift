//
//  EndPointsUrls.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 17/08/2025.
//

import Foundation

struct EndPointsURLs {
    static let baseUrl = "https://api.themoviedb.org/3/"
    static let APIKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNTEzYjliYjc1YTBiM2QxYTU5MWRhNjdlMmJjODc1MCIsIm5iZiI6MTc1NTM1NjQ2MC40MTUsInN1YiI6IjY4YTA5ZDJjZmU3NWNlNjg4MTBiZmE3MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.dkGqW0VJtoAvZWfJ9Px4_RWXwxqny8IMTg1GA8YW4KY"
    static func getGenres() -> String {
        EndPointsURLs.baseUrl + "genre/movie/list?language=en"
    }
    static func getTrendingMovies() -> String {
        EndPointsURLs.baseUrl + "discover/movie"
    }
}
