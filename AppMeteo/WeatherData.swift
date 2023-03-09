//
//  WeatherData.swift
//  AppMeteo
//
//  Created by tplocal on 08/03/2023.
//

import Foundation

struct CityDataModel: Codable {
    let id: Int
    let name: String
    let state: String?
    let country: String
    let coord: Coordinate
    
}
func findCity(name: String, in cities: [CityDataModel]) -> CityDataModel? {
    for city in cities {
        if city.name == name {
            return city
        }
    }
    return nil
}

struct Coordinate: Codable {
    let lon: Double
    let lat: Double
}

struct WeatherDataModel: Codable {
    
    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    struct Main: Codable {
        let temp: Double
        let feelsLike: Double
        let pressure: Int
        let humidity: Int
        let tempMin: Double
        let tempMax: Double
        let seaLevel: Int?
        let groundLevel: Int?
        
        private enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case pressure
            case humidity
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case seaLevel = "sea_level"
            case groundLevel = "grnd_level"
        }
    }
    
    struct Wind: Codable {
        let speed: Double
        let deg: Int
        let gust: Double?
    }
    
    struct Clouds: Codable {
        let all: Int
    }
    
    struct Rain: Codable {
        let oneHour: Double?
        let threeHours: Double?
        
        private enum CodingKeys: String, CodingKey {
            case oneHour = "1h"
            case threeHours = "3h"
        }
    }
    
    struct Snow: Codable {
        let oneHour: Double?
        let threeHours: Double?
        
        private enum CodingKeys: String, CodingKey {
            case oneHour = "1h"
            case threeHours = "3h"
        }
    }
    
    struct System: Codable {
        let type: Int?
        let id: Int?
        let message: Double?
        let country: String?
        let sunrise: Int?
        let sunset: Int?
    }
    
    let coord: Coordinate
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int?
    let wind: Wind
    let clouds: Clouds
    let rain: Rain?
    let snow: Snow?
    let dt: Int
    let sys: System?
    let timezone: Int?
    let id: Int
    let name: String
    let cod: Int
}
