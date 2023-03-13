//
//  ApiService.swift
//  AppMeteo
//
//  Created by tplocal on 10/03/2023.
//

import Foundation

class ApiService {
    
    private var dataTask: URLSessionDataTask?
    
    // On parse la réponse de l'API en objet WeatherData
    func getCurrentWeather(lat: Double, lon: Double, completion: @escaping (Result<CurrentWeather, Error>) -> Void) {
        
        let weatherURL = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&APPID=d72eac97dde600c551650d3362e4292f&units=metric&lang=fr"
        
        guard let url = URL(string: weatherURL) else {return}
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                print("Empty Data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(CurrentWeather.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
    
    func getHourlyForecast(lat: Double, lon: Double, completion: @escaping (Result<HourlyForecast, Error>) -> Void) {
        
        let weatherURL = "https://pro.openweathermap.org/data/2.5/forecast/hourly?lat=\(lat)&lon=\(lon)&APPID=d72eac97dde600c551650d3362e4292f&units=metric&lang=fr"
        
        guard let url = URL(string: weatherURL) else {return}
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                print("Empty Data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(HourlyForecast.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
    
    // On parse le cities.json en objet City
    func getCitiesData(completion: @escaping (Result<[City], Error>) -> Void) {

        guard let url = Bundle.main.url(forResource: "cities", withExtension: "json") else {
            fatalError("Unable to find JSON file")
        }
        let data = try! Data(contentsOf: url)
        do {
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode([City].self, from: data)
            
            DispatchQueue.main.async {
                completion(.success(jsonData))
            }
        } catch let error {
            completion(.failure(error))
        }
    }
}
