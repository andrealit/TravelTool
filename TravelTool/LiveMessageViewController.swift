//
//  LiveMessageViewController.swift
//  TravelTool
//
//  Created by Andrea Tongsak on 7/24/19.
//  Copyright © 2019 Andrea Tongsak. All rights reserved.
//

import UIKit
import Firebase

// MARK: - LiveMessageViewController

class LiveMessageViewController: UIViewController, UINavigationControllerDelegate {
    
    // MARK: Properties
    
    var ref: DatabaseReference!
    var messages: [DataSnapshot]! = []
    var msglength: NSNumber = 1000
    var storageRef: StorageReference!
    var remoteConfig: RemoteConfig!
    let imageCache = NSCache<NSString, UIImage>()
    var keyboardOnScreen = false
    
    // MARK: Outlets
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var messagesTable: UITableView!
    @IBOutlet weak var backgroundBlur: UIVisualEffectView!
    @IBOutlet weak var imageDisplay: UIImageView!
    @IBOutlet var dismissImageRecognizer: UITapGestureRecognizer!
    @IBOutlet var dismissKeyboardRecognizer: UITapGestureRecognizer!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        self.signedInStatus(isSignedIn: true)
        
        // TODO: Handle what users see when view loads
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromAllNotifications()
    }
    
    // MARK: Config
    
    func configureAuth() {
        // TODO: configure firebase authentication
    }
    
    func configureDatabase() {
        // TODO: configure database to sync messages
    }
    
    func configureStorage() {
        // TODO: configure storage using your firebase storage
    }
    
    deinit {
        // TODO: set up what needs to be deinitialized when view is no longer being used
    }
    
    // MARK: Remote Config
    
    func configureRemoteConfig() {
        // TODO: configure remote configuration settings
    }
    
    func fetchConfig() {
        // TODO: update to the current coniguratation
    }

}

