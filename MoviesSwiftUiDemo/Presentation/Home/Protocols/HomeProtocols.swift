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
}

// MARK: - HomeViewModelOutput
protocol HomeViewModelOutput {
    var genres: [Genre] { get }
}
