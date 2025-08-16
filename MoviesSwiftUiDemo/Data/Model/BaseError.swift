//
//  BaseError.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import Foundation

struct BaseError: Error {
    
    var errors: [CustomError]?
    
    init(errors: [CustomError]?) {
        self.errors = errors
    }
    
    init(errorCode: Int){
        self.errors = [CustomError(codeStatus: errorCode)]
    }
    
    init(codeStatus: Int, message: String , uuid: String ){
        self.errors = [CustomError(codeStatus: codeStatus, message: message, uuid: uuid)]
    }
    
    func getErrorMessage() -> String {
        let errorCode = ErrorCode(rawValue: errors?.first?.code ?? ErrorCode.UNKNOWN_ERROR.rawValue)
        switch errorCode?.getErrorCategory() {
        case .INTERNET_CONNECTION :
            return "We couldn't complete your request due to an internet connection loss. Please try again."
        case .UNKNWON :
            return "Something went wrong, please try again later."
        default :
            return  errors?.first?.message ?? "Something went wrong, please try again later."
        }
    }
}
