//
//  HomeCoordinator.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import Foundation

class HomeCoordinator: Coordinator {
    func navigateToDetailsScreen() {
        navigate(to: .MOVIEDETAILS)
    }
}
