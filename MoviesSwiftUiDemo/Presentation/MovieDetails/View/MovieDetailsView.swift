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
            Image("poster")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .frame(height: 350)
        }
        .background(Color.black)
        .ignoresSafeArea()
    }
}

#Preview {
    MovieDetailsView()
}
