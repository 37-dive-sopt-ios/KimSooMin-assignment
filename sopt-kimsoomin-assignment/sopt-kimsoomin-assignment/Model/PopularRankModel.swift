//
//  PopularRankModel.swift
//  sopt-kimsoomin-assignment
//
//  Created by mandoo on 11/11/25.
//

import UIKit

struct PopularRankModel {
    let image: UIImage?
    let restaurantName: String
    let rate: Double
    let review: String
    let menuName: String
    let percentOff: String
    let newPrice: String
    let oldPrice: String
    
    static let mockData: [PopularRankModel] = [
        PopularRankModel(image: UIImage(named: "rank1") ?? UIImage(), restaurantName: "니들이 곱도리탕 맛을 알어 군자점", rate: 4.9, review: "2,559", menuName: "[가성비] 1인 닭도리탕", percentOff: "20%", newPrice: "11,800원", oldPrice: "14,800원"),
        PopularRankModel(image: UIImage(named: "rank2") ?? UIImage(), restaurantName: "짜글이미식회 광진점", rate: 5, review: "3,362", menuName: "[고추장] 묵은지짜글이", percentOff: "20%", newPrice: "11,900원", oldPrice: "14,900원"),
        PopularRankModel(image: UIImage(named: "rank3") ?? UIImage(), restaurantName: "샐러리아 샐러드&포케 화양건대점", rate: 5.0, review: "1,718", menuName: "훈제오리 포케", percentOff: "15%", newPrice: "11,400원", oldPrice: "13,500원"),
        PopularRankModel(image: UIImage(named: "rank4") ?? UIImage(), restaurantName: "미친피자 건대본점", rate: 4.9, review: "8,755", menuName: "(P) 한판에 두가지맛피자", percentOff: "20%", newPrice: "11,900원", oldPrice: "14,900원")
    ]
}
