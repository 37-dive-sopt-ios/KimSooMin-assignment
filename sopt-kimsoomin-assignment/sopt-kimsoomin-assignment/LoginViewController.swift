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
    
    //이메일 형식 example@aaa.com
    private let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    //최소 8자, 하나 이상의 문자, 숫자 및 특수 문자
    private let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
    
    
    // MARK: - Properties
    
    private let continueWithLabel: UILabel = {
        let label = UILabel()
        return label.then {
            $0.text = "이메일 또는 아이디로 계속"
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
    
    private let idAndEmailTextField: UITextField = {
        let textField = UITextField()
        return textField.then {
            $0.placeholder = "이메일 아이디"
            
            // Placeholder 색상 변경
            $0.attributedPlaceholder = NSAttributedString(string: "이메일 아이디", attributes: [NSAttributedString.Key.foregroundColor : UIColor.baeminGray700])
            $0.borderStyle = .none
            $0.layer.borderColor = UIColor.baeminGray200.cgColor
            $0.layer.borderWidth = 1.0
            $0.layer.cornerRadius = 4
            $0.font = .body_r_14
            $0.textColor = .baeminBlack
            $0.addLeftPadding()
        }
    }()
    
    // 비밀번호 텍스트필드, x 지우기 버튼, 눈 모양 버튼을 담을 뷰
    private let passwordContainerView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.baeminGray200.cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 4
        return view
    }()
    
    private let passwordTextField: UITextField = {
        let passwordField = UITextField()
        return passwordField.then {
            $0.placeholder = "비밀번호"
            $0.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [NSAttributedString.Key.foregroundColor : UIColor.baeminGray700])
            $0.borderStyle = .none
            $0.font = .body_r_14
            $0.textColor = .baeminBlack
            
            $0.isSecureTextEntry = true
            $0.textContentType = .none
        }
    }()
    
    private lazy var clearPasswordButton: UIButton = {
        let button = UIButton(type: .custom)
        return button.then {
            $0.setImage(UIImage(named: "x-circle"), for: .normal)
            $0.tintColor = .baeminGray700
            $0.isHidden = true
            $0.addTarget(self, action: #selector(clearPasswordButtonDidTap), for: .touchUpInside)
        }
    }()
    
    private lazy var securityToggleButton: UIButton = {
        let button = UIButton(type: .custom)
        return button.then {
            $0.setImage(UIImage(named: "eye-slash"), for: .normal)
            $0.tintColor = .baeminGray700
            $0.addTarget(self, action: #selector(securityToggleButtonDidTap), for: .touchUpInside)
        }
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        return button.then {
            $0.backgroundColor = .baeminGray200
            $0.setTitle("로그인", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .head_b_18
            $0.layer.cornerRadius = 4
            $0.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
            $0.isEnabled = false
        }
    }()
    
    private let findAccountLabel: UILabel = {
        let label = UILabel()
        return label.then {
            $0.text = "계정 찾기"
            $0.textAlignment = .center
            $0.textColor = .baeminBlack
            $0.font = .body_r_14
        }
    }()
    
    private lazy var findAccountButton: UIButton = {
        let button = UIButton()
        return button.then {
            let symbolConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .regular)
            let image = UIImage(systemName: "chevron.right", withConfiguration: symbolConfig)
            
            $0.setImage(image, for: .normal)
            $0.tintColor = .black
        }
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        checkTextFieldIsEmpty()
        setLayout()
        
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 화면이 나타날 때마다 초기화
        idAndEmailTextField.text = ""
        passwordTextField.text = ""
        checkTextField()
        clearPasswordButton.isHidden = true
        securityToggleButton.setImage(UIImage(named: "eye-slash"), for: .normal)
        passwordTextField.isSecureTextEntry = true
    }
    
    
    // MARK: - Layout
    
    private func setLayout() {
        view.addSubviews(backButton,
                         continueWithLabel,
                         idAndEmailTextField,
                         passwordContainerView,
                         loginButton,
                         findAccountLabel,
                         findAccountButton)
        
        passwordContainerView.addSubviews(passwordTextField, clearPasswordButton, securityToggleButton)
        
        continueWithLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(57)
        }
        
        
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(48)
            $0.trailing.equalTo(continueWithLabel.snp.leading).offset(-55)
            $0.size.equalTo(40)
        }
        
        idAndEmailTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(continueWithLabel.snp.bottom).offset(36)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(46)
        }
        
        passwordContainerView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(idAndEmailTextField.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(46)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalTo(securityToggleButton.snp.leading).offset(-8)
            $0.centerY.equalToSuperview()
            $0.height.equalToSuperview()
        }
        
        securityToggleButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-8)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        clearPasswordButton.snp.makeConstraints {
            $0.trailing.equalTo(securityToggleButton.snp.leading).offset(-8)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(46)
        }
        
        findAccountLabel.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(154.5)
            $0.trailing.equalToSuperview().offset(-170.5)
            $0.height.equalTo(14)
        }
        
        findAccountButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(28)
            $0.leading.equalTo(findAccountLabel.snp.trailing).offset(1)
        }
    }
    
    
    // MARK: - Actions
    
    // 텍스트가 비어있지 않은지 확인
    @objc
    private func checkTextField() {
        // 사용자가 앞 뒤에 공백, 줄바꿈 문자를 입력할 수 있기때문에 trimmingCharacters(in: .whitespacesAndNewlines)로 공백 제거
        
        let isIdEmailValid = !(idAndEmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        let isPasswordValid = !(passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        
        let isButtonEnabled = isIdEmailValid && isPasswordValid
        
        loginButton.isEnabled = isButtonEnabled
        
        loginButton.backgroundColor = isButtonEnabled ? .baeminMint500 : .baeminGray200
        
        clearPasswordButton.isHidden = passwordTextField.text?.isEmpty ?? true
    }
    
    // passwordField에 값이 입력되었을 때
    @objc
    private func textFieldDidChange(_ textField: UITextField) {
        if textField == passwordTextField {
            clearPasswordButton.isHidden = textField.text?.isEmpty ?? true
        }
    }
    
    //x 버튼 액션
    @objc
    private func clearPasswordButtonDidTap() {
        passwordTextField.text = ""
        checkTextField()
    }
    
    // 눈 버튼 액션
    @objc private func securityToggleButtonDidTap() {
        passwordTextField.isSecureTextEntry.toggle()
        let imageName = passwordTextField.isSecureTextEntry ? "eye-slash" : "eye"
        securityToggleButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
    // 로그인버튼 액션
    @objc
    private func loginButtonDidTap() {
        guard let idText = idAndEmailTextField.text,
              let passwordText = passwordTextField.text else { return }
        
        let trimmedId = idText.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPassword = passwordText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // 이메일 검사
        if !isValid(text: trimmedId, regex: emailRegex) {
            presentAlert(message: "이메일 형식이 달라요")
            return
        }
        
        // 비밀번호 유효성 검사
        if !isValid(text: trimmedPassword, regex: passwordRegex) {
            presentAlert(message: "비밀번호는 최소 8자 이상, 영문, 숫자, 특수문자를 포함해야 해요.")
            return
        }
        pushToWelcomeVC()
    }
    
    
    // MARK: - Functions
    
    // 아이디, 비번 필드 확인
    private func checkTextFieldIsEmpty() {
        idAndEmailTextField.addTarget(self, action: #selector(checkTextField), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(checkTextField), for: .editingChanged)
    }
    
    // 이메일, 비밀번호 유효성 검사
    private func isValid(text: String, regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: text)
    }
    
    // Alert 표시
    private func presentAlert(message: String) {
        let alert = UIAlertController(title: "입력 오류", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    // 환영합니다 뷰로 이동
    private func pushToWelcomeVC(){
        let vc = GreetingViewController()
        vc.id = idAndEmailTextField.text
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
