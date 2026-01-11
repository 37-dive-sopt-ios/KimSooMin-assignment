//
//  AppDIContainer.swift
//  angti-assignment
//
//  Created by mandoo on 1/11/26.
//

import UIKit
import Moya

final class AppDIContainer {
    
    private let photoProvider = MoyaProvider<PhotoAPI>()
    
    private func makePhotoRepository() -> PhotoRepository {
        return DefaultPhotoRepository()
    }
    
    private func makeFetchPhotosUseCase() -> FetchPhotosUseCase {
        return DefaultFetchPhotosUseCase(repository: makePhotoRepository())
    }
    
    func makePhotoViewController() -> PhotoViewController {
        let viewModel = PhotoViewModel(useCase: makeFetchPhotosUseCase())
        return PhotoViewController(viewModel: viewModel)
    }
}
