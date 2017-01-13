//
//  PokeAnnotation.swift
//  Pokemon Lite
//
//  Created by Sdot on 1/13/17.
//  Copyright © 2017 SwiftMills. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class PokeAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var pokemon: Pokemon
    
    init(coord: CLLocationCoordinate2D, pokemon: Pokemon) {
        self.coordinate = coord
        self.pokemon = pokemon
    }
    
}
