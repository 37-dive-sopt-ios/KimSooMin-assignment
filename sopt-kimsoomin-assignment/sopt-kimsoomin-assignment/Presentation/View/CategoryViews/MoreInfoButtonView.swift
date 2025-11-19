//
//  MoreInfoView.swift
//  sopt-kimsoomin-assignment
//
//  Created by mandoo on 11/11/25.
//


import UIKit
import Then
import SnapKit

final class MoreInfoView: UIView {
    
    // MARK: - UI Components
    
    private let MoreInfoStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
    }
    
    private let foodDeliveryLabel = UILabel().then {
        $0.text = "음식배달"
        $0.textColor = .baeminBlack
        $0.font = .head_b_14
        $0.adjustsFontSizeToFitWidth = true
    }
    
    private let moreLabel = UILabel().then {
        $0.text = "에서 더보기 "
        $0.textColor = .baeminBlack
        $0.font = .body_r_14
    }
    
    private let moreButton = UIButton().then {
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .regular)
        let image = UIImage(systemName: "chevron.right", withConfiguration: symbolConfig)
        $0.setImage(image, for: .normal)
        $0.tintColor = .black
    }
    
    // MARK: - Lify Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setUI() {
        addSubview(MoreInfoStackView)
        
        MoreInfoStackView.addArrangedSubviews(foodDeliveryLabel,moreLabel,moreButton)
    }
    
    private func setLayout() {
        MoreInfoStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().offset(5)
            $0.centerX.equalToSuperview()
        }
    }
}

