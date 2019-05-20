//
//  SafeSpaceLocation.swift
//  seguraarede
//
//  Created by Ian Manor on 17/05/19.
//  Copyright © 2019 Manuella Valença. All rights reserved.
//

import Foundation
import CoreLocation

struct SafeSpaceLocation {
    var name: String
    var coordinates: CLLocationCoordinate2D
    var radius: CLLocationDistance
}
