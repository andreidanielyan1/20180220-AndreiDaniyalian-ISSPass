//
//  BusinessLayerManager.swift
//  ISSPasses
//
//  Created by Andrei Daniyalian on 2/20/18.
//  Copyright © 2018 Andrei Daniyalian. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

class BusinessLayerManager {
    
    public static let shared = BusinessLayerManager()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "MM/dd/yyyy HH:mm"
        return formatter
    }()

    
    public func getPasses(with coordinate: CLLocationCoordinate2D, altitude: Double? = nil, numberOfPasses: Int? = nil, completion: @escaping ([PassObject]?, Error?) -> Void) {
        if let request = Request.passes(with: coordinate, altitude: altitude, numberOfPasses: numberOfPasses) as? DataRequest {
            request.responseJSON(completionHandler: { response in
                DispatchQueue.main.async {
                    switch response.result {
                    case .success:
                        if let dict = response.result.value as? [String: Any] {
                            let message = dict["message"] as? String
                            if message != "success" {
                                let error = Constants.Error.apiFailed //Would add proper error handling if had more time
                                
                                completion(nil, error)
                                return
                            }
                            
                            guard let passes = dict["response"] as? [AnyObject] else {
                                let error = Constants.Error.apiFailed //Would add proper error handling if had more time
                                
                                completion(nil, error)
                                return
                            }
                            let result = passes.flatMap ({ (passDict) -> PassObject? in
                                guard let passDict = passDict as? [String: Double] else { return nil }
                                if let risetime = passDict["risetime"],
                                    let duration = passDict["duration"] {
                                    let pass = PassObject(risetime: risetime, duration: duration)
                                    return pass
                                } else {
                                    return nil
                                }
                            })
                            completion(result, nil)
                        }
                    case .failure:
                        let error = Constants.Error.apiFailed //Would add proper error handling if had more time
                        completion(nil, error)
                        return
                    }
                }
            })
        }
    }

    
}
