//
//  MyWeatherTests.swift
//  MyWeatherTests
//
//  Created by Cerebro on 12/10/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import XCTest
import MapKit
@testable import MyWeather

class MyWeatherTests: XCTestCase {

    func testLocationUpdatedFail() {
        let model = ViewControllerModel()
        XCTAssertFalse(model.locationUpdated())
    }
    
    func testLocationUpdatedPass() {
        let model = ViewControllerModel()
        let mockManager = MockLocationManager()
        mockManager.mockLocation = CLLocation(latitude: 51.509484, longitude: -0.080011)
        model.locationManager = mockManager
        XCTAssertTrue(model.locationUpdated())
    }
    
}

fileprivate class MockLocationManager : CLLocationManager {
    var mockLocation: CLLocation?
    override var location: CLLocation? {
        return mockLocation
    }
    override init() {
        super.init()
    }
}
