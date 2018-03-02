//
//  UIAlertController.swift
//  ISSPasses
//
//  Created by Andrei Daniyalian on 2/20/18.
//  Copyright © 2018 Andrei Daniyalian. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    static func presetAlert(title: String?, message: String?, dismissButtonTitle: String?) -> UIAlertController? {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let buttonAction = UIAlertAction(title: dismissButtonTitle, style: .default, handler: {
            (action: UIAlertAction) -> Void in
        })
        alertController.addAction(buttonAction)
        
        if let appDelegate = UIApplication.shared.delegate,
            let appWindow = appDelegate.window!,
            let rootViewController = appWindow.rootViewController {
            rootViewController.present(alertController, animated: true, completion: nil)
        }
        return alertController
    }
}

