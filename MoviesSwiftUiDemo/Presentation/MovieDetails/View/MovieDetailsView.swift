//
//  MovieDetailsView.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import SwiftUI

struct MovieDetailsView: View {
    
    
    var body: some View {
        ScrollView {
            // TOP POSTER
            Image("poster")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .frame(height: 350)
            
            // MOVIE HEADER VIEW
            MovieHeaderView(imageName: "poster", title: "Movie Name", genres: "Genres")
            
            
        }
        .background(Color.black)
        .ignoresSafeArea()
    }
}

#Preview {
    MovieDetailsView()
}
