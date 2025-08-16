//
//  ApiRequestBuilder.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import Foundation

class APIRequestBuilder {
    private var url: URL?
    private var method: HTTPMethod
    private var headers: [String: String]?
    private var parameters: [String: Any]?
    private var parameterEncoding: ParameterEncoding

    init(url: URL?, method: HTTPMethod) {
        self.url = url
        self.method = method
        self.parameterEncoding = .url
    }
    
    private func setDefaultHeaders() {
        self.headers = [:]
    }

    func setHeaders(_ headers: [String: String]) -> Self {
        for (key, value) in headers {
            self.headers?[key] = value
          }
        return self
    }

    func setParameters(_ parameters: [String: Any], encoding: ParameterEncoding) -> Self {
        self.parameters = parameters
        self.parameterEncoding = encoding
        return self
    }
    
    func setParameterEncoding(_ encoding: ParameterEncoding) -> Self {
        self.parameterEncoding = encoding
        return self
    }

    func build() -> APIRequest {
        return APIRequest(
            url: url,
            method: method,
            headers: headers,
            parameters: parameters,
            parameterEncoding: parameterEncoding
        )
    }
}
