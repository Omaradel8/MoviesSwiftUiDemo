//
//  NetworkManagerProtocol.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import Foundation

protocol NetworkManagerProtocol {
    func request<T: Codable>(request: APIRequest) async throws -> T
}
