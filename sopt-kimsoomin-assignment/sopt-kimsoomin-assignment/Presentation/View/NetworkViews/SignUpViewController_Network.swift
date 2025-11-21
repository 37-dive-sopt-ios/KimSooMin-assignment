//
//  SignUpViewController_Network.swift
//  sopt-kimsoomin-assignment
//
//  Created by mandoo on 11/19/25.
//

import UIKit
import SnapKit
import Then

final class SignUpViewController_Network: BaseViewController {
    
    // MARK: - Properties
    
    private let provider: NetworkProviding
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel().then {
        $0.text = "회원가입"
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
    
    private let nameTextField = UITextField().then {
        $0.placeholder = "이름"
        $0.attributedPlaceholder = NSAttributedString(string: "이름", attributes: [NSAttributedString.Key.foregroundColor : UIColor.baeminGray700])
        $0.borderStyle = .none
        $0.layer.borderColor = UIColor.baeminGray200.cgColor
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 4
        $0.font = .body_r_14
        $0.textColor = .baeminBlack
        $0.addLeftPadding()
    }
    
    private let emailTextField = UITextField().then {
        $0.placeholder = "이메일"
        $0.attributedPlaceholder = NSAttributedString(string: "이메일", attributes: [NSAttributedString.Key.foregroundColor : UIColor.baeminGray700])
        $0.borderStyle = .none
        $0.layer.borderColor = UIColor.baeminGray200.cgColor
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 4
        $0.font = .body_r_14
        $0.textColor = .baeminBlack
        $0.addLeftPadding()
    }
    
    private let ageTextField = UITextField().then {
        $0.placeholder = "나이"
        $0.attributedPlaceholder = NSAttributedString(string: "나이", attributes: [NSAttributedString.Key.foregroundColor : UIColor.baeminGray700])
        $0.borderStyle = .none
        $0.layer.borderColor = UIColor.baeminGray200.cgColor
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 4
        $0.font = .body_r_14
        $0.textColor = .baeminBlack
        $0.addLeftPadding()
    }
    
    private lazy var loginButton = UIButton(type: .custom).then  {
        $0.backgroundColor = .baeminGray200
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .head_b_18
        $0.layer.cornerRadius = 4
        $0.backgroundColor = .baeminMint500
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
                         nameTextField,
                         emailTextField,
                         ageTextField,
                         loginButton)
        
        passwordStackView.addArrangedSubviews(clearPasswordButton,securityToggleButton)
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
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(12)
            $0.height.equalTo(46)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(12)
            $0.height.equalTo(46)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        ageTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(12)
            $0.height.equalTo(46)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(ageTextField.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(46)
        }
    }
    
    // MARK: - Actions
    
    @objc private func registerButtonTapped() {
        guard let username = idTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let name = nameTextField.text, !name.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let ageText = ageTextField.text, let age = Int(ageText) else {
            showAlert(title: "입력 오류", message: "모든 필드를 올바르게 입력해주세요.")
            return
        }
        
        Task {
            await performSignUp(
                username: username,
                password: password,
                name: name,
                email: email,
                age: age
            )
        }
    }
    
    // MARK: - Private Methods
    
    private func initializing() {
        idTextField.text = ""
        passwordTextField.text = ""
        nameTextField.text = ""
        emailTextField.text = ""
        ageTextField.text = ""
        clearPasswordButton.isHidden = true
        passwordTextField.isSecureTextEntry = true
    }
    
    private func navigateToLogin(userId: Int, userName: String) {
        let loginVC = LoginViewController_Network()
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    // MARK: - Network Methods
    
    @MainActor
    private func performSignUp(
        username: String,
        password: String,
        name: String,
        email: String,
        age: Int
    ) async {
        loadingIndicator.startAnimating()
        
        do {
            let response = try await UserAPI.performSignUp(
                username: username,
                password: password,
                name: name,
                email: email,
                age: age,
                provider: provider
            )
            
            showAlert(title: "회원가입 성공", message: "회원가입이 완료되었습니다!") { [weak self] in
                self?.navigateToLogin(userId: response.id, userName: response.name)
            }
        } catch let error as NetworkError {
            print("🚨 [Register Error] \(error.detailedDescription)")
            showAlert(title: "회원가입 실패", message: error.localizedDescription)
        } catch {
            print("🚨 [Register Unknown Error] \(error)")
            showAlert(title: "회원가입 실패", message: error.localizedDescription)
        }
        
        loadingIndicator.stopAnimating()
    }
}
