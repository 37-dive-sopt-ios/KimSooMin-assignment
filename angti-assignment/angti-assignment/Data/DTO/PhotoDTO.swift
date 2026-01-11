//
//  PhotoDTO.swift
//  angti-assignment
//
//  Created by mandoo on 1/10/26.
//

struct PhotoDTO: Decodable {
    let id: String
    let url: String
    let width: Int
    let height: Int
    
    func toDomain() -> Photo {
        return .init(id: id, url: url, width: width, height: height)
    }
}
