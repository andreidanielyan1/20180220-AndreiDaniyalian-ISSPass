//
//  Constants.swift
//  ISSPasses
//
//  Created by Andrei Daniyalian on 2/20/18.
//  Copyright © 2018 Andrei Daniyalian. All rights reserved.
//

import Foundation

enum Constants {
    enum ErrorMessage {
        //Would add localization
        static let locationServiceDenied = "Looks like we don't have permitions to use location service! You can updated permissions in Settings app"
        static let locationUnavailable = "Current location unavailable, Please try again later"
        static let connectionError = "We are having troble reaching server. Please check your internet connection and try again later"
        static let apiFailed = "Seomething went wrong, we are working hard to reslolve it. Please try again later"
    }
    
    enum Error{
        //Temp solution
        static let locationServiceDenied = NSError(domain: "ErrorDomain", code: 999, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.locationServiceDenied])
        static let locationUnavailable = NSError(domain: "ErrorDomain", code: 999, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.locationUnavailable])
        static let connectionError = NSError(domain: "ErrorDomain", code: 999, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.connectionError])
        static let apiFailed = NSError(domain: "ErrorDomain", code: 999, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.apiFailed])
    }
    
    enum String {
        static let ok = "OK"
    }
    
}
