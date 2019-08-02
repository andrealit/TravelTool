//
//  MapViewController.swift
//  TravelTool
//
//  Created by Andrea Tongsak on 8/1/19.
//  Copyright © 2019 Andrea Tongsak. All rights reserved.
//

import Foundation
import MapKit

class MapViewController: BaseViewController, MKMapViewDelegate {
    
    // MARK: Outlets and Properties
    @IBOutlet weak var mapView: MKMapView!
    
    var annotations = [MKPointAnnotation]()
    var parkName: String = ""
    var parkId: String = ""
    var selectedAnnotation: MKPointAnnotation
    var lat: String = ""
    var lon: String = ""
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    // MARK: Retrieve shop locations to populate Map
    func getLocationsfromAPI() {
        showActivityIndicator()
        
    }
}
