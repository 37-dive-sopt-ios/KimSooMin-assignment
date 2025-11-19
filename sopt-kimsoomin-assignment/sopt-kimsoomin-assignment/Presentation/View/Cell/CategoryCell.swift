//
//  CategoryCell.swift
//  sopt-kimsoomin-assignment
//
//  Created by mandoo on 11/11/25.
//

import UIKit
import SnapKit
import Then

final class CategoryCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier: String = "CategoryCell"
    
    // MARK: - UI Components
    
    private let iconImageView = UIImageView().then {
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }
    
    private let nameLabel = UILabel().then {
        $0.font = .body_r_14
        $0.textColor = .baeminBlack
        $0.textAlignment = .center
        $0.adjustsFontSizeToFitWidth = true
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setUI() {
        contentView.addSubviews(iconImageView, nameLabel)
    }
    
    private func setLayout() {
        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.size.equalTo(58)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview().inset(2)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Configuration
    
    public func configure(category: CategoryData) {
        iconImageView.image = category.image
        nameLabel.text = category.name
    }
}
