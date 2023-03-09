//
//  ViewController.swift
//  AppMeteo
//
//  Created by tplocal on 08/03/2023.
//

import UIKit

class ViewController: UIViewController {

    let api_key = "d72eac97dde600c551650d3362e4292f"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let urlCities = Bundle.main.url(forResource: "cities", withExtension: "json") else {
            fatalError("Unable to find JSON file")
        }
        let decoder = JSONDecoder()

        let data = try! Data(contentsOf: urlCities)
        // Décodez les données JSON en un tableau de CityDataModel
        do {
            let cities = try decoder.decode([CityDataModel].self, from: data)
            if let city = findCity(name: "Orléans", in: cities) {
                print("La ville est : \(city)")
                getMeteoByCity(city: city)
            } else {
                print("Aucune ville correspondant au nom donné n'a été trouvée.")
            }
        } catch {
            print("Erreur lors du décodage des données JSON : \(error.localizedDescription)")
        }
        
    }

    func getMeteoByCity(city: CityDataModel) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(city.coord.lat)&lon=\(city.coord.lon)&&APPID=\(api_key)")
        // Créer une session de connexion
        let session = URLSession(configuration: .default)
        // Créer une tâche
        let tache = session.dataTask(with: url!) { (data, response, error) in
          if error != nil {
            // Traiter l'erreur
              debugPrint("error")
          } else {
            if let data = data {
                let decode = JSONDecoder()
                do {
                    let decodeData = try decode.decode(WeatherDataModel.self, from: data)
                    print(decodeData)

                } catch {
                    print(error)
                }
            } else {
              // Faire SANS la donnée data
                print("Données pas très bien rendue")
            }
          }
        }
        // Lancer la tâche
        tache.resume()
    }

}

