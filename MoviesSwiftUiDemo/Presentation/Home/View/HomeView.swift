//
//  HomeView.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import SwiftUI

struct HomeView: View {
    
    @State private var selectedIndex: Int = 0
    @State private var searchText: String = ""
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var filteredFilms: [(String, String, String)] {
        if searchText.isEmpty {
            return HomeConstants.films
        } else {
            return HomeConstants.films.filter { $0.0.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            ScrollView {
                
                TextField("Search TMDB", text: $searchText)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                GenreListView(selectedIndex: $selectedIndex)
                
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(filteredFilms, id: \.0) { title, year, imageName in
                        FilmCardView(imageName: imageName, filmTitle: title, fileReleaseYear: year)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    HomeView()
}
