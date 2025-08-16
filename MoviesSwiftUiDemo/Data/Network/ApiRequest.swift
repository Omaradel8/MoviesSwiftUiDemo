//
//  ApiRequest.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum ParameterEncoding {
    case url
    case json
}

struct APIRequest {
    let url: URL?
    let method: HTTPMethod
    var headers: [String: String]?
    let parameters: [String: Any]?
    let parameterEncoding: ParameterEncoding
}
