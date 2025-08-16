//
//  HomeView.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import SwiftUI

struct HomeView: View {
    
    @State private var selectedIndex: Int = 0
    
    var body: some View {
        ScrollView {
            GenreListView(selectedIndex: $selectedIndex)
        }
    }
}

#Preview {
    HomeView()
}
