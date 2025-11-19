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
    
    // MARK: - UI Components
    
    private let sloganLabel = UILabel().then {
        $0.text = "대체 뼈찜 누가 시켰어??"
        $0.textAlignment = .center
        $0.textColor = .black
        $0.font = .title_sb_18
    }
    
    private lazy var backButton = UIButton().then {
        let svgImage = UIImage(named: "backBtn")
        $0.setImage(svgImage, for: .normal)
        $0.tintColor = .black
        $0.addTarget(self, action: #selector(goBackButtonDidTap), for: .touchUpInside)
    }
    
    private let baeminImageView = UIImageView().then {
        $0.image = UIImage(named: "greetingImage")
    }
    
    private let welcomeLabel = UILabel().then {
        $0.text = "환영합니다"
        $0.textAlignment = .center
        $0.font = .head_b_24
        $0.textColor = .black
    }
    
    private let baeminWelcomeLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = .title_sb_18
        $0.textColor = .black
        $0.numberOfLines = 0
    }
    
    private lazy var goMainButton = UIButton().then{
        $0.backgroundColor = .baeminMint500
        $0.setTitle("메인으로 가기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .head_b_18
        $0.layer.cornerRadius = 4
        $0.isEnabled = true
        $0.addTarget(self, action: #selector(goMainButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setUI()
        setLayout()
        bindUserID()
    }
    
    // MARK: - Setup Methods
    
    private func setUI() {
        view.addSubviews(sloganLabel, backButton, baeminImageView, baeminWelcomeLabel, welcomeLabel,goMainButton)
    }
    
    private func setLayout() {
        sloganLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(57)
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(48)
            $0.leading.equalToSuperview().offset(16)
            $0.size.equalTo(40)
        }
        
        baeminImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(93)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(211)
        }
        
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(baeminImageView.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }
        
        baeminWelcomeLabel.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        goMainButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(48)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(46)
        }
    }
    
    // MARK: - Actions
    @objc
    private func goBackButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func goMainButtonDidTap() {
        switchToTabBarView()
    }
    
    // MARK: - Functions
    
    func bindUserID() {
        if let userId = self.id, !userId.isEmpty {
            let trimmedId = userId.trimmingCharacters(in: .whitespacesAndNewlines)
            baeminWelcomeLabel.text = "\(trimmedId)님 반가워요!"
        } else {
            baeminWelcomeLabel.text = "배민 회원님 반가워요!"
        }
    }
    
    private func switchToTabBarView(){
        let tabBarController = TabBarViewController()
        
        tabBarController.modalPresentationStyle = .fullScreen
        tabBarController.modalTransitionStyle = .crossDissolve
        
        self.present(tabBarController, animated: true) {
            self.view.window?.rootViewController = tabBarController
            self.view.window?.makeKeyAndVisible()
        }
    }
}
