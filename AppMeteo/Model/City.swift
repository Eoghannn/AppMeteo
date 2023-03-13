//
//  City.swift
//  AppMeteo
//
//  Created by tplocal on 10/03/2023.
//

import Foundation

struct City: Decodable {
    let id: Int
    let name: String
    let state: String?
    let country: String
    let coord: Coordinates
    let timezone: Int?
    let sunrise: Int?
    let sunset: Int?
}
