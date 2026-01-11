//
//  ViewModel.swift
//  angti-assignment
//
//  Created by mandoo on 1/10/26.
//

import Combine

final class PhotoViewModel {
    struct Input {
        let randomButtonTapped = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        let currentPhoto = CurrentValueSubject<Photo?, Never>(nil)
        let isPhotoSelected = PassthroughSubject<Bool, Never>()
    }
    
    // MARK: - Properties
    
    let input = Input()
    let output = Output()
    
    private let useCase: FetchPhotosUseCase
    private var photos: [Photo] = []
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(useCase: FetchPhotosUseCase) {
        self.useCase = useCase
        bindInput()
    }
    
    // MARK: - Private Methods
    
    private func bindInput() {
        input.randomButtonTapped
            .sink { [weak self] in
                self?.selectRandomPhoto()
            }
            .store(in: &cancellables)
    }
    
    private func selectRandomPhoto() {
        Task {
            do {
                self.photos = try await useCase.execute()
                let randomPhoto = self.photos.randomElement()
                output.currentPhoto.send(randomPhoto)
                output.isPhotoSelected.send(true)
            } catch {
                print("사진 불러오기 에러!!")
            }
        }
    }
}
