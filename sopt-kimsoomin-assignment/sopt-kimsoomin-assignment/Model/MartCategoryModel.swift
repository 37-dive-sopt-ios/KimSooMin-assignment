//
//  MartCategoryModel.swift
//  sopt-kimsoomin-assignment
//
//  Created by mandoo on 11/11/25.
//

import UIKit

struct MartCategoryModel {
    let image: UIImage?
    let name: String
    
    public init(image: UIImage, name: String) {
        self.image = image
        self.name = name
    }
    
    static let mockData: [MartCategoryModel] = [
        MartCategoryModel(image: UIImage(named: "mart1") ?? UIImage(), name: "B마트"),
        MartCategoryModel(image: UIImage(named: "mart2") ?? UIImage(), name: "CU"),
        MartCategoryModel(image: UIImage(named: "mart3") ?? UIImage(), name: "이마트슈퍼"),
        MartCategoryModel(image: UIImage(named: "mart4") ?? UIImage(), name: "홈플러스"),
        MartCategoryModel(image: UIImage(named: "mart5") ?? UIImage(), name: "GS25"),
    ]
}
