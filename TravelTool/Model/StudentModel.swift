//
//  StudentModel.swift
//  TravelTool
//
//  Created by Andrea Tongsak on 7/29/19.
//  Copyright © 2019 Andrea Tongsak. All rights reserved.
//

import Foundation
import MapKit

// holds collection of key/value pairs for Student Location
// Credit/Referance: Udacity - ParseAPI: What is a Student Location?
struct Student: Codable {
    let objectId: String?
    let uniqueKey: String?
    let firstName: String?
    let lastName: String?
    let mapString: String?
    let mediaURL: String?
    let latitude: Double?
    let longitude: Double?
    // let createdAt: Date?
    // let updatedAt: Date?
    // let ACL: ACL?
    
    func fullName() -> String {
        return (firstName ?? "") + " " + (lastName ?? "")
    }
}
