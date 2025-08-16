//
//  HomeViewModel.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import Foundation

// MARK: - typealias
typealias HomeViewModelProtocol = HomeViewModelInput & HomeViewModelOutput

class HomeViewModel: ObservableObject, HomeViewModelProtocol {
    
    // MARK: - Variables
    private let coordiantor: HomeCoordinator
    
    // MARK: - Initiliazer
    init(coordiantor: HomeCoordinator) {
        self.coordiantor = coordiantor
    }
}

// MARK: - HomeViewModel Input
extension HomeViewModel {
    
}

// MARK: - HomeViewModel Output
extension HomeViewModel {
    
}
