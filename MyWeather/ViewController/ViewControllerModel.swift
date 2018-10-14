//
//  ViewControllerModel.swift
//  MyWeather
//
//  Created by Cerebro on 13/10/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import Foundation
import MapKit

enum UpdateStatus {
    case noConnectivity
    case success
    case failedToUpdateLocation
    case locationDenied
    case offlineData
}

enum DefaultsObject {
    static let location = "location"
    static let date = "date"
}

enum TimeOfDay {
    static let day = 6 ..< 18
}

protocol LocationUpdated {
    func locationUpdated(_ location: Location?)
    func handleStatusChange(_ status: UpdateStatus)
}

class ViewControllerModel {
    
    var delegate: LocationUpdated?
    var locationManager: CLLocationManager?
    var myLocation: CLLocation?
    private var locationData: Location?
    
    private func updateWeather() {
        guard let myLocation = myLocation else { return }
        NetworkRequest.getWeather(lat: myLocation.coordinate.latitude, lon: myLocation.coordinate.longitude) { (data) in
            guard let data = data else { return }
            guard let dataWithDate = DefaultsHelper.addDateToJSON(data: data) else { return }
            self.createLocationFromData(dataWithDate)
        }
    }
    
    private func createLocationFromData(_ data: Data) {
        if let location = DefaultsHelper.decodeLocationObject(data) {
            locationData = location
            delegate?.locationUpdated(location)
            delegate?.handleStatusChange(.success)
            DefaultsHelper.saveLocation(location)
        } else {
            locationData = nil
            delegate?.locationUpdated(nil)
        }
    }
    
    func locationUpdated() -> Bool {
        guard let myCurrentLocation = locationManager?.location else { return false }
        myLocation = myCurrentLocation
        return true
    }
    
    func newWeatherRequest() {
        if Reachability.isConnectedToNetwork() {
            if isLocationServiceAuthorized() {
                checkLocation()
            } else {
                delegate?.handleStatusChange(.locationDenied)
            }
        } else if let storedData = DefaultsHelper.recentStoredData() {
            locationData = storedData
            offlineDataLoaded()
        } else {
           delegate?.handleStatusChange(.noConnectivity)
        }
    }
    
    private func checkLocation() {
        guard let location = locationManager?.location else {
            delegate?.handleStatusChange(.failedToUpdateLocation)
            return
        }
        myLocation = location
        updateWeather()
    }
    
    func offlineDataLoaded() {
        delegate?.locationUpdated(locationData)
        delegate?.handleStatusChange(.offlineData)
    }
    
    func isLocationServiceAuthorized() -> Bool {
        return CLLocationManager.authorizationStatus() == .authorizedWhenInUse
    }
   
}
