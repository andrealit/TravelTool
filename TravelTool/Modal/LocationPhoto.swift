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
    let farm: Int
    let title: String
    let isPublic: Int
    let isFriend: Int
    let isFamily: Int
    let urlL: String
    
    enum CodingKeys: String, CodingKey {
        case id, owner, secret, server, farm, title
        case isPublic = "ispublic"
        case isFriend = "isfriend"
        case isFamily = "isfamily"
        case urlL = "url_l"
    }

}

