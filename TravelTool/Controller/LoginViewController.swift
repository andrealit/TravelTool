//
//  LoginViewController.swift
//  TravelTool
//
//  Created by Andrea Tongsak on 7/29/19.
//  Copyright © 2019 Andrea Tongsak. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: DidLoad Family
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    // MARK: Methods
    private func isValidUICredential() -> Bool {
        guard email?.text != nil, email?.text != String() else {
            notify(title: .sorry, body: "Empty email is not allowed!", return: .dismiss)
            return false
        }
        
        guard password?.text != nil, password?.text != String() else {
            notify(title: .error, body: "Empty password is not allowed!", return: .dismiss)
            return false
        }
        
        return true
    }
    
    private func notify(title: ErrorDisplay.NotifyMessageHeader, body: String, return returnType: ErrorDisplay.NotifyMessageReturnType) {
        let alert = ErrorDisplay.notify(title: title, body: body, return: returnType)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func startAnimation() {
        enableUI(isEnabled: false)
    }
    
    private func stopAnimation() {
        enableUI(isEnabled: true)
    }
    
    private func enableUI(isEnabled: Bool) {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = isEnabled
            if !isEnabled {
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
            }
            
            self.email.isEnabled = isEnabled
            self.password.isEnabled = isEnabled
            self.loginBtn.isEnabled = isEnabled
        }
    }
}
