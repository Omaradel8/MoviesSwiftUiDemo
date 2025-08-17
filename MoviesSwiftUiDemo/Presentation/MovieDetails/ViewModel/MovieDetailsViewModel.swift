//
//  MovieDetailsViewModel.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 17/08/2025.
//

import Foundation

// MARK: - typealias
typealias MovieDetailsViewModelProtocol = MovieDetailsViewModelInput & MovieDetailsViewModelOutput

class MovieDetailsViewModel: ObservableObject, MovieDetailsViewModelProtocol {
    
    // MARK: - Variables
    private let coordiantor: MovieDetailsCoordinator
    private var movieId: Int?
    private let movieDetailsUseCase: MovieDetailsUseCaseProtocol
    @Published var movieDetails: MovieDetailsModel = emptyMovie
    @Published var showErrorAlert: Bool = false
    var apiRequestError: String = "" {
        didSet {
            showErrorAlert = !apiRequestError.isEmpty
        }
    }
    
    // MARK: - Initiliazer
    init(coordiantor: MovieDetailsCoordinator, movieDetailsUseCase: MovieDetailsUseCaseProtocol) {
        self.coordiantor = coordiantor
        self.movieDetailsUseCase = movieDetailsUseCase
    }
    
    func setupMovieId(movieId: Int) {
        self.movieId = movieId
    }
    
    func getMovieDetails() async {
        Task {
            do {
                let response: MovieDetailsModel = try await movieDetailsUseCase.getMovieDetails(with: movieId)
                await MainActor.run {
                    self.movieDetails = response
                }
            }
            catch let baseError as BaseError {
                self.apiRequestError = baseError.getErrorMessage()
           } catch {
               self.apiRequestError = BaseError(errorCode: ErrorCode.UNKNOWN_ERROR.rawValue).getErrorMessage()
           }
        }
    }
}

// MARK: - MovieDetailsViewModel Input
extension MovieDetailsViewModel {
    func onAppear() {
        Task {
            await getMovieDetails()
        }
    }
}

