//
//  MovieDetailsDIContainer.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 17/08/2025.
//

import SwiftUI

class MovieDetailsDIContainer {
    static let shared = MovieDetailsDIContainer()
    private init() {}
    
    func getMovieDetailsViewModel(with pathBinding: Binding<NavigationPath>) -> MovieDetailsViewModel {
        MovieDetailsViewModel(coordiantor: getMovieDetailsCoordinator(with: pathBinding))
    }
    
    private func getMovieDetailsCoordinator(with pathBinding: Binding<NavigationPath>) -> MovieDetailsCoordinator {
        MovieDetailsCoordinator(pathBinding: pathBinding)
    }
    
}
