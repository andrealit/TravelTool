//
//  NetworkPOSTMethods.swift
//  TravelTool
//
//  Created by Andrea Tongsak on 7/29/19.
//  Copyright © 2019 Andrea Tongsak. All rights reserved.
//

import Foundation
import UIKit

extension NetworkLayer{
    
    // postData is used for every POST request
    private static func postData(method: String, parameters: [String:AnyObject], jsonBody: Data, completionHandler: @escaping(_ success:Bool, _ data: Data?, _ error: NSError?) -> Void) {
        
        let request = NSMutableURLRequest(url: self.onTheMapURLFromParameters(parameters, withPathExtension: method))
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = Constants.headers
        request.httpBody = jsonBody
        
        let task = NetworkLayer.shared().session.dataTask(with: request as URLRequest) { (data, response, error) in let(success, _) = NetworkChecker.checkForDataResponse(functionName: "postData", data: data, response: response, error: error)
            
            if success {
                completionHandler(true, data, nil)
            } else {
                if let error = error {
                    completionHandler(false, nil, error as NSError)
                } else {
                    completionHandler(false, nil, "Invalid username or password.".toNSError(in: "postData"))
                }
            }
        }
        task.resume()
    }
    
    
    public static func authenticateForUdacity(credentials: UdacityUserCredentials, completionHandler: @escaping(_ success:Bool, _ error: NSError?) -> Void){
        
        let parameters = [String : AnyObject]()
        let method = Methods.UdacityAuthentication
        let udacitySession = UdacitySession(credentials: credentials)
        let jsonBody: Data?
        
        do {
            jsonBody = try JSONEncoder().encode(udacitySession)
        } catch let error {
            completionHandler(false, error as NSError)
            return
        }
        
        self.postData(method: method, parameters: parameters, jsonBody: jsonBody!){ (success, data, error) in
            
            guard success == true else{
                completionHandler(false, error!)
                return
            }
            
            do{
                let udacityResponse = try JSONDecoder().decode(UdacitySessionResponse.self, from: data!.JSONData())
                let (isValid, error) = udacityResponse.isValid()
                if isValid{
                    NetworkLayer.shared().sessionID = udacityResponse.session?.id
                    NetworkLayer.shared().userKey = (udacityResponse.account?.key)!
                    completionHandler(true, nil)
                } else {
                    completionHandler(false, error!)
                }
            } catch let error {
                completionHandler(false, error as NSError)
            }
        }
    }
    
    // For posting student data:
    // 1- get the student data
    // 2- overwrite the student firstname & lastname & ... because it maybe nil for the first time
    // 3- post the student data
    public static func postLocation(for studentInfoFromClientSide: Student, completionHandler: @escaping(_ success:Bool, _ error: NSError?) -> Void){
        
        NetworkLayer.getStudentData(){ (success, studentInfoFromServerSide, error) in
            if success{
                let parameters = [String : AnyObject]()
                let method = Methods.StudentLocation
                let jsonBody: Data?
                let completeStudentInfo = self.completeStudentInfo(from: studentInfoFromClientSide, and: studentInfoFromServerSide!)
                do{
                    jsonBody = try JSONEncoder().encode(completeStudentInfo)
                    self.postData(method: method, parameters: parameters, jsonBody: jsonBody!) {
                        (success, data, error) in
                        if success {
                            completionHandler(true, nil)
                        } else {
                            completionHandler(false, error!)
                        }
                    }
                } catch let error{
                    completionHandler(false, error as NSError)
                }
            } else {
                completionHandler(false, error)
            }
        }
    }
    
    private static func completeStudentInfo(from studentInfoFromClientSide: Student , and studentInfoFromServerSide: Student) -> Student{
        let completeStudentInfo = Student(objectId: nil,
                                          uniqueKey: NetworkLayer.shared().userKey,
                                          firstName: studentInfoFromServerSide.firstName,
                                          lastName: studentInfoFromServerSide.lastName,
                                          mapString: studentInfoFromClientSide.mapString,
                                          mediaURL: studentInfoFromClientSide.mediaURL,
                                          latitude: studentInfoFromClientSide.latitude,
                                          longitude: studentInfoFromClientSide.longitude)
        return completeStudentInfo
    }
}
