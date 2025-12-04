//
//  PopularRankLabelView.swift
//  sopt-kimsoomin-assignment
//
//  Created by mandoo on 11/11/25.
//

import UIKit
import SnapKit
import Then

final class PopularRankLabelView: UIView {
    
    // MARK: - UI Components
    
    private let titleStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 3
        $0.alignment = .center
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "우리 동네 한그릇 인기 랭킹"
        $0.textColor = .baeminBlack
        $0.font = .title_sb_18
    }
    
    private let infoButton = UIButton().then {
        $0.setImage(UIImage(named: "infoBlack"), for: .normal)
    }
    
    private let seeAllStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .center
    }
    
    private let seeAllLabel = UILabel().then {
        $0.text = "전체보기"
        $0.textColor = .baeminBlack
        $0.font = .body_r_14
    }
    
    private let seeAllButton = UIButton().then {
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .regular)
        let image = UIImage(systemName: "chevron.right", withConfiguration: symbolConfig)
        $0.setImage(image, for: .normal)
        $0.tintColor = .baeminBlack
    }
    
    // MARK: - Lify Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setUI(){
        addSubviews(titleStackView, seeAllStackView)
        
        titleStackView.addArrangedSubviews(titleLabel, infoButton)
        seeAllStackView.addArrangedSubviews(seeAllLabel, seeAllButton)
    }
    
    private func setLayout(){
        titleStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(18)
        }
        
        infoButton.snp.makeConstraints {
            $0.size.equalTo(16)
        }
        
        seeAllStackView.snp.makeConstraints {
            $0.centerY.equalTo(titleStackView)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}
