//
//  MovieFooterView.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import SwiftUI

struct MovieFooterView: View {
    var body: some View {
        HStack(spacing: 4) {
            Text("Home page:")
                .foregroundColor(.white)
                .font(.footnote)
            
            Link("https://movies.disney.com", destination: URL(string: "https://movies.disney.com")!)
                .foregroundColor(.blue)
                .font(.footnote)
            
            Spacer()
        }
        .padding(.horizontal)
        
        HStack(spacing: 4) {
            Text("Languages:")
            
            Text("English")
            
            Spacer()
        }
        .font(.footnote)
        .foregroundColor(.white)
        .padding(.horizontal)
        
        HStack {
            HStack(spacing: 4) {
                Text("Status:")
                
                Text("Released")
                
                Spacer()
            }
            .font(.footnote)
            .foregroundColor(.white)
            .padding(.horizontal)
            
            Spacer()
            
            HStack(spacing: 4) {
                Text("Runtime:")
                
                Text("102 minutes")
                
                Spacer()
            }
            .font(.footnote)
            .foregroundColor(.white)
            .padding(.horizontal)
        }
        
        HStack {
            HStack(spacing: 4) {
                Text("Budget:")
                
                Text("50 $")
                
                Spacer()
            }
            .font(.footnote)
            .foregroundColor(.white)
            .padding(.horizontal)
            
            Spacer()
            
            HStack(spacing: 4) {
                Text("Revenue:")
                
                Text("100 $")
                
                Spacer()
            }
            .font(.footnote)
            .foregroundColor(.white)
            .padding(.horizontal)
        }
    }
}

#Preview {
    MovieFooterView()
}
