//
//  StudentSerialization.swift
//  TravelTool
//
//  Created by Andrea Tongsak on 7/29/19.
//  Copyright © 2019 Andrea Tongsak. All rights reserved.
//

import Foundation

struct StudentsResults: Decodable {
    let results: [Student]?
}

struct StudentInformation: Decodable {
    let first_name: String?
    let last_name: String?
    let key: String?
}
