//
//  ViewController.swift
//  sopt-kimsoomin-assignment
//
//  Created by mandoo on 10/29/25.
//

import UIKit
import Then
import SnapKit

final class LoginViewController: UIViewController {
    
    private let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    private let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
    
    // MARK: - UI Components
    
    private let continueWithLabel = UILabel().then {
        $0.text = "이메일 또는 아이디로 계속"
        $0.textAlignment = .center
        $0.textColor = .black
        $0.font = .title_sb_18
    }
    
    private lazy var backButton = UIButton().then {
        let svgImage = UIImage(named: "backBtn")
        $0.setImage(svgImage, for: .normal)
        $0.tintColor = .black
    }
    
    private let idAndEmailTextField = UITextField().then {
        $0.placeholder = "이메일 아이디"
        $0.attributedPlaceholder = NSAttributedString(string: "이메일 아이디", attributes: [NSAttributedString.Key.foregroundColor : UIColor.baeminGray700])
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
        $0.addLeftPadding(10)
        $0.addLeftPadding(10)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.baeminGray200.cgColor
        $0.layer.cornerRadius = 4
    }
    
    private lazy var clearPasswordButton = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "x-circle"), for: .normal)
        $0.tintColor = .baeminGray700
        $0.isHidden = true
        $0.addTarget(self, action: #selector(clearPasswordButtonDidTap), for: .touchUpInside)
    }
    
    private lazy var securityToggleButton = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "eye-slash"), for: .normal)
        $0.tintColor = .baeminGray700
        $0.isHidden = true
        $0.addTarget(self, action: #selector(securityToggleButtonDidTap), for: .touchUpInside)
    }
    
    private lazy var loginButton = UIButton(type: .custom).then  {
        $0.backgroundColor = .baeminGray200
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .head_b_18
        $0.layer.cornerRadius = 4
        $0.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        $0.isEnabled = false
    }
    
    private let findAccountStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .center
    }
    
    private let findAccountLabel = UILabel().then {
        $0.text = "계정 찾기"
        $0.textColor = .baeminBlack
        $0.font = .body_r_14
    }
    
    private lazy var findAccountButton = UIButton().then {
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .regular)
        let image = UIImage(systemName: "chevron.right", withConfiguration: symbolConfig)
        
        $0.setImage(image, for: .normal)
        $0.tintColor = .black
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setLayout()
        checkTextFieldIsEmpty()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initializing()
    }
    
    private func checkTextChanghe(){
        idAndEmailTextField.addTarget(self, action: #selector(checkTextField), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(checkTextField), for: .editingChanged)
    }
    
    // MARK: - Layout
    
    private func setLayout() {
        view.addSubviews(backButton,
                         continueWithLabel,
                         idAndEmailTextField,
                         passwordTextField,
                         passwordStackView,
                         loginButton,
                         findAccountStackView)
        
        passwordStackView.addArrangedSubviews(clearPasswordButton,securityToggleButton)
        findAccountStackView.addArrangedSubviews(findAccountLabel, findAccountButton)
        
        continueWithLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(57)
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(48)
            $0.leading.equalToSuperview().offset(16)
            $0.size.equalTo(36)
        }
        
        idAndEmailTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(continueWithLabel.snp.bottom).offset(36)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(46)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(idAndEmailTextField.snp.bottom).offset(12)
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
        
        findAccountStackView.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
        }
    }
    
    
    // MARK: - Actions
    
    @objc
    private func checkTextField() {
        let isIdEmailValid = !(idAndEmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        let isPasswordValid = !(passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        
        let isButtonEnabled = isIdEmailValid && isPasswordValid
        
        loginButton.isEnabled = isButtonEnabled
        
        loginButton.backgroundColor = isButtonEnabled ? .baeminMint500 : .baeminGray200
        
        clearPasswordButton.isHidden = passwordTextField.text?.isEmpty ?? true
        securityToggleButton.isHidden = passwordTextField.text?.isEmpty ?? true
    }
    
    @objc
    private func clearPasswordButtonDidTap() {
        passwordTextField.text = ""
        checkTextField()
    }
    
    @objc private func securityToggleButtonDidTap() {
        passwordTextField.isSecureTextEntry.toggle()
        let imageName = passwordTextField.isSecureTextEntry ? "eye-slash" : "eye"
        securityToggleButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
    @objc
    private func loginButtonDidTap() {
        guard let idText = idAndEmailTextField.text,
              let passwordText = passwordTextField.text else { return }
        
        let trimmedId = idText.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPassword = passwordText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if !isValid(text: trimmedId, regex: emailRegex) {
            presentAlert(message: "이메일 형식이 달라요")
            return
        }
        
        if !isValid(text: trimmedPassword, regex: passwordRegex) {
            presentAlert(message: "비밀번호는 최소 8자 이상, 영문, 숫자, 특수문자를 포함해야 해요")
            return
        }
        pushToWelcomeVC()
    }
    
    
    // MARK: - Functions
    
    func initializing() {
        idAndEmailTextField.text = ""
        passwordTextField.text = ""
        checkTextField()
        clearPasswordButton.isHidden = true
        securityToggleButton.setImage(UIImage(named: "eye-slash"), for: .normal)
        passwordTextField.isSecureTextEntry = true
    }
    
    private func checkTextFieldIsEmpty() {
        idAndEmailTextField.addTarget(self, action: #selector(checkTextField), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(checkTextField), for: .editingChanged)
    }
    
    private func isValid(text: String, regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: text)
    }
    
    private func presentAlert(message: String) {
        let alert = UIAlertController(title: "입력 오류", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func pushToWelcomeVC(){
        let vc = GreetingViewController()
        vc.id = idAndEmailTextField.text
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
