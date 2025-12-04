//
//  CategoryProtocol.swift
//  sopt-kimsoomin-assignment
//
//  Created by mandoo on 11/11/25.
//

import UIKit

protocol CategoryData {
    var image: UIImage? { get }
    var name: String { get }
}

extension FoodCategoryModel: CategoryData {}
extension MartCategoryModel: CategoryData {}
