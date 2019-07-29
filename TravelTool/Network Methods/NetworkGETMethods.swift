//
//  NetworkGETMethods.swift
//  TravelTool
//
//  Created by Andrea Tongsak on 7/29/19.
//  Copyright © 2019 Andrea Tongsak. All rights reserved.
//

import MapKit

class NetworkLayer {
    // MARK: Properties
    
    // shared session
    var session = URLSession.shared
    
    // authentication state
    var sessionID: String? = nil
    var userKey = ""
    var userName = ""
    
    // MARK: Shared Instance
    class func shared() -> NetworkLayer {
        struct Singleton {
            static var shared = NetworkLayer()
        }
        return Singleton.shared
    }
    
    
    //MARK: GET Methods
    
    // getData is a generic method
    // 'On The Map' GET method should use it.
    private static func getData(method: String, parameters: [String:AnyObject], completionHandler: @escaping(_ success:Bool, _ data: Data?, _ error: NSError?) -> Void){
        let request = URLRequest(url: self.onTheMapURLFromParameters(parameters, withPathExtension: method))
        
        let task = self.shared().session.dataTask(with: request){ (data, response, error) in
            let (success, error) = NetworkChecker.checkForDataResponse(functionName: "getData", data: data, response: response, error: error)
            
            if success{
                completionHandler(true, data!, nil)
            }else {
                completionHandler(false, nil, error)
            }
        }
        task.resume()
    }
    
    public static func getStudentLocations(completionHandler: @escaping(_ success:Bool, _ students:[Student]?, _ error: NSError?) -> Void){
        
        let parameters = [ParametersKeys.Order : ParametersValues.Order,
                          ParametersKeys.Limit : ParametersValues.Limit]
        let method = Methods.StudentLocation
        
        self.getData(method: method, parameters: parameters){ (success, data, error) in
            if success{
                do{
                    let studentsResults = try JSONDecoder().decode(StudentsResults.self, from: data!)
                    completionHandler(true, studentsResults.results!, nil)
                }catch let error{
                    completionHandler(false, nil, error as NSError)
                }
            }else {
                completionHandler(false, nil, error)
            }
        }
    }
    
    public static func getStudentData(completionHandler: @escaping(_ success:Bool, _ student:Student?, _ error: NSError?) -> Void){
        
        let parameters = [String : AnyObject]()
        let method = Methods.StudentInformation
        
        self.getData(method: method, parameters: parameters){ (success, data, error) in
            if success{
                do {
                    let studentInformation = try JSONDecoder().decode(StudentInformation.self, from: data!.JSONData())
                    let student = Student(objectId: nil, uniqueKey: nil, firstName: studentInformation.first_name, lastName: studentInformation.last_name, mapString: nil, mediaURL: nil, latitude: nil, longitude: nil)
                    completionHandler(true, student, nil)
                } catch let error{
                    completionHandler(false, nil, error as NSError)
                }
            } else {
                completionHandler(false, nil, error)
            }
        }
    }
    
}
