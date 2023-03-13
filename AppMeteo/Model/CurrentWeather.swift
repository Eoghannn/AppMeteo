//
//  WeatherData.swift
//  AppMeteo
//
//  Created by tplocal on 08/03/2023.
//

import Foundation

struct CurrentWeather: Decodable {
    let coord: Coordinates
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
