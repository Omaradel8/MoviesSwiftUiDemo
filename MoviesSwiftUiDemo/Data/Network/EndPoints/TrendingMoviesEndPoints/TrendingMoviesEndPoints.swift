//
//  TrendingMoviesEndPoints.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 17/08/2025.
//

import Foundation

class TrendingMoviesConfig: APIEndpointConfig {
    
    private var page: Int?
    
    // MARK: - Request
    var request: APIRequest {
        return APIRequestBuilder(url: URL(string: EndPointsURLs.getGenres()), method: .GET)
            .setParameters(["page": page ?? 1], encoding: .url)
            .build()
    }
    
    // MARK: - Public Methods
    func updateRequestData(with data: Any?) {
        guard let data = data as? Int else {return}
        self.page = data
    }
}
