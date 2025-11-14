//
//  HeaderView.swift
//  sopt-kimsoomin-assignment
//
//  Created by mandoo on 11/9/25.
//

import UIKit
import Then
import SnapKit

final class HeaderView: UIView {
    
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
    
    private let searchTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: "찾아라! 맛있는 음식과 맛집", attributes: [NSAttributedString.Key.foregroundColor : UIColor.baeminGray300])
        $0.borderStyle = .none
        $0.layer.borderColor = UIColor.baeminBlack.cgColor
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 20
        $0.font = .body_r_14
        $0.textColor = .baeminBlack
        $0.addLeftPadding(17)
    }
    
    private lazy var searchButton = UIButton().then {
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
        let image = UIImage(systemName: "magnifyingglass", withConfiguration: symbolConfig)
        $0.setImage(image, for: .normal)
        $0.tintColor = .baeminGray700
    }
    
    private let bMartImage = UIImageView().then {
        $0.image = UIImage(named: "bMart")
    }
   
    private let coupondiscountStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 2
        $0.alignment = .leading
    }
    
    private let coupondiscountLabel = UILabel().then {
        $0.text = "전상품 쿠폰팩 + 60%특가"
        $0.textColor = .baeminBlack
        $0.font = .head_b_16
    }
    
    private let coupondiscountButton = UIButton().then {
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .regular)
        let image = UIImage(systemName: "chevron.right", withConfiguration: symbolConfig)
        $0.setImage(image, for: .normal)
        $0.tintColor = .black
    }
    
    
    // MARK: - Lify Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Layouts
    private func setLayout() {
        addSubviews(addressLabel,addressDetailButton,personalButtonStackView,searchTextField,searchButton, bMartImage, coupondiscountStackView)
        
        personalButtonStackView.addArrangedSubviews(discountButton, notifyButton, cartButton)
        coupondiscountStackView.addArrangedSubviews(coupondiscountLabel,coupondiscountButton)
        
        
        addressLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(13)
            $0.leading.equalToSuperview().inset(20)
        }
        
        addressDetailButton.snp.makeConstraints {
            $0.centerY.equalTo(addressLabel)
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
            $0.top.equalToSuperview().offset(9)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(addressLabel.snp.bottom).offset(10)
            $0.height.equalTo(40)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }

        searchButton.snp.makeConstraints {
            $0.trailing.equalTo(searchTextField.snp.trailing).inset(17)
            $0.centerY.equalTo(searchTextField)
        }
        
        bMartImage.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(16)
            $0.width.equalTo(50)
        }
        
        coupondiscountStackView.snp.makeConstraints {
            $0.top.equalTo(bMartImage.snp.bottom).offset(6)
            $0.leading.equalToSuperview().inset(16)
        }
    }
}
