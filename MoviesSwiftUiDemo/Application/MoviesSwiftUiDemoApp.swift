//
//  MoviesSwiftUiDemoApp.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import SwiftUI

@main
struct MoviesSwiftUiDemoApp: App {
    
    @StateObject private var coordinator = AppFlowCoordinator()
    
    var body: some Scene {
        WindowGroup {
            coordinator.buildRootView()
        }
    }
}
