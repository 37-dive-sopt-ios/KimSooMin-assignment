//
//  RegisterRequest.swift
//  sopt-ios-seminar01
//
//  Created by mandoo on 11/8/25.
//

import Foundation

struct RegisterRequest: Encodable {
    let username: String
        let password: String
        let name: String
        let email: String
        let age: Int
}
