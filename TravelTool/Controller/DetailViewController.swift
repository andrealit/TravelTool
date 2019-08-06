//
//  DetailViewController.swift
//  TravelTool
//
//  Created by Andrea Tongsak on 8/1/19.
//  Copyright © 2019 Andrea Tongsak. All rights reserved.
//


/// Credit: Data derived from park json, data from Flickr, Seattle repo

import UIKit
import CoreData

class DetailViewController: BaseViewController {
    
    // MARK: Outlets and Properties
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var parkAddress: UILabel!
    @IBOutlet weak var parkHours: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var publicFlickrLabel: UILabel!
    @IBOutlet weak var photoLabel: UILabel!
    
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
        getTrafficDetails()
        getRandomParkPhoto()
        navigationItem.title = parkTitle
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.all)
    }
    
    // MARK: Retrieve Park Details
    
    func getTrafficDetails() {
        showActivityIndicator()
        TrafficClient.getTrafficDetails(parkId: parkId) { (location, error) in
            if error == nil {
                self.location = location ?? []
                if location?.isEmpty == true {
                    self.hideActivityIndicator()
                    self.parkAddress.isHidden = true
                    self.parkHours.isHidden = true
                    self.infoLabel.isHidden = false
                    self.photoLabel.isHidden = false
                } else {
                    //for location in location ?? [] {
                    self.hideActivityIndicator()
                    if let location = location?.last {
                        self.infoLabel.isHidden = true
                        self.photoLabel.isHidden = true
                        self.address = location.location2?.humanAddress.address ?? ""
                        // lat/lon values reversed in the results for the api endpoint
                        self.lat = location.location2?.longitude ?? ""
                        self.lon = location.location2?.latitude ?? ""
                        self.parkAddress.text = "Address: \(location.location2?.humanAddress.address ?? "")"
                        self.parkHours.text = "Hours: \(location.hours ?? "")"
                    }
                }
            } else {
                self.hideActivityIndicator()
                self.showAlert(message: "There was an error retrieving location details", title: "Sorry")
            }
        }
    }
    
    // MARK: Get public Flickr photo for hero image
    
    func getRandomParkPhoto() {
        showActivityIndicator()
        let escapedParkTitle = parkTitle.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        // returns number of pages in results for use
        TrafficClient.getRandomFlickrPhoto(lat: lat, lon: lon, page: page, text: escapedParkTitle, completion: { (photos, error) in
            if (photos != nil) {
                if photos?.pages == 0 {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(named: "park")
                    }
                } else {
                    self.pages = photos!.pages
                    self.randomPage()
                }
                // get Flickr photo from a random page and download it
                TrafficClient.getRandomFlickrPhoto(lat: self.lat, lon: self.lon, page: self.page, text: escapedParkTitle, completion: { photos, error in
                    if (photos != nil) {
                        self.infoLabel.isHidden = true
                        if photos?.pages == 0 {
                            DispatchQueue.main.async {
                                self.imageView.image = UIImage(named: "park")
                            }
                        } else {
                            self.photos = photos!.photo
                            var url = ""
                            for photo in self.photos {
                                url = photo.urlL
                                self.url = url
                            }
                            print("Photo url: \(url)")
                            self.downloadImage()
                        }
                    }
                })
            } else {
                print("Photo is nil")
                self.hideActivityIndicator()
                self.photoLabel.isHidden = false
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(named: "park")
                }
            }
        })
    }
    
    // MARK: Generate page number for Flickr API
    
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
                    self.publicFlickrLabel.isHidden = false
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
