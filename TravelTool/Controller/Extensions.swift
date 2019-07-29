//
//  Extensions.swift
//  TravelTool
//
//  Created by Andrea Tongsak on 7/29/19.
//  Copyright © 2019 Andrea Tongsak. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let reload = Notification.Name("reload")
    static let reloadStarted = Notification.Name("reloadStarted")
    static let reloadCompleted = Notification.Name("reloadCompleted")
}

extension Data {
    // Convert from Udacity data form to the normal data form by removing the first 5 chars.
    func JSONData() -> Data {
        let range = 5..<self.count
        let newData = self.subdata(in: range)
        return newData
    }
}

extension String {
    func toNSError(in domain: String) -> NSError{
        return NSError(domain: domain, code: 1, userInfo: [NSLocalizedDescriptionKey : self])
    }
}
