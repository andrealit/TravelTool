//
//  StudentConstants.swift
//  TravelTool
//
//  Created by Andrea Tongsak on 7/29/19.
//  Copyright © 2019 Andrea Tongsak. All rights reserved.
//

import Foundation

struct StudentConstants {
    static let ApiScheme = "https"
    static let ApiHost = "onthemap-api.udacity.com"
    static let ApiPath = "/v1"
    
    static let Login: URL! = URL(string: "https://auth.udacity.com/sign-in?next=https://classroom.udacity.com/authenticated")
    
    static let headers = ["content-type": "application/json"]
    
    // MARK: NotificationKeys
    
    struct NotificationKeys {
        static let SignedIn = "onSignInCompleted"
    }
    
    // MARK: MessageFields
    
    struct MessageFields {
        static let name = "name"
        static let text = "text"
        static let imageUrl = "photoUrl"
    }
}

struct Methods {
    static let StudentLocation = "/StudentLocation"
    //static let StudentInformation = "/users/" + (NetworkLayer.shared().sessionID ?? "")
    
    static let UdacityAuthentication = "/session"
}

struct ParametersKeys {
    static let Order = "order"
    static let Limit = "limit"
}

struct ParametersValues {
    static let Order = "-updatedAt" as AnyObject
    static let Limit = "100" as AnyObject
}

