//
//  CodableHelper.swift
//  MyWeather
//
//  Created by Cerebro on 14/10/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import Foundation

// MARK: - DefaultsHelper
class DefaultsHelper {
    
    // converts JSON to Location Object using Codable
    class func decodeLocationObject(_ data: Data) -> Location? {
        let decoder = JSONDecoder()
        do {
            let location = try decoder.decode(Location.self, from: data)
            return location
        } catch {
            print(error)
            return nil
        }
    }

    class func saveLocation( _ location: Location) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(location)
            let userDefaults = UserDefaults.standard
            userDefaults.set(data, forKey: DefaultsObject.location)
            userDefaults.synchronize()
        } catch {
            print(error)
        }
    }
    
    class func recentStoredData() -> Location? {
        let userDefaults = UserDefaults.standard
        
        guard let storedLocationData = userDefaults.data(forKey: DefaultsObject.location), let storedLocation = self.decodeLocationObject(storedLocationData) else { return nil }
        
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()),
            storedLocation.date > yesterday else { return nil }

        return storedLocation
    }
    
}
