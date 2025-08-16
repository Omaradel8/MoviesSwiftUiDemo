//
//  ErrorCodes.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import Foundation

enum ErrorCode: Int {
    case INTERNET_CONNECTION_ERROR  = -1
    case UNKNOWN_ERROR              = -2
    case TIME_OUT                   = -3
    
    func getErrorCategory() -> ErrorCategory {
        switch self {
        case .INTERNET_CONNECTION_ERROR
            ,.TIME_OUT :
            return .INTERNET_CONNECTION
        case .UNKNOWN_ERROR:
            return .UNKNWON
        }
        
    }    
}

enum ErrorCategory {
    case INTERNET_CONNECTION
    case UNKNWON
}
