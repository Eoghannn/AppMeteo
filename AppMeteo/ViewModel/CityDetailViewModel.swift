//
//  CityDetailViewModel.swift
//  AppMeteo
//
//  Created by tplocal on 13/03/2023.
//

import Foundation

class CityDetailViewModel {

    let city: CityEntity?
    let name: String?
    let country: String?
    let lat: Double?
    let lon: Double?

    init(city: CityEntity?) {
        self.city = city
        
        self.name = city?.name
        self.country = city?.country
        self.lat = city?.coord?.lat
        self.lon = city?.coord?.lon
        
    }
}
