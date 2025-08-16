//
//  HomeView.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import SwiftUI

struct HomeView: View {
    
    @State private var selectedIndex: Int = 0
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ScrollView {
            GenreListView(selectedIndex: $selectedIndex)
            
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(HomeConstants.films, id: \.0) { title, year, imageName in
                    FilmCardView(imageName: imageName, filmTitle: title, fileReleaseYear: year)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    HomeView()
}
