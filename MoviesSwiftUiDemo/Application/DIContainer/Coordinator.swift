//
//  Coordinator.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import SwiftUI

class Coordinator {
    private var pathBinding: Binding<NavigationPath>
    
    init(pathBinding: Binding<NavigationPath>) {
        self.pathBinding = pathBinding
    }
    
    func navigate(to route: AppRoute) {
        pathBinding.wrappedValue.append(route)
    }
}
