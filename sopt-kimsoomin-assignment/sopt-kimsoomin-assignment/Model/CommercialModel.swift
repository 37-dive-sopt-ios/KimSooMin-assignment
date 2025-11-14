//
//  CommercialMode.swift
//  sopt-kimsoomin-assignment
//
//  Created by mandoo on 11/11/25.
//

import UIKit

struct CommercialModel {
    let image: UIImage?
    
    static let mockData: [CommercialModel] = [
        CommercialModel(image: UIImage(named: "com1") ?? UIImage()),
        CommercialModel(image: UIImage(named: "com2") ?? UIImage()),
        CommercialModel(image: UIImage(named: "com3") ?? UIImage()),
    ]
}
