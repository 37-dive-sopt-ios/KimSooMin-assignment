//
//  FoodCategoryModel.swift
//  sopt-kimsoomin-assignment
//
//  Created by mandoo on 11/10/25.
//

import UIKit

struct FoodCategoryModel {
    let image: UIImage?
    let name: String
    
    public init(image: UIImage, name: String) {
        self.image = image
        self.name = name
    }
    
    static let mockData: [FoodCategoryModel] = [
        FoodCategoryModel(image: UIImage(named: "category1") ?? UIImage(), name: "한그릇"),
        FoodCategoryModel(image: UIImage(named: "category2") ?? UIImage(), name: "치킨"),
        FoodCategoryModel(image: UIImage(named: "category3") ?? UIImage(), name: "카페·디저트"),
        FoodCategoryModel(image: UIImage(named: "category4") ?? UIImage(), name: "피자"),
        FoodCategoryModel(image: UIImage(named: "category5") ?? UIImage(), name: "분식"),
        FoodCategoryModel(image: UIImage(named: "category6") ?? UIImage(), name: "고기"),
        FoodCategoryModel(image: UIImage(named: "category7") ?? UIImage(), name: "찜·탕"),
        FoodCategoryModel(image: UIImage(named: "category8") ?? UIImage(), name: "야식"),
        FoodCategoryModel(image: UIImage(named: "category9") ?? UIImage(), name: "패스트푸드"),
        FoodCategoryModel(image: UIImage(named: "category10") ?? UIImage(), name: "픽업"),
    ]
}
