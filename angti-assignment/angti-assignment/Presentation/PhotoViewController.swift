//
//  ViewController.swift
//  angti-assignment
//
//  Created by mandoo on 1/10/26.
//

import UIKit
import Combine

final class PhotoViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: PhotoViewModel
    private var cancellables = Set<AnyCancellable>()
    private let contentView = PhotoView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    // MARK: - Init
    
    init(viewModel: PhotoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: - Private Methods
    
    private func bind() {
        contentView.randomButtonTapped
            .subscribe(viewModel.input.randomButtonTapped)
            .store(in: &cancellables)
        
        viewModel.output.currentPhoto
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] photo in
                self?.contentView.updateView(with: photo)
            }
            .store(in: &cancellables)
        
        viewModel.output.isPhotoSelected
            .filter { $0 == true }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.contentView.showGanadiResult()
            }
            .store(in: &cancellables)
    }
}
