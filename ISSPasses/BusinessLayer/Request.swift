//
//  Request.swift
//  ISSPasses
//
//  Created by Andrei Daniyalian on 2/20/18.
//  Copyright © 2018 Andrei Daniyalian. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

extension Request {
    private class var baseURL: String { return "http://api.open-notify.org/" }
    
    class func passes(with coodrinates: CLLocationCoordinate2D, altitude: Double? = nil, numberOfPasses: Int? = nil) -> Request {
        let url = Request.baseURL + "iss-pass.json"
        var parameters = [String: Any]()
        parameters["lat"] = coodrinates.latitude
        parameters["lon"] = coodrinates.longitude
        if let alt = altitude {
            parameters["alt"] = alt
        }
        if let n = numberOfPasses {
            parameters["n"] = n
        }
        
        let request = Alamofire.request(url, method: HTTPMethod.get, parameters: parameters, encoding: URLEncoding.queryString, headers: nil)
        return request
    }
}

