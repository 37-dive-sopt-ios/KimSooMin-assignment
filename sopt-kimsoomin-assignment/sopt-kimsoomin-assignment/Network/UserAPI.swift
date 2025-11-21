//
//  UserAPI.swift
//  sopt-ios-seminar01
//
//  Created by mandoo on 11/8/25.
//

import Foundation

enum UserAPI {
    case register(RegisterRequest)
    case login(LoginRequest)
    case getUser(id: Int)
    case deleteUser(id: Int)
}

extension UserAPI: TargetType {
    var baseURL: String {
        return Environment.baseURL
    }
    
    var path: String {
        switch self {
        case .register:
            return "/api/v1/users"
        case .login:
            return "/api/v1/auth/login"
        case .getUser(let id):
            return "/api/v1/users/\(id)"
        case .deleteUser(let id):
            return "/api/v1/users/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .register:
            return .post
        case .login:
            return .post
        case .getUser:
            return .get
        case .deleteUser:
            return .delete
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .register(let request):
            return .requestJSONEncodable(request)
        case .login(let request):
            return .requestJSONEncodable(request)
        case .getUser:
            return .requestPlain
        case .deleteUser:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}


extension UserAPI {
    static func performSignUp(
        username: String,
        password: String,
        name: String,
        email: String,
        age: Int,
        provider: NetworkProviding? = nil
    ) async throws -> UserResponse {
        let provider = provider ?? NetworkProvider()
        let request = RegisterRequest(
            username: username,
            password: password,
            name: name,
            email: email,
            age: age
        )
        let response: BaseResponse<UserResponse> =
        try await provider.request(UserAPI.register(request))
        guard let data = response.data else {
            throw NetworkError.noData
        }
        return data
    }
    
    static func performLogin(
        username: String,
        password: String,
        provider: NetworkProviding? = nil
    ) async throws -> LoginResponse {
        let provider = provider ?? NetworkProvider()
        let request = LoginRequest(username: username, password: password)
        let response: BaseResponse<LoginResponse> =
        try await provider.request(UserAPI.login(request))
        guard let data = response.data else {
            throw NetworkError.noData
        }
        return data
    }
    
    static func performGetUser(
        id: Int,
        provider: NetworkProviding? = nil
    ) async throws -> UserResponse {
        let provider = provider ?? NetworkProvider()
        let response: BaseResponse<UserResponse> =
        try await provider.request(UserAPI.getUser(id: id))
        guard let data = response.data else {
            throw NetworkError.noData
        }
        return data
    }
    
    static func performDeleteUser(
        id: Int,
        provider: NetworkProviding? = nil
    ) async throws -> BaseResponse<EmptyResponse> {
        let provider = provider ?? NetworkProvider()
        return try await provider.request(UserAPI.deleteUser(id: id))
    }
}
