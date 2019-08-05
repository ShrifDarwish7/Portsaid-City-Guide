//
//  WeatherModel.swift
//  City Guide Demo
//
//  Created by Sherif Darwish on 3/25/19.
//  Copyright © 2019 Sherif Darwish. All rights reserved.
//

import Foundation
struct WeatherModel: Codable {
    let main: Main
    let name: String
    let weather: [Weather]
    let base: String
    let wind: Wind
}

struct Clouds: Codable {
    let all: Int
}

struct Coord: Codable {
    let lon, lat: Double
}

struct Main: Codable {
    let tempMin, tempMax, temp: Double
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case temp,humidity
    }
}
struct Weather: Codable {
    let main,description: String
    
}

struct Wind: Codable {
    let deg, speed: Double
}
