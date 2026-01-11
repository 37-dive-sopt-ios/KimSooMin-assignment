//
//  PhotoAPI.swift
//  angti-assignment
//
//  Created by mandoo on 1/9/26.
//

import Foundation

import Alamofire
import Moya

enum PhotoAPI {
    case fetchPhotos
}

extension PhotoAPI: TargetType {
    var baseURL: URL { URL(string: "https://api.thedogapi.com/v1")! }
    var path: String { "/images/search" }
    var method: Moya.Method { .get }
    var task: Task { .requestPlain }
    var headers: [String: String]? { ["Content-type": "application/json"] }
}
