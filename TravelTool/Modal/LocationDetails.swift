//
//  LocationDetails.swift
//  TravelTool
//
//  Created by Andrea Tongsak on 7/31/19.
//  Copyright © 2019 Andrea Tongsak. All rights reserved.
//

import Foundation

struct LocationDetails: Codable {
    let pmaid, name, featureId, featureDesc, youthOnly, lighting: String
    let altName, xpos, ypos, hours, childDesc, fieldType: String?
    let location2: Location2?
    
    enum CodingKeys: String, CodingKey {
        case pmaid, name, xpos, ypos, hours, lighting
        case altName = "alt_name"
        case featureId = "feature_id"
        case featureDesc = "feature_desc"
        case childDesc = "child_desc"
        case fieldType = "field_type"
        case youthOnly = "youth_only"
        case location2 = "location_2"
    }
}

struct Location2: Codable {
    let latitude, longitude: String
    let humanAddress: HumanAddress
    
    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case humanAddress = "human_address"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try container.decode(String.self, forKey: .latitude)
        longitude = try container.decode(String.self, forKey: .longitude)
        let dataString = try container.decode(String.self, forKey: .humanAddress)
        humanAddress = try JSONDecoder().decode(HumanAddress.self, from: Data(dataString.utf8))
    }
}

struct HumanAddress: Codable {
    let address, city, state, zip: String
}
