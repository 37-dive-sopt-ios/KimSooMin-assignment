//
//  LoginViewController_Network.swift
//  sopt-kimsoomin-assignment
//
//  Created by mandoo on 11/19/25.
//

import UIKit
import Then
import SnapKit

final class LoginViewController_Network: BaseViewController {
    
    // MARK: - Properties
    
    private let provider: NetworkProviding
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel().then {
        $0.text = "로그인"
        $0.textAlignment = .center
        $0.textColor = .black
        $0.font = .title_sb_18
    }
    
    private lazy var backButton = UIButton().then {
        let svgImage = UIImage(named: "backBtn")
        $0.setImage(svgImage, for: .normal)
        $0.tintColor = .black
    }
    
    private let idTextField = UITextField().then {
        $0.placeholder = "아이디"
        $0.attributedPlaceholder = NSAttributedString(string: "아이디", attributes: [NSAttributedString.Key.foregroundColor : UIColor.baeminGray700])
        $0.borderStyle = .none
        $0.layer.borderColor = UIColor.baeminGray200.cgColor
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 4
        $0.font = .body_r_14
        $0.textColor = .baeminBlack
        $0.addLeftPadding()
    }
    
    private let passwordStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 16
        $0.alignment = .center
    }
    
    private let passwordTextField = UITextField().then {
        $0.placeholder = "비밀번호"
        $0.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [NSAttributedString.Key.foregroundColor : UIColor.baeminGray700])
        $0.borderStyle = .none
        $0.font = .body_r_14
        $0.textColor = .baeminBlack
        $0.isSecureTextEntry = true
        $0.addLeftPadding()
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.baeminGray200.cgColor
        $0.layer.cornerRadius = 4
    }
    
    private lazy var clearPasswordButton = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "x-circle"), for: .normal)
        $0.tintColor = .baeminGray700
        $0.isHidden = true
    }
    
    private lazy var securityToggleButton = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "eye-slash"), for: .normal)
        $0.tintColor = .baeminGray700
        $0.isHidden = true
    }
    
    private lazy var loginButton = UIButton(type: .custom).then  {
        $0.backgroundColor = .baeminGray200
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .head_b_18
        $0.layer.cornerRadius = 4
        $0.backgroundColor = .baeminMint500
        $0.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    private let createAccountStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .center
    }
    
    private let createAccountLabel = UILabel().then {
        $0.text = "회원가입"
        $0.textColor = .baeminBlack
        $0.font = .body_r_14
    }
    
    private lazy var createAccountButton = UIButton().then {
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .regular)
        let image = UIImage(systemName: "chevron.right", withConfiguration: symbolConfig)
        $0.setImage(image, for: .normal)
        $0.tintColor = .black
        $0.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setUI()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initializing()
    }
    
    // MARK: - Init
    
    init(provider: NetworkProviding = NetworkProvider()) {
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setUI() {
        view.addSubviews(backButton,
                         titleLabel,
                         idTextField,
                         passwordTextField,
                         passwordStackView,
                         loginButton,
                         createAccountStackView)
        
        passwordStackView.addArrangedSubviews(clearPasswordButton,securityToggleButton)
        createAccountStackView.addArrangedSubviews(createAccountLabel, createAccountButton)
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(57)
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(48)
            $0.leading.equalToSuperview().offset(16)
            $0.size.equalTo(36)
        }
        
        idTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(36)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(46)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(12)
            $0.height.equalTo(46)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        passwordStackView.snp.makeConstraints {
            $0.trailing.equalTo(passwordTextField.snp.trailing).inset(20)
            $0.centerY.equalTo(passwordTextField)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(46)
        }
        
        createAccountStackView.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    
    @objc private func loginButtonTapped() {
        guard let username = idTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: "입력 오류", message: "아이디와 비밀번호를 입력해주세요")
            return
        }
        
        Task {
            await performLogin(username: username, password: password)
        }
    }
    
    @objc private func registerButtonTapped() {
        let signUpVC = SignUpViewController_Network()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    // MARK: - Private Methods
    
    private func initializing() {
        idTextField.text = ""
        passwordTextField.text = ""
        idTextField.text = ""
        clearPasswordButton.isHidden = true
        passwordTextField.isSecureTextEntry = true
    }
    
    private func navigateToGreeting(userId: Int, userName: String) {
        let greetingVC = GreetingViewController_Network(id: userId)
        navigationController?.pushViewController(greetingVC, animated: true)
    }
    
    // MARK: - Network Methods
    
    @MainActor
    private func performLogin(username: String, password: String) async {
        loadingIndicator.startAnimating()
        
        do {
            let response = try await UserAPI.performLogin(
                username: username,
                password: password,
                provider: provider
            )
            
            showAlert(title: "로그인 성공", message: response.message) { [weak self] in
                self?.navigateToGreeting(userId: response.userId, userName: username)
            }
        } catch let error as NetworkError {
            print("🚨 [Login Error] \(error.detailedDescription)")
            showAlert(title: "로그인 실패", message: error.localizedDescription)
        } catch {
            print("🚨 [Login Unknown Error] \(error)")
            showAlert(title: "로그인 실패", message: error.localizedDescription)
        }
        loadingIndicator.stopAnimating()
    }
}

