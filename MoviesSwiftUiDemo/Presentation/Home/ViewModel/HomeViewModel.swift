//
//  HomeViewModel.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import Foundation
import Combine

// MARK: - typealias
typealias HomeViewModelProtocol = HomeViewModelInput & HomeViewModelOutput

class HomeViewModel: ObservableObject, HomeViewModelProtocol {
    
    // MARK: - Variables
    private let coordiantor: HomeCoordinator
    private let genreUseCase: GenreUseCaseProtocol
    private let trendingMoviesUseCase: TrendingMoviesUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    @Published private(set) var genres: [Genre] = []
    @Published var selectedIndex: Int = 0
    
    // MARK: - Initiliazer
    init(coordiantor: HomeCoordinator, genreUseCase: GenreUseCaseProtocol, trendingMoviesUseCase: TrendingMoviesUseCaseProtocol) {
        self.coordiantor = coordiantor
        self.genreUseCase = genreUseCase
        self.trendingMoviesUseCase = trendingMoviesUseCase
    }
    
    func getGenre() {
        Future<GenreModel, Error> { promise in
            Task {
                do {
                    let response: GenreModel = try await self.genreUseCase.getGenres(with: nil)
                    promise(.success(response))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    if let baseError = error as? BaseError {
                        print(baseError.getErrorMessage())
                    } else {
                        print(BaseError(errorCode: ErrorCode.UNKNOWN_ERROR.rawValue).getErrorMessage())
                    }
                case .finished:
                    break
                }
            },
            receiveValue: { [weak self] response in
                self?.genres = response.genres ?? []
            }
        )
        .store(in: &cancellables)
    }
}

// MARK: - HomeViewModel Input
extension HomeViewModel {
    func didTapMovie() {
        coordiantor.navigateToDetailsScreen()
    }
    
    func onAppear() {
        getGenre()
    }
    
    func setSelectedGenre(at index: Int) {
        self.selectedIndex = index
    }
}

// MARK: - HomeViewModel Output
extension HomeViewModel {
}
