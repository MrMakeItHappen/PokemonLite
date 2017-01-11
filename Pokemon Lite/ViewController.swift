//
//  ViewController.swift
//  Pokemon Lite
//
//  Created by Sdot on 1/10/17.
//  Copyright © 2017 SwiftMills. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var manager = CLLocationManager()
    var updateCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
            manager.startUpdatingLocation()
            
            Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (timer) in
                
                if let coord = self.manager.location?.coordinate {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coord
                    self.mapView.addAnnotation(annotation)
                
                }
                
                
            })
            
            
            
        } else {
            manager.requestWhenInUseAuthorization()
        }
      
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if updateCount < 1 {
            let region = MKCoordinateRegionMakeWithDistance(manager.location!.coordinate, 400, 400)
            mapView.setRegion(region, animated: false)
            updateCount += 1
        } else {
            manager.stopUpdatingLocation()
        }
    }
    
    @IBAction func centerTapped(_ sender: Any) {
        
        if let coordinate = manager.location?.coordinate {
            let region = MKCoordinateRegionMakeWithDistance(coordinate, 400, 400)
            mapView.setRegion(region, animated: true)
        }
    }



}

