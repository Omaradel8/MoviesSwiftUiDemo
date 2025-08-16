//
//  CustomError.swift
//  MoviesSwiftUiDemo
//
//  Created by Omar Adel on 16/08/2025.
//

import Foundation

struct CustomError: Codable {
    let code: Int?
    let message: String?
    let uuid: String?

    private enum CodingKeys: String, CodingKey {
        case code = "code"
        case message = "msg"
        case uuid = "uuid"
    }
    init(codeStatus: Int, message: String = "", uuid: String = "") {
        self.code = codeStatus
        self.message = message
        self.uuid = uuid
    }
}
