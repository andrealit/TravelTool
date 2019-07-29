//
//  StudentLocations.swift
//  TravelTool
//
//  Created by Andrea Tongsak on 7/29/19.
//  Copyright © 2019 Andrea Tongsak. All rights reserved.
//

import Foundation

struct StudentsLocations {
    static var shared = StudentsLocations()
    private init () {}
    var students = [Student]()
}
