//
//  PopularRankCell.swift
//  sopt-kimsoomin-assignment
//
//  Created by mandoo on 11/11/25.
//

import UIKit
import SnapKit
import Then

final class PopularRankCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "PopularRankCollectionViewCell"
    
    
    // MARK: - UI Components
    private let image = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    private let restaurantNameLabel = UILabel().then {
        $0.textColor = .baeminGray600
        $0.font = .body_r_12
        $0.textAlignment = .left
    }
    
    private let starRatingStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 2
        $0.alignment = .center
    }
    
    private let starIcon = UIImageView().then {
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 10, weight: .regular)
        let image = UIImage(systemName: "star.fill", withConfiguration: symbolConfig)
        $0.tintColor = .starYellow
        $0.image = image
    }
    
    private let starRateLabel = UILabel().then {
        $0.font = .body_r_12
        $0.textColor = .baeminGray600
    }
    
    private let reviewCountLabel = UILabel().then {
        $0.font = .body_r_12
        $0.textColor = .baeminGray600
    }
    
    private let menuNameLabel = UILabel().then {
        $0.font = .body_r_14
        $0.textColor = .baeminBlack
    }
    
    private let priceInfoStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 6
        $0.alignment = .center
    }
    
    private let percentOffLabel = UILabel().then {
        $0.font = .head_b_14
        $0.textColor = .baeminRed
    }
    
    private let newPriceLabel = UILabel().then {
        $0.font = .head_b_14
        $0.textColor = .baeminBlack
    }
    
    private let oldPriceLabel = UILabel().then {
        $0.font = .body_r_12
        $0.textColor = .baeminGray600
    }
    
    private let minimumPriceLabel = UILabel().then {
        $0.font = .head_b_13
        $0.textColor = .baeminPurple
    }
    
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Layouts
    private func setLayout() {
        
        contentView.addSubviews(image, restaurantNameLabel, starRatingStackView, reviewCountLabel, menuNameLabel, priceInfoStackView, oldPriceLabel, minimumPriceLabel)
        
        starRatingStackView.addArrangedSubviews(starIcon,starRateLabel)
        
        priceInfoStackView.addArrangedSubviews(percentOffLabel, newPriceLabel)
        
        image.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.size.equalTo(145)
        }
        
        restaurantNameLabel.snp.makeConstraints {
            $0.top.equalTo(image.snp.bottom).offset(10)
            $0.leading.equalToSuperview()
            $0.width.equalTo(70)
        }
        
        reviewCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(starRatingStackView)
            $0.trailing.equalTo(image.snp.trailing)
        }
        
        starRatingStackView.snp.makeConstraints {
            $0.centerY.equalTo(restaurantNameLabel)
            $0.trailing.equalTo(reviewCountLabel.snp.leading).offset(-4)
        }
        
        menuNameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(restaurantNameLabel.snp.bottom).offset(6)
            $0.width.equalTo(145)
        }
        
        priceInfoStackView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(menuNameLabel.snp.bottom).offset(6)
        }
        
        oldPriceLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(priceInfoStackView.snp.bottom).offset(6)
        }
        
        minimumPriceLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(oldPriceLabel.snp.bottom).offset(6)
        }
    }
    
    
    // MARK: - Configuration
    func configure(with model: PopularRankModel) {
        reviewCountLabel.text = "(\(model.review))"
        image.image = model.image
        restaurantNameLabel.text = model.restaurantName
        starRateLabel.text = "\(model.rate)"
        menuNameLabel.text = model.menuName
        percentOffLabel.text = "\(model.percentOff)"
        newPriceLabel.text = "\(model.newPrice)"
        
        let oldPriceString = "\(model.oldPrice)"
        oldPriceLabel.applyStrikethrough(text: oldPriceString)
        
        minimumPriceLabel.text = "최소주문금액 없음"
    }
}

extension UILabel {
    func applyStrikethrough(text: String?) {
        guard let text = text else {
            self.attributedText = nil
            return
        }
        let attributedString = NSMutableAttributedString(string: text)
        
        let range = NSRange(location: 0, length: text.utf16.count)
        
        attributedString.addAttributes([
            .strikethroughStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: self.textColor ?? .black,
            .font: self.font ?? .systemFont(ofSize: 12)
        ], range: range)
        self.attributedText = attributedString
    }
}
