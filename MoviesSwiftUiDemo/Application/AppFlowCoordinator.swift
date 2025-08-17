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
    
    private lazy var homeViewModel: HomeViewModel = {
        HomeDIContainer.shared.getHomeViewModel(with: pathBinding)
    }()
    
    private lazy var movieDetailsViewModel: MovieDetailsViewModel = {
        MovieDetailsDIContainer.shared.getMovieDetailsViewModel(with: pathBinding)
    }()
    
    func buildRootView() -> some View {
        NavigationStack(path: pathBinding) {
            self.homeView()
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .HOME:
                        self.homeView()
                    case .MOVIEDETAILS(let movieId):
                        self.movieDetailsView(movieId: movieId)
                    }
                }
        }
    }
    
    private func homeView() -> some View {
        return HomeView(viewModel: self.homeViewModel)
    }
    
    private func movieDetailsView(movieId: Int) -> some View {
        let viewModel = movieDetailsViewModel
        viewModel.setupMovieId(movieId: movieId)
        return MovieDetailsView(viewModel: viewModel)
    }
    
    func navigate(to route: AppRoute) {
        path.append(route)
    }
    
    func goBack() {
        path.removeLast()
    }
}
