//
//  BaseResponse.swift
//  sopt-ios-seminar01
//
//  Created by mandoo on 11/8/25.
//

import Foundation

public struct BaseResponse<T: Decodable>: Decodable {
    public let success: Bool
    public let code: String?
    public let message: String?
    public let data: T?
}

public struct EmptyResponse: Decodable {
    public init() {}
}
