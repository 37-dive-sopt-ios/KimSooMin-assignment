//
//  UIView+.swift
//  sopt-kimsoomin-assignment
//
//  Created by mandoo on 10/31/25.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
