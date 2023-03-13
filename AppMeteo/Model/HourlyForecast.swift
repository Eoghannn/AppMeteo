//
//  HourlyForecast.swift
//  AppMeteo
//
//  Created by tplocal on 12/03/2023.
//

import Foundation

struct HourlyForecast: Decodable {
    let cod: String
    let message: Double
    let cnt: Int
    let list: [HourlyForecastItem]
    let city: City
}

struct HourlyForecastItem: Decodable {
    let dt: Int
    let main: Main
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let rain: Rain?
    let snow: Snow?
    let sys: Sys
    let dt_txt: String
    
    struct Sys: Decodable {
        let pod: String
    }
}
