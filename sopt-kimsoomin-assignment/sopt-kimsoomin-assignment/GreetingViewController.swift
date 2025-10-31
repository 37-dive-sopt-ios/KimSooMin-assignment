//
//  GreetingViewController.swift
//  sopt-kimsoomin-assignment
//
//  Created by mandoo on 10/31/25.
//

import UIKit
import SnapKit
import Then

final class GreetingViewController: UIViewController {
    
    // MARK: - Properties
    
    var id: String?
    
    private let sloganLabel: UILabel = {
        let label = UILabel()
        return label.then {
            $0.text = "대체 뼈찜 누가 시켰어??"
            $0.textAlignment = .center
            $0.textColor = .black
            $0.font = .title_sb_18
        }
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        
        return button.then {
            let svgImage = UIImage(named: "backBtn")
            $0.setImage(svgImage, for: .normal)
            $0.tintColor = .black
        }
    }()
    
    private let baeminImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView.then {
            $0.image = UIImage(named: "greetingImage")
            $0.clipsToBounds = true
        }
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        return label.then {
            $0.text = "환영합니다"
            $0.textAlignment = .center
            $0.font = .head_b_24
            $0.textColor = .black
        }
    }()
    
    
    private let baeminWelcomeLabel: UILabel = {
        let label = UILabel()
        return label.then {
            $0.text = "반가워요!"
            $0.textAlignment = .center
            $0.font = .title_sb_18
            $0.textColor = .black
            $0.numberOfLines = 0
        }
    }()
    
    private lazy var goLoginButton: UIButton = {
        let button = UIButton()
        return button.then {
            $0.backgroundColor = .baeminMint500
            $0.setTitle("뒤로가기", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .head_b_18
            $0.layer.cornerRadius = 4
            $0.addTarget(self, action: #selector(goLoginButtonDidTap), for: .touchUpInside)
            $0.isEnabled = true
        }
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        if let userId = self.id, !userId.isEmpty {
            let trimmedId = userId.trimmingCharacters(in: .whitespacesAndNewlines)
            baeminWelcomeLabel.text = "\(trimmedId)님 반가워요!"
        } else {
            baeminWelcomeLabel.text = "배민 회원님 반가워요!" 
        }
        
        // 네비게이션 바 숨기기 (커스텀 버튼 사용)
        self.navigationController?.isNavigationBarHidden = true
        
        setLayout()
        
    }
    
    // MARK: - Actions
    
    @objc
    private func goLoginButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Layout
    
    private func setLayout() {
        view.addSubviews(sloganLabel, backButton, baeminImageView, baeminWelcomeLabel, welcomeLabel,goLoginButton)
        
        sloganLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(57)
        }
        
        
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(48)
            $0.trailing.equalTo(sloganLabel.snp.leading).offset(-55)
            $0.size.equalTo(40)
        }
        
        baeminImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(93)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(0)
            $0.height.equalTo(211)
        }
        
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(baeminImageView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(130)
            $0.trailing.equalToSuperview().offset(-130)
        }
        
        baeminWelcomeLabel.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        goLoginButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-48)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(46)
        }
    }
}
