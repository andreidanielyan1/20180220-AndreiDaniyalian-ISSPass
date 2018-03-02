//
//  LocationManager.swift
//  ISSPasses
//
//  Created by Andrei Daniyalian on 2/20/18.
//  Copyright © 2018 Andrei Daniyalian. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate: class {
    func locationManager(_ manager: LocationManager, didUpdateLocation location: CLLocation)
    func locationManager(_ manager: LocationManager, didFailWithError error: Error)
}

class LocationManager: NSObject {
    public static let `default` = LocationManager()
    weak var delegate: LocationManagerDelegate?
    
    fileprivate var locationManager: CLLocationManager
    var isUpdating: Bool = false
    var currentLocation: CLLocation?

    private
    
    override init() {
        locationManager = CLLocationManager()
        super.init()

        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 100
        locationManager.delegate = self
    }
    
    func startUpdatingLocation() {
        self.locationManager.startUpdatingLocation()
        self.isUpdating = true
    }
    
    func stopUpdatingLocation() {
        self.locationManager.stopUpdatingLocation()
        self.isUpdating = false
    }

}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            currentLocation = location
            delegate?.locationManager(self, didUpdateLocation: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as? CLError {
            switch error.code {
            case .denied:
                stopUpdatingLocation()
            default:
                break
            }
        }
        delegate?.locationManager(self, didFailWithError: error)
    }
}
