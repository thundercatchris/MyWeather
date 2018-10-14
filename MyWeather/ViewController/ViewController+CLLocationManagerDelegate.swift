//
//  ViewController+CLLocationManagerDelegate.swift
//  MyWeather
//
//  Created by Cerebro on 14/10/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import Foundation
import MapKit

// MARK: - Extension CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .denied) {
            handleStatusChange(.locationDenied)
        } else if (status == .authorizedWhenInUse) {
            model?.newWeatherRequest()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if model?.myLocation == nil && Reachability.isConnectedToNetwork() {
            model?.myLocation = locations.first
            model?.newWeatherRequest()
        }
    }
}
