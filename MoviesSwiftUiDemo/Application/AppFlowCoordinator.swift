//
//  AppFlowCoordinator.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import Foundation
import SwiftUI

class AppFlowCoordinator: ObservableObject {
    
    @Published var path = NavigationPath()
    
    private var pathBinding: Binding<NavigationPath> {
        Binding(
            get: { self.path },
            set: { self.path = $0 }
        )
    }
    
    func buildRootView() -> some View {
        NavigationStack(path: pathBinding) {
            self.homeView()
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .HOME:
                        self.homeView()
                    case .MOVIEDETAILS:
                        self.movieDetailsView()
                    }
                }
        }
    }
    
    private func homeView() -> some View {
        return HomeView()
    }
    
    private func movieDetailsView() -> some View {
        return MovieDetailsView()
    }
    
    func navigate(to route: AppRoute) {
        path.append(route)
    }
    
    func goBack() {
        path.removeLast()
    }
}
