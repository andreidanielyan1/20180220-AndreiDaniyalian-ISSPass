//
//  PassesViewController.swift
//  ISSPasses
//
//  Created by Andrei Daniyalian on 2/20/18.
//  Copyright © 2018 Andrei Daniyalian. All rights reserved.
//

import UIKit
import CoreLocation

class PassesViewController: UIViewController {
    
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var numberOfPassesLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var currentLocation: CLLocation? {
        didSet {
            if let loc = currentLocation {
                currentLocationLabel.text = loc.toString()
                if oldValue == nil {
                    //fetch passes only when get location object first time
                    self.refreshData()
                }
            } else {
                currentLocationLabel.text = "--"
            }
        }
    }
    
    var numberOfPasses: Int? {
        didSet {
            if let numberOfPasses = numberOfPasses {
                numberOfPassesLabel.text = String(format: "%i", numberOfPasses)
            } else {
                numberOfPassesLabel.text = "--"
            }
        }
    }
    
    var passes: [PassObject]? // Would like to implement proper data model if had more time
    
    let sliderMaxValue: Float = 100.0
    let sliderMinValue: Float = 5.0
    

    override func viewDidLoad() {
        super.viewDidLoad()

        slider.maximumValue = sliderMaxValue
        slider.minimumValue = sliderMinValue
        slider.value = sliderMinValue
        
        numberOfPasses = Int(sliderMinValue)
        
        currentLocation = LocationManager.default.currentLocation
        LocationManager.default.delegate = self
        LocationManager.default.startUpdatingLocation()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: Update
    
    func refreshData() {
        
        //Need to check for reachability and present error if not reachable
        
        if !LocationManager.default.isUpdating {
            LocationManager.default.startUpdatingLocation()
        }
        activityIndicator.startAnimating()
        if let currentLocation = currentLocation {
            BusinessLayerManager.shared.getPasses(with: currentLocation.coordinate, altitude: currentLocation.altitude, numberOfPasses: numberOfPasses, completion: { [weak self] (passes, error) in
                if let error = error {
                    _ = UIAlertController.presetAlert(title: "Error", message: error.localizedDescription, dismissButtonTitle: Constants.String.ok)
                    self?.activityIndicator.stopAnimating()

                    return
                }
                self?.activityIndicator.stopAnimating()
                self?.passes = passes
                self?.update()
            })
        } else {
            self.activityIndicator.stopAnimating()
            let error = Constants.Error.locationUnavailable
            _ = UIAlertController.presetAlert(title: "Error", message: error.localizedDescription, dismissButtonTitle: Constants.String.ok)
        }
    }
    
    func update() {
        tableView.reloadData()
    }

    // MARK: - IBAction
    
    @IBAction func updateButtonTouched(button: UIButton) {
        self.refreshData()
    }
    
    @IBAction func sliderValueChanged(slider: UISlider) {
        numberOfPasses = Int(slider.value)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PassesViewController: LocationManagerDelegate {
    func locationManager(_ manager: LocationManager, didUpdateLocation location: CLLocation) {
        currentLocation = location
    }
    
    
    func locationManager(_ manager: LocationManager, didFailWithError error: Error) {
        if let error = error as? CLError {
            switch error.code {
            case .denied:
                let error = Constants.Error.locationServiceDenied
                _ = UIAlertController.presetAlert(title: "Error", message: error.localizedDescription, dismissButtonTitle: Constants.String.ok)
                return
            default:
                break
            }
        }
        _ = UIAlertController.presetAlert(title: "Error", message: error.localizedDescription, dismissButtonTitle: Constants.String.ok)
    }

}

extension PassesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? PassTableViewCell,
            let pass = passes?[indexPath.row] else {
            fatalError("should never happen")
        }
        cell.configure(with: pass)
        return cell
    }
}



