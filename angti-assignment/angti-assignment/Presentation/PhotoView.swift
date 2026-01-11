//
//  PhotoView.swift
//  angti-assignment
//
//  Created by mandoo on 1/11/26.
//

import UIKit

import Combine
import Kingfisher
import SnapKit
import Then

final class PhotoView: UIView {
    
    // MARK: - Properties
    
    let randomButtonTapped = PassthroughSubject<Void, Never>()
    
    // MARK: - UI Components
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .bold)
    }
    
    private let idLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
    }
    
    private let randomButton = UIButton().then {
        $0.setTitle("랜덤 가나디 뽑기", for: .normal)
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 10
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    
    private let resultLabel = UILabel().then {
        $0.text = "가나디가 선택되었어요 🐶"
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.isHidden = true
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        randomButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: - Setup Methods
    
    private func setUI() {
        backgroundColor = .systemBackground
        
        [imageView, idLabel, titleLabel, randomButton, resultLabel].forEach { addSubview($0) }
    }
    
    func setLayout() {
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-80)
            $0.width.height.equalTo(250)
        }
        
        idLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(idLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.centerX.equalToSuperview()
        }
        
        randomButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(50)
        }
        
        resultLabel.snp.makeConstraints {
            $0.center.equalTo(randomButton)
        }
    }
    
    // MARK: - Private Method
    
    func updateView(with photo: Photo) {
        idLabel.text = "가나디 고유 번호 - \(photo.id)"
        imageView.kf.setImage(with: URL(string: photo.url))
    }
    
    func showGanadiResult() {
        randomButton.isHidden = true
        resultLabel.isHidden = false
    }
    
    // MARK: - Action
    
    @objc private func didTapButton() {
        randomButtonTapped.send(())
    }
}
