//
//  FilmCardView.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import SwiftUI

struct FilmCardView: View {
    
    var imageName: String
    var filmTitle: String
    var fileReleaseYear: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .clipped()
            
            HStack {
                VStack(alignment: .leading) {
                    Text(filmTitle)
                        .font(.headline)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .frame(minHeight: 44, alignment: .topLeading)
                    
                    Text(fileReleaseYear)
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
                .fill(Color.black.opacity(0.8))
        )
        .shadow(radius: 5)
    }
}

#Preview {
    FilmCardView(imageName: "poster", filmTitle: "Lilo&Stitsh", fileReleaseYear: "2020")
}
