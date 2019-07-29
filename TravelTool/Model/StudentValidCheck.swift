//
//  StudentValidCheck.swift
//  TravelTool
//
//  Created by Andrea Tongsak on 7/29/19.
//  Copyright © 2019 Andrea Tongsak. All rights reserved.
//

import Foundation
import UIKit

extension Student{
    enum StudentValidationType {
        case displayingLocation
        case displayingAsList
    }
    
    func isValid(for validationType: StudentValidationType) -> (Bool, String?) {
        switch validationType {
        case .displayingLocation:
            return isValidForDisplayingLocation()
        case .displayingAsList:
            return isValidForDisplayingAsList()
        }
    }
    
    // Checks whether location is displayed.
    private func isValidForDisplayingLocation() -> (Bool, String?) {
        guard firstName != nil else{
            return(false, "firstName empty")
        }
        
        guard lastName != nil else{
            return(false, "lastName empty")
        }
        
        guard mediaURL != nil else{
            return(false, "mediaURL empty")
        }
        
        guard latitude != nil else{
            return(false, "latitude empty")
        }
        
        guard longitude != nil else{
            return(false, "longitude empty")
        }
        
        return(true, nil)
    }
    
    // Func ensures that first name and last name is not empty to display
    // mediaURL must not be empty to let action done
    private func isValidForDisplayingAsList() -> (Bool, String?) {
        guard firstName != nil, firstName != String() else{
            return(false, "firstName empty")
        }
        
        guard lastName != nil, firstName != String() else{
            return(false, "lastName empty")
        }
        
        guard mediaURL != nil, firstName != String() else{
            return(false, "mediaURL empty")
        }
        
        guard let _ = URL(string: mediaURL!) else{
            return(false, "Invalid mediaURL")
        }
        
        return(true, nil)
    }
    
}
