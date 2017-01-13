//
//  ViewController.swift
//  Pokemon Lite
//
//  Created by Sdot on 1/10/17.
//  Copyright © 2017 SwiftMills. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var manager = CLLocationManager()
    var updateCount = 0
    var pokemons: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemons = getAllPokemon()
        
        manager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.delegate = self
            mapView.showsUserLocation = true
            manager.startUpdatingLocation()
            
            Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (timer) in
                
                if let coord = self.manager.location?.coordinate {
                    
                    let pokemon = self.pokemons[Int(arc4random_uniform(UInt32(self.pokemons.count)))]
                    
                    let annotation = PokeAnnotation(coord: coord, pokemon: pokemon)
                    let randomLat = (Double(arc4random_uniform(200)) - 100.0) / 50000.0
                    let randomLong = (Double(arc4random_uniform(200)) - 100.0) / 50000.0
                    
                    annotation.coordinate.latitude += randomLat
                    annotation.coordinate.longitude += randomLong
                    
                    self.mapView.addAnnotation(annotation)
                
                }
                
                
            })
            
            
            
        } else {
            manager.requestWhenInUseAuthorization()
        }
      
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
            annotationView.image = UIImage(named: "pokemon-trainer")
            
            var frame = annotationView.frame
            frame.size.height = 50
            frame.size.width = 50
            annotationView.frame = frame
            
            return annotationView
        }
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        let pokemon = (annotation as! PokeAnnotation).pokemon
        
        annotationView.image = UIImage(named: pokemon.imageName!)
        
        var frame = annotationView.frame
        frame.size.height = 50
        frame.size.width = 50
        annotationView.frame = frame
        
        return annotationView
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if updateCount < 1 {
            let region = MKCoordinateRegionMakeWithDistance(manager.location!.coordinate, 200, 200)
            mapView.setRegion(region, animated: false)
            updateCount += 1
        } else {
            manager.stopUpdatingLocation()
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        mapView.deselectAnnotation(view.annotation!, animated: true)
        
        if view.annotation! is MKUserLocation {
            return
        }
        
        let region = MKCoordinateRegionMakeWithDistance(view.annotation!.coordinate, 200, 200)
        mapView.setRegion(region, animated: true)
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
            if let coordinate = self.manager.location?.coordinate {
                if MKMapRectContainsPoint(mapView.visibleMapRect, MKMapPointForCoordinate(coordinate)) {
                    
                    let pokemon = (view.annotation as! PokeAnnotation).pokemon
                    pokemon.caught = true
                    
                    (UIApplication.shared.delegate as! AppDelegate).saveContext()
                    
                    mapView.removeAnnotation(view.annotation!)
                    
                    let alertVC = UIAlertController(title: "Well Done!", message: "You caught a \(pokemon.name!)!!", preferredStyle: .alert)
                    let OKaction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    let pokeDexActioon = UIAlertAction(title: "PokeDex", style: .default, handler: nil)
                    
                    alertVC.addAction(pokeDexActioon)
                    alertVC.addAction(OKaction)
                    
                    self.present(alertVC, animated: true, completion: nil)
                
                } else {
                    let pokemon = (view.annotation as! PokeAnnotation).pokemon
                    let alertVC = UIAlertController(title: "Uh-Oh", message: "You're too far away...Get closer to catch \(pokemon.name!)!", preferredStyle: .alert)
                    let OKaction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in })
                    
                    alertVC.addAction(OKaction)
                    self.present(alertVC, animated: true, completion: nil)
                }
            }
       
        }
        
        
    }
    
    @IBAction func centerTapped(_ sender: Any) {
        
        if let coordinate = manager.location?.coordinate {
            let region = MKCoordinateRegionMakeWithDistance(coordinate, 200, 200)
            mapView.setRegion(region, animated: true)
        }
    }



}

