//
//  GreetingViewController.swift
//  sopt-kimsoomin-assignment
//
//  Created by mandoo on 11/19/25.
//

import UIKit
import SnapKit
import Then

final class GreetingViewController_Network: BaseViewController {
    
    // MARK: - Properties
    
    private let id: Int
    private let provider: NetworkProviding
    
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
    
    private lazy var getUserInfoButton = UIButton().then{
        $0.backgroundColor = .baeminMint500
        $0.setTitle("내 정보 확인하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .head_b_18
        $0.layer.cornerRadius = 4
        $0.isEnabled = true
        $0.addTarget(self, action: #selector(getUserInfoButtonTapped), for: .touchUpInside)
    }
    
    private lazy var deleteUserButton = UIButton().then{
        $0.backgroundColor = .baeminMint500
        $0.setTitle("회원 탈퇴하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .head_b_18
        $0.layer.cornerRadius = 4
        $0.isEnabled = true
        $0.addTarget(self, action: #selector(deleteUserButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setUI()
        setLayout()
    }
    
    // MARK: - Init
    
    init(id: Int, provider: NetworkProviding = NetworkProvider()) {
        self.id = id
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setUI() {
        view.addSubviews(sloganLabel, backButton, baeminImageView, baeminWelcomeLabel, welcomeLabel, getUserInfoButton, deleteUserButton)
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
        
        getUserInfoButton.snp.makeConstraints {
            $0.top.equalTo(baeminWelcomeLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(46)
        }
        
        deleteUserButton.snp.makeConstraints {
            $0.top.equalTo(getUserInfoButton.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(46)
        }
    }
    
    // MARK: - Actions
    
    @objc private func getUserInfoButtonTapped() {
        Task {
            await getUser()
        }
    }
    
    @objc private func deleteUserButtonTapped() {
        showDeleteAlert()
    }
    
    // MARK: - Private Methods
    
    private func showDeleteAlert() {
        let alert = UIAlertController(
            title: "탈퇴하시겠습니까?",
            message: "사용자 정보가 모두 삭제됩니다",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "취소하기", style: .cancel))
        alert.addAction(UIAlertAction(title: "탈퇴하기", style: .destructive, handler: { _ in
            Task { await self.deleteUser() }
        }))
        
        present(alert, animated: true)
    }
    
    // MARK: - Network Methods
    
    @MainActor
    private func getUser() async {
        loadingIndicator.startAnimating()
        do {
            let response = try await UserAPI.performGetUser(id: id, provider: provider)
            showAlert(title: "사용자 정보가 조회되었습니다", message: "id - \(response.username)\nname - \(response.name)\nemail - \(response.email)\nage - \(response.age)")
        } catch {
            showAlert(title: "ERROR: 조회에 실패하였습니다", message: error.localizedDescription)
        }
        loadingIndicator.stopAnimating()
    }
    
    @MainActor
    private func deleteUser() async {
        loadingIndicator.startAnimating()
        do {
            _ = try await UserAPI.performDeleteUser(id: id, provider: provider)
            showAlert(title: "탈퇴가 완료되었습니다", message: "다시 회원가입을 진행해주세요") { [weak self] in
                self?.navigationController?.popToRootViewController(animated: true)
            }
        } catch {
            showAlert(title: "ERROR: 탈퇴에 실패하였습니다", message: error.localizedDescription)
        }
        loadingIndicator.stopAnimating()
    }
}

