//
//  DetailViewController.swift
//  TravelTool
//
//  Created by Andrea Tongsak on 8/1/19.
//  Copyright © 2019 Andrea Tongsak. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: BaseViewController {
    
    // MARK: Outlets and Properties
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var parkAddress: UILabel!
    @IBOutlet weak var parkHours: UILabel!
    @IBOutlet weak var noInfoLabel: UILabel!
    
    
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
    
    // MARK: Retrieve Park Details
    
    func getTrafficDetails() {
        TrafficClient.getTrafficDetails(parkId: parkId) { (location, error) in
            if error == nil {
                self.location = location ?? []
                if location?.isEmpty == true {
                    self.parkAddress.isHidden = true
                    self.parkHours.isHidden = true
                    self.noInfoLabel.isHidden = false
                } else {
                    for location in location ?? [] {
                        self.address = location.location2?.humanAddress.address ?? ""
                        // lat/lon values are reversed in the results
                        self.lat = location.location2?.longitude ?? ""
                        self.lon = location.location2?.latitude ?? ""
                        self.parkAddress.text = "Address: \(location.location2?.humanAddress.address ?? "")"
                        self.parkHours.text = "Hours: \(location.hours ?? "")"
                    }
                }
            } else {
                self.showAlert(message: "There was an error retrieving park details", title: "Sorry")
            }
        }
    }
    
    // MARK: Get public Flickr photo for hero image
    
    func getRandomParkPhoto() {
        let escapedParkTitle = parkTitle.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        // get number of pages in results in order to use in randomPage()
        TrafficClient.getRandomFlickrPhoto(lat: lat, lon: lon, page: page, text: escapedParkTitle) { (photos, error) in
            if (photos != nil) {
                if photos?.pages == 0 {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(named: "park")
                    }
                } else {
                    self.pages = photos!.pages
                    
                }
            }
        }
    }
    
    // MARK: Generate random page number for Flickr API Request
    
    func randomPage() {
        let randomPage = Int.random(in: 1...pages)
        print("randomPage: \(randomPage)")
        page = randomPage
    }
    
    // MARK: Download Image
    
    func downloadImage() {
        TrafficClient.downloadPhoto(photoUrl: URL(string: url)!) { (data, error) in
            if data != nil {
                print("Photo data found")
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data!)
                    self.imageView.contentMode = .scaleAspectFill
                    self.imageView.alpha = 1.0
                }
            } else {
                print("Photo data not found")
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(named: "park")
                }
            }
        }
    }
    
    
}
