//
//  LocationPhoto.swift
//  TravelTool
//
//  Created by Andrea Tongsak on 7/31/19.
//  Copyright © 2019 Andrea Tongsak. All rights reserved.
//

import Foundation

struct LocationPhoto: Codable {
    let photos: Photos
    let stat: String
}

struct Photos: Codable {
    let page: Int
    let pages: Int
    let perPage: Int
    let total: String
    let photo: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case page, pages, total, photo
        case perPage = "perpage"
    }
}

struct Photo: Codable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    

}

