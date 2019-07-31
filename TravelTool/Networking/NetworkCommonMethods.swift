//
//  NetworkCommonMethods.swift
//  TravelTool
//
//  Created by Andrea Tongsak on 7/29/19.
//  Copyright © 2019 Andrea Tongsak. All rights reserved.
//

import Foundation

extension NetworkLayer{
    
    // create URL from params
    public static func onTheMapURLFromParameters(_ parameters: [String:AnyObject], withPathExtension: String? = nil) -> URL {
        var components = URLComponents()
        components.scheme = StudentConstants.ApiScheme
        components.host = StudentConstants.ApiHost
        components.path = StudentConstants.ApiPath + (withPathExtension ?? "")
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters{
            components.queryItems?.append(URLQueryItem(name: key, value: "\(value)"))
        }
        
        return components.url!
    }
}
