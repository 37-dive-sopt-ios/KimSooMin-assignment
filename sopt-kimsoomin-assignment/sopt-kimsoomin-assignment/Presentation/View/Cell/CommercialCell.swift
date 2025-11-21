//
//  CommercialCell.swift
//  sopt-kimsoomin-assignment
//
//  Created by mandoo on 11/11/25.
//

import UIKit
import SnapKit
import Then

final class CommercialCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "CommercialCollectionViewCell"
    
    // MARK: - UI Components
    
    private let image = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(image)
        image.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
    func configure(with model: CommercialModel) {
        image.image = model.image
    }
}
