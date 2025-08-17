//
//  MovieDetailsProtocols.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 17/08/2025.
//

import Foundation

// MARK: - MovieDetailsViewModelInput
protocol MovieDetailsViewModelInput {
    func onAppear()
    func isLoading() -> Bool
}

// MARK: - MovieDetailsViewModelOutput
protocol MovieDetailsViewModelOutput {
    var movieDetails: MovieDetailsModel { get }
}
