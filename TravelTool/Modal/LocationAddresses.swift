//
//  LocationAddresses.swift
//  TravelTool
//
//  Created by Andrea Tongsak on 8/1/19.
//  Copyright © 2019 Andrea Tongsak. All rights reserved.
//

import Foundation

struct LocationAddresses: Codable {
    let pmaid: String
    let locid: String
    let name: String
    let address: String
    let zipCode: String?
    let xCoord: String?
    let yCoord: String?
    let location1: Location1?
    let computedRegionq256_3sug: String?
    let computedRegionkuhn_3gp2: String?
    let computedRegion_ru88_fbhk: String?
    
    enum CodingKeys: String, CodingKey {
        case pmaid, locid, name, address
        case zipCode = "zip_code"
        case xCoord = "x_coord"
        case yCoord = "y_coord"
        case location1 = "location_1"
        case computedRegionq256_3sug = ":@computed_region_q256_3sug:"
        case computedRegionkuhn_3gp2 = ":@computed_region_kuhn_3gp2:"
        case computedRegion_ru88_fbhk = ":@computed_region_ru88_fbhk:"
    }
}

struct Location1: Codable {
    let latitude: String
    let longitude: String
}
