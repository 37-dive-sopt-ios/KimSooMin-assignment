//
//  UIStackView+.swift
//  sopt-kimsoomin-assignment
//
//  Created by mandoo on 11/8/25.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
