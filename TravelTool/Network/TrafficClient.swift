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
        static let details = "/2cer-njie.json"
        
        case allParkAddresses
        case allParksWithDetails
        case parkDetails(String)
        case flickrPhotoSearch(String, String, Int, String)
        
        var stringValue: String {
            switch self {
            case .allParkAddresses:
                return Endpoints.base + "/v5tj-kqhc.json"
            case .allParksWithDetails:
                return Endpoints.base + Endpoints.details
            case .parkDetails(let parkId):
                return Endpoints.base + Endpoints.details + "?pmaid=\(parkId)"
            case .flickrPhotoSearch(let lat, let lon, let page, let text):
                return "https://api.flickr.com/services/rest?method=flickr.photos.search&extras=url_l&api_key=4e17e4dda249815c53b3700489d74270&lat=\(lat)&lon=\(lon)&per_page=1&page=\(page)&format=json&nojsoncallback=1&text=\(text)"
            }
            
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    // MARK: Helper function for GET Requests
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        print(request)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            do {
                let response = try JSONDecoder().decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(response, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    // MARK: Get all traffic to populate Map View
    
    class func getAllTraffic(completion: @escaping ([LocationDetails]?, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.allParkAddresses.url, responseType: [LocationDetails].self) {
            (response, error) in
            if let response = response {
                completion(response, nil)
            } else {
                completion([], error)
            }
        }
    }
    
    // MARK: Get specific park for Detail View
    
    class func getTrafficDetails(parkId: String, completion: @escaping ([LocationDetails]?, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.parkDetails(parkId).url, responseType: [LocationDetails].self) {
            (response, error) in
            if let response = response {
                completion(response, nil)
            } else {
                completion([], error)
            }
        }
    }
    
    
    // MARK: Get Flickr Photo for Detail View
    
    class func getRandomFlickrPhoto(lat: String, lon: String, page: Int, text: String, completion: @escaping (Photos?, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.flickrPhotoSearch(lat, lon, page, text).url, responseType: LocationPhoto.self) { (response, error) in
            if let response = response {
                print("Park photo response: \(response.photos)")
                completion(response.photos, nil)
            } else {
                completion(nil, error)
            }
        }
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
