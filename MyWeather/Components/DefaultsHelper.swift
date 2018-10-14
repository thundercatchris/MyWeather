//
//  CodableHelper.swift
//  MyWeather
//
//  Created by Cerebro on 14/10/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import Foundation

enum DateFormat {
    static let stored = "yyyy-MM-dd HH:mm:ss"
    static let display = "HH:mm dd MMM"
}

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
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.stored
        
        guard let storedLocationData = userDefaults.data(forKey: DefaultsObject.location),
            let storedLocation = self.decodeLocationObject(storedLocationData),
            let storedDate = dateFormatter.date(from: storedLocation.date) else { return nil }
        
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()),
            storedDate > yesterday else { return nil }
        
        return storedLocation
    }
    
    class func addDateToJSON(data: Data) -> Data? {
        do {
            var jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = DateFormat.stored
            jsonDictionary[DefaultsObject.date] = dateFormatter.string(from: Date())
            
            let dataWithDate = try JSONSerialization.data(withJSONObject: jsonDictionary, options: [])
            
            return dataWithDate
            
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
            return nil
        }
        
    }
    
}
