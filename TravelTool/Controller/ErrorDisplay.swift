//
//  ErrorDisplay.swift
//  TravelTool
//
//  Created by Andrea Tongsak on 7/29/19.
//  Copyright © 2019 Andrea Tongsak. All rights reserved.
//

import Foundation
import UIKit

class ErrorDisplay {
    enum NotifyMessageHeader: String {
        case error = "Error"
        case sorry = "Sorry"
        case success = "Success"
    }
    
    enum NotifyMessageReturnType: String {
        case dismiss = "Error"
        case cancel = "Sorry"
        case okCancel = "OkCancel"
        case ok = "Ok"
    }
    
    public static func notify(title: NotifyMessageHeader, body: String,return returnType: NotifyMessageReturnType, _ firstHandler:(() -> Void)? = nil, _ secondHandler:(() -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title.rawValue, message: body, preferredStyle: .alert)
        switch returnType {
        case .dismiss:
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (action) in
                firstHandler?()
            }))
        case .cancel:
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                firstHandler?()
            }))
        case .okCancel:
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                firstHandler?()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                secondHandler?()
            }))
        case .ok:
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                firstHandler?()
            }))
        }
        return alert
    }
}
