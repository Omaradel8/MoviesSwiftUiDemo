//
//  HomeViewModel.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import Foundation
import Combine

// MARK: - typealias
typealias HomeViewModelProtocol = HomeViewModelInput & HomeViewModelOutput & ObservableObject

class HomeViewModel: HomeViewModelProtocol {
    
    // MARK: - Variables
    private let coordiantor: HomeCoordinator
    private let genreUseCase: GenreUseCaseProtocol
    private let trendingMoviesUseCase: TrendingMoviesUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    @Published private(set) var genres: [Genre] = []
    @Published private(set) var trendingMovies: [Movie] = [] {
        didSet{
            self.filterMovies()
        }
    }
    @Published private(set) var filteredMovies: [Movie] = []
    @Published var selectedIndex: Int = 0 {
        didSet {
            guard !trendingMovies.isEmpty else { return }
            self.filterMovies()
        }
    }
    @Published var searchText: String = "" {
        didSet{
            self.filterMovies()
        }
    }
    private var currentPage = 1
    private var totalPages: Int?
    
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
                self?.getTrendingMovies()
            }
        )
        .store(in: &cancellables)
    }
    
    func getTrendingMovies() {
        Future<TrendingMoviesModel, Error> { promise in
            Task {
                do {
                    let response: TrendingMoviesModel = try await self.trendingMoviesUseCase.getTrendingMovies(with: nil)
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
                self?.trendingMovies.append(contentsOf: response.movies ?? [])
                self?.currentPage += 1
                self?.totalPages = 1
            }
        )
        .store(in: &cancellables)
    }

    private func filterMoviesDueGenre() -> [Movie] {
        return self.trendingMovies.filter({ $0.genreIDS?.contains(genres[selectedIndex].id ?? 0) ?? false })
    }
    
    private func filterMovies() {
        let filteredMoviesDueGenre = self.filterMoviesDueGenre()
        if self.searchText.isEmpty {
            self.filteredMovies = filteredMoviesDueGenre
        }else{
            self.filteredMovies = filteredMoviesDueGenre.filter( { $0.originalTitle?.lowercased().contains(searchText.lowercased()) ?? false } )
        }
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
