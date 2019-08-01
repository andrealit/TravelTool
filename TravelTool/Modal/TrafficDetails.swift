//
//  TrafficDetails.swift
//  TravelTool
//
//  Created by Andrea Tongsak on 7/31/19.
//  Copyright © 2019 Andrea Tongsak. All rights reserved.
//

import Foundation

struct TrafficDetails: Codable {
    let pmaid: String
    let locid: String
    let name: String
    let address: String
    let zipCode: String?
    let xCoord: String?
    let yCoord: String
    let location1: Location1?
    
    enum CodingKeys: String, CodingKey {
        case pmaid, locid, name, address
        case zipCode = "zip_code"
        case xCoord = "x_coord"
        case yCoord = "y_coord"
        case location1 = "location_1"
    }
}

struct Location1: Codable {
    let latitude: String
    let longitude: String
}
