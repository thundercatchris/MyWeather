//
//  ViewController.swift
//  MyWeather
//
//  Created by Cerebro on 12/10/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import UIKit
import MapKit
import Kingfisher

// MARK: - Enum DataString
enum DataString {
    static let dataUnavailable = "Data unavailable"
    static let loading = "Loading..."
}

// MARK: - ViewController
class ViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var directionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var fadeView: UIView!
    @IBOutlet weak var activityIndicatorView: UIView!
    
    var model: ViewControllerModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearUI(dataUnavailable: false)
        isActivityIndicatorVisible(true)
        setupModel()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setupModel() {
        model = ViewControllerModel()
        model?.delegate = self
        
        model?.locationManager = CLLocationManager()
        model?.locationManager?.delegate = self
        model?.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        model?.locationManager?.requestWhenInUseAuthorization()
        model?.locationManager?.startUpdatingLocation()
    }
    
    @IBAction func refreshPressed(_ sender: Any) {
        isActivityIndicatorVisible(true)
        model?.newWeatherRequest()
    }
    
    func clearUI(dataUnavailable: Bool) {
        mainLabel.text = dataUnavailable ? DataString.dataUnavailable : DataString.loading
        descriptionLabel.text = dataUnavailable ? DataString.dataUnavailable : DataString.loading
        speedLabel.text = dataUnavailable ? DataString.dataUnavailable : DataString.loading
        directionLabel.text = dataUnavailable ? DataString.dataUnavailable : DataString.loading
        tempLabel.text = dataUnavailable ? DataString.dataUnavailable : DataString.loading
        dateLabel.text = dataUnavailable ? DataString.dataUnavailable : DataString.loading
        locationLabel.text = dataUnavailable ? DataString.dataUnavailable : DataString.loading
        dateLabel.textColor = UIColor.white
        iconImageView.image = nil
        weatherImageView.image = nil
    }
    
    func createAlert(title: String, message: String) {
        let alertView = UIAlertController(title: title,
                                          message: message as String, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertView.addAction(okAction)
        self.present(alertView, animated: true, completion: nil)
    }
    
    func isActivityIndicatorVisible(_ show: Bool) {
        
        fadeView.isHidden = !show
        activityIndicatorView.isHidden = !show
        if show {
            activityIndicatorView.rotate()
        } else {
            activityIndicatorView.stopRotating()
        }
    }
    
}

// MARK: - Extension String
extension String {
    var firstUppercased: String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
}
