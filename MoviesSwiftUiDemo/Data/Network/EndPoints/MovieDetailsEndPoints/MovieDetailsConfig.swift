//
//  MovieDetailsConfig.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 17/08/2025.
//

import Foundation

class MovieDetailsConfig: APIEndpointConfig {
    
    private var movieId: Int?
    
    // MARK: - Request
    var request: APIRequest {
        return APIRequestBuilder(url: URL(string: EndPointsURLs.getMovieDetails(movieId: movieId ?? 0)), method: .GET)
            .build()
    }
    
    // MARK: - Public Methods
    func updateRequestData(with data: Any?) {
        guard let data = data as? Int else {return}
        self.movieId = data
    }
}
