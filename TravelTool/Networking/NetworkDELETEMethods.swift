//
//  NetworkDELETEMethods.swift
//  TravelTool
//
//  Created by Andrea Tongsak on 7/29/19.
//  Copyright © 2019 Andrea Tongsak. All rights reserved.
//

import Foundation
import UIKit

extension NetworkLayer{
    private static func deleteData(method: String, parameters: [String:AnyObject],  completionHandler: @escaping(_ success:Bool, _ data: Data?, _ error: NSError?) -> Void){
        
        let request = NSMutableURLRequest(url: self.onTheMapURLFromParameters(parameters, withPathExtension: method))
        request.httpMethod = "DELETE"
        
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        
        let task = NetworkLayer.shared().session.dataTask(with: request as URLRequest) { (data, response, error) in
            let(success, _) = NetworkChecker.checkForDataResponse(functionName: "deleteData", data: data, response: response, error: error)
            
            if success{
                completionHandler(true, data, nil)
            }else {
                if let error = error{
                    completionHandler(false, nil, error as NSError)
                } else {
                    completionHandler(false, nil, "Failed to logged out correctly.".toNSError(in: "deleteData"))
                }
            }
        }
        
        task.resume()
    }
    
    // delete the created session for the logged in student.
    public static func deleteCurrentStudentSession(completionHandler: @escaping(_ success:Bool, _ data: Data?, _ error: NSError?) -> Void){
        let parameters = [String: AnyObject]()
        let method = Methods.UdacityAuthentication
        deleteData(method: method, parameters: parameters){ (success, data, error) in
            if success{
                completionHandler(true, data, nil)
            } else {
                completionHandler(false, nil, error)
            }
        }
    }
}
