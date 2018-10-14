//
//  NetworkRequest.swift
//  MyWeather
//
//  Created by Cerebro on 13/10/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import Foundation
import Alamofire

// MARK: API Basics
let apiKey = "3fa6d68bc22a2ffb512eee7fc39af88a"
let apiBaseURL = "http://api.openweathermap.org/data/2.5/weather"

class NetworkRequest {
    
    class func getWeather(lat: Double, lon: Double, completionHandler: @escaping (_ result: Data?) -> Void) {
        
        let parameters: Parameters = [
            "lat": String(lat),
            "lon": String(lon),
            "APPID": apiKey]
        
        Alamofire.request(apiBaseURL,
                          method: .get,
                          parameters: parameters,
                          encoding: URLEncoding(destination: .queryString)).responseJSON { response in
                            completionHandler(response.data)
        }
    }
}
