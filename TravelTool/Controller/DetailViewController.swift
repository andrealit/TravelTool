//
//  DetailViewController.swift
//  TravelTool
//
//  Created by Andrea Tongsak on 8/1/19.
//  Copyright © 2019 Andrea Tongsak. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Outlets and Properties
    
    
    var location = [LocationDetails]()
    var photos = [Photo]()
    var parkId: String!
    var parkTitle: String!
    var address: String = ""
    var lat: String = ""
    var lon: String = ""
    var page: Int = 1
    var pages: Int = 1
    var url: String!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
    
    
}
