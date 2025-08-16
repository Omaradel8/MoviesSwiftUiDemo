//
//  NetworkManager.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import Foundation

class NetworkManager: NetworkManagerProtocol {
    
    // MARK: - Request
    func request<T: Codable>(request: APIRequest) async throws -> T {
        guard let url = request.url else {
            throw BaseError(errorCode: ErrorCode.UNKNOWN_ERROR.rawValue)
        }
        
        var urlRequest = URLRequest(url: url)
        setupMethodType(for: &urlRequest, with: request)
        setupHeaders(for: &urlRequest, with: request)
        try setupParameters(for: &urlRequest, with: request, url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        printForDebug(request, data: data, response: response, error: nil)
        
        guard !data.isEmpty else {
            throw BaseError(errorCode: ErrorCode.UNKNOWN_ERROR.rawValue)
        }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            print("Decoding error: \(error)")
            throw BaseError(errorCode: ErrorCode.UNKNOWN_ERROR.rawValue)
        }
    }
    
    // MARK: - Setup
    internal func setupMethodType(for urlRequest: inout URLRequest, with request: APIRequest) {
        urlRequest.httpMethod = request.method.rawValue
    }
    
    internal func setupHeaders(for urlRequest: inout URLRequest, with request: APIRequest) {
        if let headers = request.headers {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
    }
    
    private func setupParameters(for urlRequest: inout URLRequest, with request: APIRequest, _  url: URL)  throws  {
        if let parameters = request.parameters {
            switch request.parameterEncoding {
            case .url:
                var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
                urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
                urlRequest.url = urlComponents?.url
                
            case .json:
                do {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                } catch {
                    throw BaseError(errorCode: ErrorCode.UNKNOWN_ERROR.rawValue)
                }
            }
        }
    }
    
    // MARK: - Handle Error
    private func handleUrlSessionError<T: Codable>(_ request: APIRequest, _ response: URLResponse?, with error: NSError) async throws -> T {
        switch error.code {
        case NSURLErrorTimedOut:
            throw BaseError(errorCode: ErrorCode.TIME_OUT.rawValue)
        case NSURLErrorNotConnectedToInternet, NSURLErrorNetworkConnectionLost:
            throw BaseError(errorCode: ErrorCode.INTERNET_CONNECTION_ERROR.rawValue)
        default:
            throw BaseError(errorCode: ErrorCode.UNKNOWN_ERROR.rawValue)
        }
    }
    
    // MARK: - Debug Print
    internal func printForDebug(_ request: APIRequest, data: Data? = nil, response: URLResponse?, error: Error?) {
        print("REQUEST --> .............................................................")
        print("REQUEST --> url --> ",request.url?.absoluteString ?? "")
        print("REQUEST --> method --> ",request.method.rawValue)
        print("REQUEST --> headers --> ",request.headers ?? [:])
        print("REQUEST --> parameterEncoding --> ", request.parameterEncoding)
        print("REQUEST --> parameterEncoding --> ", request.parameters ?? [:])
        print("REQUEST --> statusCode --> ", (response as? HTTPURLResponse)?.statusCode ?? 0)
        print("REQUEST --> urlSessionError --> ", error?.localizedDescription ?? "")
        print("REQUEST --> data --> ", String(data: data ?? Data(), encoding: .utf8) ?? "")
    }
}
    
