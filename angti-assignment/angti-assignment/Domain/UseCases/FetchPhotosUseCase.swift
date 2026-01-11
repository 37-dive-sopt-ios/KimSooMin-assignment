//
//  FetchPhotosUseCase.swift
//  angti-assignment
//
//  Created by mandoo on 1/10/26.
//

protocol FetchPhotosUseCase {
    func execute() async throws -> [Photo]
}

final class DefaultFetchPhotosUseCase: FetchPhotosUseCase {
    private let repository: PhotoRepository
    init(repository: PhotoRepository) { self.repository = repository }

    func execute() async throws -> [Photo] {
        return try await repository.fetchPhotos()
    }
}
