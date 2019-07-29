//
//  UdacitySerialization.swift
//  TravelTool
//
//  Created by Andrea Tongsak on 7/29/19.
//  Copyright © 2019 Andrea Tongsak. All rights reserved.
//

import Foundation

struct UdacitySessionResponse: Decodable {
    let account: Account?
    let session: Session?
    
    let status: Int?
    let error: String?
    
    func isValid() -> (Bool, NSError?) {
        
        // Guard account existance, otherwise not valid
        guard account != nil else{
            return (false, "Invalid account credentials.".toNSError(in: "UdacitySessionResponse"))
        }
        
        // Guard session.id existance, otherwise not valid
        guard account?.key != nil else{
            return (false, "Invalid account credentials.".toNSError(in: "UdacitySessionResponse"))
        }
        
        // Guard session existance, otherwise not valid
        guard session != nil else{
            return (false, "Invalid account credentials.".toNSError(in: "UdacitySessionResponse"))
        }
        
        // Guard session.id existance, otherwise not valid
        guard session?.id != nil else{
            return (false, "Invalid account credentials.".toNSError(in: "UdacitySessionResponse"))
        }
        return (true, nil)
    }
}

struct Account: Decodable {
    let registered: Bool?
    let key: String?
}

struct Session: Decodable {
    let id: String?
    let expiration: String?
}

struct UdacitySession: Codable {
    let udacity: UdacityUserCredentials?
    
    init(credentials: UdacityUserCredentials) {
        self.udacity = credentials
    }
}

struct UdacityUserCredentials: Codable {
    let username: String?
    let password: String?
}
