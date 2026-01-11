//
//  DefaultPhotoRepository.swift
//  angti-assignment
//
//  Created by mandoo on 1/10/26.
//

import Foundation
import Moya

final class DefaultPhotoRepository: PhotoRepository {
    private let provider = MoyaProvider<PhotoAPI>()

    func fetchPhotos() async throws -> [Photo] {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.fetchPhotos) { result in
                switch result {
                case .success(let response):
                    do {
                        let dtos = try JSONDecoder().decode([PhotoDTO].self, from: response.data)
                        continuation.resume(returning: dtos.map { $0.toDomain() })
                    } catch { continuation.resume(throwing: error) }
                case .failure(let error): continuation.resume(throwing: error)
                }
            }
        }
    }
}
