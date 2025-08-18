//
//  HomeViewModel.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import Foundation
import Combine
import CoreData

// MARK: - typealias
typealias HomeViewModelProtocol = HomeViewModelInput & HomeViewModelOutput & ObservableObject

class HomeViewModel: HomeViewModelProtocol {
    
    // MARK: - Variables
    private let coordinator: HomeCoordinator
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
    @Published private var isLoadingPage = false
    private var lastRequestedPage: Int?
    private var nextPage = 1
    private var totalPages: Int?
    private let context: NSManagedObjectContext = PersistenceController.shared.context
    private var hasLoadedData = false

    // MARK: - Initiliazer
    init(coordinator: HomeCoordinator, genreUseCase: GenreUseCaseProtocol, trendingMoviesUseCase: TrendingMoviesUseCaseProtocol) {
        self.coordinator = coordinator
        self.genreUseCase = genreUseCase
        self.trendingMoviesUseCase = trendingMoviesUseCase
    }
    
    func getGenre() async {
        if NetworkMonitor.shared.isConnected {
            Task { [weak self] in
                guard let self = self else { return }
                do {
                    let response: GenreModel = try await genreUseCase.getGenres(with: nil)
                    genreUseCase.saveGenresIfNeeded(response, context: context)
                    await MainActor.run {
                        self.genres = response.genres ?? []
                    }
                    self.getTrendingMovies()
                }
                catch let baseError as BaseError {
                    print(baseError.getErrorMessage())
               } catch {
                   print(BaseError(errorCode: ErrorCode.UNKNOWN_ERROR.rawValue).getErrorMessage())
               }
            }
        }else{
            let localGenres = genreUseCase.fetchLocalGenres(context: context)
            
            let mappedGenres: [Genre] = localGenres.compactMap {
                guard let id = $0.id?.intValue, let name = $0.name else { return nil }
                return Genre(id: id, name: name)
            }
            
            await MainActor.run {
                self.genres = mappedGenres
            }
            getTrendingMovies()
        }
    }

    
    func getTrendingMovies() {
        if NetworkMonitor.shared.isConnected {
            Task { [weak self] in
                guard let self = self else { return }
                guard !isLoadingPage else { return }
                guard nextPage <= (totalPages ?? 1) else { return }
                guard lastRequestedPage != nextPage else { return }
                
                self.lastRequestedPage = nextPage
                
                await MainActor.run {
                    self.isLoadingPage = true
                }
                
                defer {
                    Task { @MainActor in
                        self.isLoadingPage = false
                    }
                }
                
                do {
                    let response: TrendingMoviesModel = try await trendingMoviesUseCase.getTrendingMovies(with: nextPage)
                    trendingMoviesUseCase.saveMoviesIfNeeded(response.movies ?? [], context: context)
                    
                    await MainActor.run {
                        self.trendingMovies.append(contentsOf: response.movies ?? [])
                        self.nextPage += 1
                        self.totalPages = response.totalPages
                        self.hasLoadedData = true
                    }
                }
                catch let baseError as BaseError {
                    print(baseError.getErrorMessage())
               } catch {
                   print(BaseError(errorCode: ErrorCode.UNKNOWN_ERROR.rawValue).getErrorMessage())
               }
            }
        }else{
            let localMovies = trendingMoviesUseCase.fetchLocalMovies(context: context)
            DispatchQueue.main.async {
                self.trendingMovies.append(contentsOf: localMovies)
            }
        }
    }

    private func filterMoviesBySelectedGenre() -> [Movie] {
        return self.trendingMovies.filter({ $0.genreIDS?.contains(genres[selectedIndex].id ?? 0) ?? false })
    }
    
    private func filterMovies() {
        let filteredMoviesDueGenre = self.filterMoviesBySelectedGenre()
        if self.searchText.isEmpty {
            self.filteredMovies = filteredMoviesDueGenre
        }else{
            self.filteredMovies = filteredMoviesDueGenre.filter( { $0.originalTitle?.lowercased().contains(searchText.lowercased()) ?? false } )
        }
        
        maybeFetchNextPageIfNeeded()
    }
    
    private func maybeFetchNextPageIfNeeded() {
        if filteredMovies.count <= 4  {
            getTrendingMovies()
        }
    }
}

// MARK: - HomeViewModel Input
extension HomeViewModel {
    func didTapMovie(at index: Int) {
        guard index < self.filteredMovies.count, let id = self.filteredMovies[index].id else { return }
        coordinator.navigateToDetailsScreen(movieId: id)
    }
    
    func onAppear() {
        guard !hasLoadedData else { return }

        Task {
            await getGenre()
        }
    }
    
    func setSelectedGenre(at index: Int) {
        self.selectedIndex = index
    }
}

// MARK: - HomeViewModel Output
extension HomeViewModel {
}
