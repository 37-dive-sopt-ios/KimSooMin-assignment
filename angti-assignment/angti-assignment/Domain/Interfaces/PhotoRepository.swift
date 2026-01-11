//
//  PhotoRepository.swift
//  angti-assignment
//
//  Created by mandoo on 1/10/26.
//

protocol PhotoRepository {
    func fetchPhotos() async throws -> [Photo]
}
