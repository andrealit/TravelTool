//
//  MapViewController.swift
//  TravelTool
//
//  Created by Andrea Tongsak on 8/1/19.
//  Copyright © 2019 Andrea Tongsak. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: BaseViewController, MKMapViewDelegate {
    
    // MARK: Outlets and Properties
    @IBOutlet weak var mapView: MKMapView!
    
    var locations = [LocationAddresses]()
    var annotations = [MKPointAnnotation]()
    var parkName: String = ""
    var parkId: String = ""
    var selectedAnnotation: MKPointAnnotation
    var lat: String = ""
    var lon: String = ""
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        getLocationsfromAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapView.deselectAnnotation(selectedAnnotation, animated: false)
    }
    
    // MARK: Retrieve locations to populate Map
    func getLocationsfromAPI() {
        showActivityIndicator()
        TrafficClient.getAllTraffic { (locations, error) in
            if error == nil {
                print("Map View request succeeded")
                self.locations = locations ?? []
                for location in locations ?? [] {
                    guard let latitude = location.location2?.latitude
                        else { continue }
                    let lat = Double(latitude)
                    guard let longitude = location.location2?.longitude
                        else { continue }
                    let long = Double(longitude)
                    let coordinate = CLLocationCoordinate2D(latitude: lat ?? 0.0, longitude: long ?? 0.0)
                    self.parkName = location.name
                    self.lat = location.location2?.latitude ?? ""
                    self.lon = location.location2?.longitude ?? ""
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate
                    annotation.title = self.parkName
                    self.annotations.append(annotation)
                }
                DispatchQueue.main.async {
                    self.hideActivityIndicator()
                    self.mapView.addAnnotations(self.annotations)
                    self.mapView.showAnnotations(self.mapView.annotations, animated: false)
                }
            } else {
                self.showAlert(message: "There was an error retrieving parks", title: "Sorry")
                self.hideActivityIndicator()
            }
        }
    }
    
    // MARK: Map View Data Source
    
    // MARK: Park Detail View
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            for location in locations {
                guard let latitude = location.location1?.latitude else { continue }
                let lat = Double(latitude)
                guard let longitude = location.location1?.longitude else { continue }
                let long = Double(longitude)
                if lat == self.selectedAnnotation.coordinate.latitude && long == self.selectedAnnotation.coordinate.longitude {
                    self.parkId = location.pmaid
                    self.parkName = location.name
                }
            }
            let controller = storyboard?.instantiateInitialViewController(viewIdentifier: "DetailViewController") as! DetailViewController
            controller.parkId
            
        }
    }
}
