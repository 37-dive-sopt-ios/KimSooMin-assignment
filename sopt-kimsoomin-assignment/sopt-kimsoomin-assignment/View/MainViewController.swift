//
//  MainViewController.swift
//  sopt-kimsoomin-assignment
//
//  Created by mandoo on 11/9/25.
//

import UIKit
import Then
import SnapKit

final class MainViewController: UIViewController {
    // MARK: - Properties
    
    // MARK: - UI Components
    
    private let addressLabel = UILabel().then {
        $0.text = "우리집"
        $0.textColor = .baeminBlack
        $0.font = .head_b_16
    }
    
    private let addressDetailButton = UIButton().then {
        $0.setImage(UIImage(named: "polygon"), for: .normal)
    }
    
    private let personalButtonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 3
        $0.alignment = .center
    }
    
    private lazy var discountButton = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "discount"), for: .normal)
    }
    
    private lazy var notifyButton = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "bell"), for: .normal)
    }
    
    private lazy var cartButton = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "cart"), for: .normal)
    }
    
    // MARK: - Lify Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setLayout()
        
    }
    
    // MARK: - Layouts
    
    private func setLayout() {
        view.addSubviews(addressLabel,addressDetailButton,personalButtonStackView)
        
        personalButtonStackView.addArrangedSubviews(discountButton, notifyButton, cartButton)
        
        addressLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(54)
            $0.leading.equalToSuperview().inset(20)
        }
        
        addressDetailButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(63.5)
            $0.leading.equalTo(addressLabel.snp.trailing).offset(3)
            $0.height.equalTo(5)
            $0.width.equalTo(8)
        }
        
        discountButton.snp.makeConstraints {
            $0.size.equalTo(24)
        }
        
        notifyButton.snp.makeConstraints {
            $0.size.equalTo(24)
        }
        
        cartButton.snp.makeConstraints {
            $0.size.equalTo(24)
        }
        
        personalButtonStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(54)
            $0.trailing.equalToSuperview().inset(16)
        }
        
    }
    
    // MARK: - Actions
    
    // MARK: - Functions
}
