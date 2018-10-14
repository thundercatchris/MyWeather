//
//  ViewController+LocationUpdated.swift
//  MyWeather
//
//  Created by Cerebro on 14/10/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import Foundation
import UIKit

// MARK: - LocationUpdate Protocol methods
extension ViewController: LocationUpdated {
    
    func handleStatusChange(_ status: UpdateStatus) {
        var title = "success"
        var message = "no message"
        
        switch status {
        case .success:
            dateLabel.textColor = UIColor.green
            return
        case .failedToUpdateLocation:
            title = "Failed to update your Location"
            message = "Please try again"
            clearUI(dataUnavailable: true)
        case .noConnectivity:
            title = "No connection or stored data"
            message = "Please check your internet connectivity and try again"
            clearUI(dataUnavailable: true)
        case .offlineData:
            title = "Offline Data"
            message = "No internet connectivity found, stored data is being displayed"
            dateLabel.textColor = UIColor.orange
        case .locationDenied:
            title = "MyWeather does not have permission to access your Location"
            message = "Please provide permission in settings and try again"
            clearUI(dataUnavailable: true)
        }
        createAlert(title: title, message: message)
    }
    
    func locationUpdated(_ location: Location?) {
        
        isActivityIndicatorVisible(location == nil)
        
        // Unwrapping each attribute separately, if some data missing, will still show available data
        mainLabel.text = (location?.main != nil) ? location?.main : DataString.dataUnavailable
        descriptionLabel.text = (location?.description != nil) ?
            location?.description?.firstUppercased : DataString.dataUnavailable
        
        if let speed = location?.speed {
            speedLabel.text = String(format: "%.2f", speed) + " mps"
        } else {
            speedLabel.text = DataString.dataUnavailable
        }
        
        if let direction = location?.deg {
            directionLabel.text = String(format: "%.2f", direction) + "°"
        } else {
            directionLabel.text = DataString.dataUnavailable
        }
        
        if let temp = location?.temp {
            tempLabel.text = String(format: "%.2f", temp) + "K"
        } else {
            tempLabel.text = DataString.dataUnavailable
        }
        
        if let name = location?.name {
            locationLabel.text = name
        } else {
            locationLabel.text = DataString.dataUnavailable
        }
        
        if let icon = location?.icon, let url = URL(string: "http://openweathermap.org/img/w/\(String(describing: icon)).png") {
            iconImageView.kf.setImage(with: url)
            
        } else {
            iconImageView.image = nil
        }
        
        if let icon = location?.icon {
            weatherImageView.image = UIImage(named: icon)
        }
        
        if let location = location {
            displayDate(location: location)
        }
    }
    
    func displayDate(location: Location) {
        let dateFormatterDate = DateFormatter()
        dateFormatterDate.dateFormat = DateFormat.stored
        
        let dateFormatterDisplay = DateFormatter()
        dateFormatterDisplay.dateFormat = DateFormat.display
        
            if let dateAsDate = dateFormatterDate.date(from: location.date) {
            let dateAsString = dateFormatterDate.string(from: dateAsDate)
            
            dateLabel.text = dateAsString
            
            let hour = Calendar.current.component(.hour, from: dateAsDate)
            if TimeOfDay.day.contains(hour) {
                self.view.backgroundColor = Theme.Colors.day
            } else {
                self.view.backgroundColor = Theme.Colors.night
            }
        }
    }
}
