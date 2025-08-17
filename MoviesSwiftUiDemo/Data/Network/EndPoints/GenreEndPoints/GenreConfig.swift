//
//  GenreConfig.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 17/08/2025.
//

import Foundation

class GenreConfig: APIEndpointConfig {
    
    // MARK: - Request
    var request: APIRequest {
        return APIRequestBuilder(url: URL(string: EndPointsURLs.getGenres()), method: .GET)
            .build()
    }
}
