//
//  TrafficClient.swift
//  TravelTool
//
//  Created by Andrea Tongsak on 7/31/19.
//  Copyright © 2019 Andrea Tongsak. All rights reserved.
//

import Foundation

class TrafficClient {
    enum Endpoints {
        static let base = "https://data.seattle.gov/resource"
        static let details = ""
        
        var stringValue: String {
            switch self {
                
            }
        }
    }
    
    // MARK: Get Flickr Photo for Detail View
    
    class func getRandomFlickrPhoto() {
        
    }
    
    // MARK: Download photos
    
    class func downloadPhoto(photoUrl: URL, completion: @escaping (Data?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: photoUrl) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                print("no data, or there was an error")
                return
            }
            completion(data, nil)
        }
        task.resume()
    }
}
