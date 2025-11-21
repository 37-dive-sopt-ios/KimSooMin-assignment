//
//  UserDTO.swift
//  sopt-ios-seminar01
//
//  Created by mandoo on 11/8/25.
//

import Foundation

struct UserResponse: Decodable {
    let id: Int
    let username: String
    let name: String
    let email: String
    let age: Int
    let status: String
}

struct LoginRequest: Encodable {
    let username: String
    let password: String
}

struct LoginResponse: Decodable {
    let userId: Int
    let message: String
}

struct UpdateUserRequest: Encodable {
    let name: String?
    let email: String?
    let age: Int?
}

