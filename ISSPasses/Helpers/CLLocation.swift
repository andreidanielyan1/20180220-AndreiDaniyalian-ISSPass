//
//  CLLocation.swift
//  ISSPasses
//
//  Created by Andrei Daniyalian on 2/20/18.
//  Copyright © 2018 Andrei Daniyalian. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocation {
    func toString() -> String {
        
        let lat = coordinate.latitude
        let lon = coordinate.longitude
        let alt = altitude
        return String(format: "Lat: %f, Lon: %f, Alt: %f", lat, lon, alt)
    }
}
