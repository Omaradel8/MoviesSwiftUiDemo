//
//  HomeProtocols.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import Foundation

// MARK: - HomeViewModelInput
protocol HomeViewModelInput {
    func didTapMovie()
    func onAppear()
    func setSelectedGenre(at index: Int)
}

// MARK: - HomeViewModelOutput
protocol HomeViewModelOutput {
    var genres: [Genre] { get }
    var selectedIndex: Int { get set }
    var filteredMovies: [Movie] { get }
    var searchText: String { get set }
}
