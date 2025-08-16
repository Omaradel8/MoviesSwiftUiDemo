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
            
            Text("\"Lilo & Stitch\" is a Disney movie about a lonely Hawaiian girl named Lilo who adopts a mischievous alien creature she names Stitch, unaware that he's a genetically engineered experiment designed for destruction. The film explores their unlikely friendship as they navigate Lilo's struggles with her older sister and Stitch's attempts to evade capture by intergalactic authorities. Ultimately, the movie emphasizes the importance of family and belonging through the Hawaiian concept of 'ohana'.")
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(.horizontal)
            
        }
        .background(Color.black)
        .ignoresSafeArea()
    }
}

#Preview {
    MovieDetailsView()
}
