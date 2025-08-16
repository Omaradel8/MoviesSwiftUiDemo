//
//  MovieHeaderView.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import SwiftUI

struct MovieHeaderView: View {
    
    var imageName: String
    var title: String
    var genres: String
    
    var body: some View {
        HStack(alignment: .top) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(genres)
                    .font(.caption)
                    .foregroundColor(.white)
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    MovieHeaderView(imageName: "poster", title: "Title", genres: "Genres")
}
