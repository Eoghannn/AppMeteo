//
//  WeatherModels.swift
//  AppMeteo
//
//  Created by tplocal on 12/03/2023.
//

import Foundation

struct Coordinates: Codable {
    let lon: Double
    let lat: Double
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Decodable {
    let temp: Double
    let feelsLike: Double
    let pressure: Int
    let humidity: Int
    let tempMin: Double
    let tempMax: Double
    let seaLevel: Int?
    let groundLevel: Int?
    let tempKf: Double?
    
    private enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case pressure
        case humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case seaLevel = "sea_level"
        case groundLevel = "grnd_level"
        case tempKf = "temp_kf"
    }
}

struct Wind: Decodable {
    let speed: Double
    let deg: Int
    let gust: Double?
}

struct Clouds: Decodable {
    let all: Int
}

struct Rain: Decodable {
    let oneHour: Double?
    let threeHours: Double?
    
    private enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
        case threeHours = "3h"
    }
}

struct Snow: Decodable {
    let oneHour: Double?
    let threeHours: Double?
    
    private enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
        case threeHours = "3h"
    }
}

struct System: Decodable {
    let type: Int?
    let id: Int?
    let message: Double?
    let country: String?
    let sunrise: Int?
    let sunset: Int?
}
