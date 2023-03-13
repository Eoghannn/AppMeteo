//
//  ViewController.swift
//  AppMeteo
//
//  Created by tplocal on 08/03/2023.
//

import UIKit
import CoreLocation
import AlamofireImage


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager : CLLocationManager!

    private var apiService = ApiService()
    private var facade: CoreData = CoreData.sharedInstance
    
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var labelTempMax: UILabel!
    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet weak var labelTempMin: UILabel!
    @IBOutlet weak var labelWeatherDescription: UILabel!
    @IBOutlet weak var labelWindSpeed: UILabel!
    @IBOutlet weak var labelHumidity: UILabel!
    @IBOutlet weak var labelDatetime: UILabel!
    @IBOutlet weak var labelWindDirection: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        // On load les data dans locationManager
        setupLocation()
        loadCitiesData()
        
        print(facade.getCityByName(name: "Orléans")?.id ?? "nul")
        print(facade.getCityById(id: 6454159)?.name ?? "aze")
    }
    
    func populateWeatherData(weatherData: CurrentWeather) {
        print(weatherData)
        let temperature = Int(round(weatherData.main.temp))
        let temperatureMin = Int(round(weatherData.main.tempMin))
        let temperatureMax = Int(round(weatherData.main.tempMax))
        let humidity = weatherData.main.humidity
        let windSpeed = String(format: "%.1f", weatherData.wind.speed)
        let windDir = windDirectionFromDegree(degree: weatherData.wind.deg)
        let weatherDescription = weatherData.weather.first?.description ?? ""
        let day = formatDate(timestamp: weatherData.dt)
//        let time = formatHeure(timestamp: weatherData.dt)
        let iconCode = weatherData.weather.first?.icon ?? ""
 
        labelDatetime.text = day
        labelTemp.text = "\(temperature)°C"
        labelTempMin.text = "Temp. min: \(temperatureMin)°C"
        labelTempMax.text = "Temp. max: \(temperatureMax)°C"
        labelHumidity.text = "Humidity: \(humidity) %"
        labelWindSpeed.text = "Wind: \(windSpeed) m/s"
        labelWindDirection.text = "Dir: \(windDir)"
        labelWeatherDescription.text = weatherDescription
        
        backgroundImage.image = UIImage(named: getBackgroundImage(for: iconCode))
        navBar.title = weatherData.name
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let lastLocation = locations.last else {
            return
        }
        
        let latitude = lastLocation.coordinate.latitude
        let longitude = lastLocation.coordinate.longitude
        debugPrint("Latitude : \(latitude) Longitude : \(longitude)")

        
        loadWeatherData(lat: latitude, lon: longitude)
//        loadHourlyForecast(lat: latitude, lon: longitude)

    }
    
    private func loadWeatherData(lat: Double, lon: Double) {
        
        // Fetch data from the server
        apiService.getCurrentWeather(lat: lat, lon: lon) { [weak self] (result) in
            switch result {
            case .success(let weatherData):
                self?.populateWeatherData(weatherData: weatherData)
            case .failure(let error):
                self?.showAlertWith(title: "Could Not Connect cities!", message: "Please check your internet connection \n or try again later")
                print("Error processing json data: \(error)")
            }
        }
    }
    
    // Hourly forecast for 4 days (96 timestamps) (pour plus tard)
    private func loadHourlyForecast(lat: Double, lon: Double) {
        // Fetch data from the server
        apiService.getHourlyForecast(lat: lat, lon: lon) { [weak self] (result) in
            switch result {
            case .success(let weatherData):
                print(weatherData)
            case .failure(let error):
                self?.showAlertWith(title: "Could Not Connect cities!", message: "Please check your internet connection \n or try again later")
                print("Error processing json data: \(error)")
            }
        }
    }
    
    private func loadCitiesData() {
        
        // Fetch data from the server
        apiService.getCitiesData { [weak self] (result) in
            switch result {
            case .success(let listOf):
                // Save data to Core Data
                self?.facade.saveDataOf(cities: listOf)
            case .failure(let error):
                self?.showAlertWith(title: "Could Not Connect cities!", message: "Please check your internet connection \n or try again later")
                print("Error processing json data: \(error)")
            }
        }
    }
    
    // Juste pour voir si ça marche bien ou pas
    func showAlertWith(title: String, message: String, style: UIAlertController.Style = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setupLocation(){
        // On crée le manager de localisation :
        manager = CLLocationManager()
        
        // On dit que le controleur actuel est le délégué du manager de localisation
        manager.delegate = self
        
        // On dit quelle précision dans le positionnement on souhaite (ici la meilleure possible : Best)
        manager.desiredAccuracy = kCLLocationAccuracyBest
            // D'autres précisions :
            //  kCLLocationAccuracyHundredMeters
            //  kCLLocationAccuracyKilometer
            //  kCLLocationAccuracyBestForNavigation
        
        // Demander l'autorisation de tracker la position :
        manager.requestWhenInUseAuthorization()

        // Démarrer le tracking de la position
        manager.startUpdatingLocation()
    }
}

