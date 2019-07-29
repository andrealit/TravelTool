//
//  NetworkValidCheck.swift
//  TravelTool
//
//  Created by Andrea Tongsak on 7/29/19.
//  Copyright © 2019 Andrea Tongsak. All rights reserved.
//

import Foundation

class NetworkChecker {
    public static func checkForDataResponse(functionName: String, data: Data?, response: URLResponse?, error: Error?) -> (Bool, NSError?){
        func sendError(error: String) -> (Bool, NSError?){
            let userInfo = [NSLocalizedDescriptionKey : error]
            return(false, NSError(domain: functionName, code: 1, userInfo: userInfo))
        }
        
        // GUARD: Error in parsing
        guard error == nil else{
            return sendError(error: "Error occurred while getting the data, error message: \(error!)")
        }
        
        // GUARD: Did we get a successful 2XX response?
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
            return sendError(error: "Your request returned a status code other than 2xx!")
        }
        
        // GUARD: Did we get a not empty data
        guard data != nil else{
            return sendError(error: "Empty data is found!")
        }
        
        return (true, nil)
    }
}
