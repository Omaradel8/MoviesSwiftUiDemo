//
//  HomeDIContainer.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import SwiftUI

class HomeDIContainer {
    static let shared = HomeDIContainer()
    private init() {}
    
    func getHomeViewModel(with pathBinding: Binding<NavigationPath>) -> HomeViewModel {
        HomeViewModel(coordiantor: getHomeCoordinator(with: pathBinding))
    }
    
    private func getHomeCoordinator(with pathBinding: Binding<NavigationPath>) -> HomeCoordinator {
        HomeCoordinator(pathBinding: pathBinding)
    }

}
