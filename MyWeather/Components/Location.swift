//
//  Location.swift
//  MyWeather
//
//  Created by Cerebro on 13/10/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import Foundation

// MARK: - Location Codable Struct
struct Location: Codable {
    
    let name: String?
    
    let speed: Double?
    let deg: Double?
    
    let main: String?
    let description: String?
    let icon: String?
    let id: Int?
    
    let temp: Double?
    
    let lon: Double
    let lat: Double
    
    let date: Date
    
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        
        case wind = "wind"
        case speed = "speed"
        case deg = "deg"
        
        case weather = "weather"
        case index0 = "index 0"
        case main = "main" // used for 2 keys
        case description = "description"
        case icon = "icon"
        case id = "id"
        
        case temp = "temp"
        
        case coord = "coord"
        case lon = "lon"
        case lat = "lat"
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try? container.decode(String.self, forKey: .name)
        
        let wind = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .wind)
        speed = try? wind.decode(Double.self, forKey: .speed)
        deg = try? wind.decode(Double.self, forKey: .deg)
        
        // weather is an array with one item in this case, need to access the first index
        var weather = try container.nestedUnkeyedContainer(forKey: .weather)
        let index0 = try weather.nestedContainer(keyedBy: CodingKeys.self)
        main = try? index0.decode(String.self, forKey: .main)
        description = try? index0.decode(String.self, forKey: .description)
        icon = try? index0.decode(String.self, forKey: .icon)
        id = try? index0.decode(Int.self, forKey: .id)
        
        // main is used here again as the key name is seen twice in the data
        let mainTemp = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .main)
        temp = try? mainTemp.decode(Double.self, forKey: .temp)
        
        let coord = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .coord)
        lon = try coord.decode(Double.self, forKey: .lon)
        lat = try coord.decode(Double.self, forKey: .lat)
        
        date = Date()
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try? container.encode(name, forKey: .name)
        
        var wind = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .wind)
        try? wind.encode(speed, forKey: .speed)
        try? wind.encode(deg, forKey: .deg)
        
        // weather is an array with one item in this case, need to access the first index
        var weather = container.nestedUnkeyedContainer(forKey: .weather)
        var index0 = weather.nestedContainer(keyedBy: CodingKeys.self)
        try? index0.encode(main, forKey: .main)
        try? index0.encode(description, forKey: .description)
        try? index0.encode(icon, forKey: .icon)
        try? index0.encode(id, forKey: .id)
        
        // main is used here again as the key name is seen twice in the data
        var mainTemp = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .main)
        try? mainTemp.encode(temp, forKey: .temp)
        
        var coord = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .coord)
        try coord.encode(lon, forKey: .lon)
        try coord.encode(lat, forKey: .lat)
        
    }
    
}
