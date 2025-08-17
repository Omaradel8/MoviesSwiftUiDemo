//
//  FilmCardView.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import SwiftUI

struct FilmCardView: View {
    
    var movie: Movie
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: movie.posterFullPath ?? "")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
            } placeholder: {
                ProgressView()
                    .frame(height: 260)
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text(movie.originalTitle ?? "")
                        .font(.headline)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .frame(minHeight: 44, alignment: .topLeading)
                    
                    Text(movie.releaseDate ?? "")
                        .font(.caption)
                }
                .foregroundColor(.white)
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(red: 0.1, green: 0.1, blue: 0.1))
        )
        .shadow(radius: 5)
    }
}

#Preview {
    FilmCardView(movie: Movie(adult: false,
                              backdropPath: "/yRBc6WY3r1Fz5Cjd6DhSvzqunED.jpg",
                              genreIDS: [
                                878,
                                12,
                                28
                            ],
                              id: 1061474,
                              originalLanguage: "en",
                              originalTitle: "Superman",
                              overview: "Superman, a journalist in Metropolis, embarks on a journey to reconcile his Kryptonian heritage with his human upbringing as Clark Kent.",
                              popularity: 911.0931,
                              posterPath: "/ombsmhYUqR4qqOLOxAyr5V8hbyv.jpg",
                              releaseDate: "2025-07-09",
                              title: "Superman",
                              video: false,
                              voteAverage: 7.673,
                              voteCount: 1949))
}
