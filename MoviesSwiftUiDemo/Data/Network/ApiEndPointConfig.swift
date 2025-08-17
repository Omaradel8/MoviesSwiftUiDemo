//
//  ApiEndPointConfig.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 17/08/2025.
//

import Foundation

// MARK: - APIEndpointConfig Protocol
protocol APIEndpointConfig {
    var request: APIRequest { get }
    func updateRequestData(with data: Any?)
}

extension APIEndpointConfig {
    func updateRequestData(with data: Any?) {}
}
