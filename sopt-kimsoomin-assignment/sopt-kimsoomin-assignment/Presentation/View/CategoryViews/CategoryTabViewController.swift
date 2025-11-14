//
//  CategoryTabView.swift
//  sopt-kimsoomin-assignment
//
//  Created by mandoo on 11/10/25.
//

import UIKit
import Then
import SnapKit

final class CategoryTabView: UIView {
    
    // MARK: - Properties
    private let categories = ["음식배달", "픽업", "장보기·쇼핑", "선물하기", "혜택보기"]
    
    
    // MARK: - UI Components
    private let categoryStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 14
    }
    
    private let indicatorView = UIView().then {
        $0.backgroundColor = .black
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = .baeminGray200
    }
    
    
    // MARK: - Lify Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setLayout()
        configureCategories()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Layouts
    private func setLayout() {
        addSubviews(categoryStackView, indicatorView, lineView)
        
        categoryStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(18)
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().inset(19.5)
        }
        
        indicatorView.snp.makeConstraints {
            $0.height.equalTo(3)
            $0.top.equalTo(categoryStackView.snp.bottom).offset(10)
        }
        
        lineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(indicatorView.snp.bottom)
            $0.width.equalToSuperview()
        }
            
    }
    
    
    // MARK: - Functions
    private func configureCategories() {
        for (index, title) in categories.enumerated() {
            let button = UIButton().then {
                $0.setTitle(title, for: .normal)
                $0.titleLabel?.font = .head_b_18
                $0.titleLabel?.adjustsFontSizeToFitWidth = true
                if index == 0 {
                    $0.setTitleColor(.baeminBlack, for: .normal)
                }
                else {
                    $0.setTitleColor(.baeminGray300, for: .normal)
                }
            }
            categoryStackView.addArrangedSubview(button)
        }
        if let foodDelivery = categoryStackView.arrangedSubviews.first as? UIButton {
            updateIndicatorConstraints(for: foodDelivery)
        }
    }
    
    private func updateIndicatorConstraints(for button: UIButton) {
        indicatorView.snp.makeConstraints {
            $0.width.equalTo(button.snp.width)
            $0.centerX.equalTo(button.snp.centerX)
        }
    }
}
