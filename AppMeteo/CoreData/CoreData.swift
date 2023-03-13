//
//  CoreData.swift
//  AppMeteo
//
//  Created by tplocal on 10/03/2023.
//


import UIKit
import CoreData

class CoreData {
    
    static let sharedInstance = CoreData()
    private init(){}
    
    private let container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    private let fetchRequest = NSFetchRequest<CityEntity>(entityName: "CityEntity")
    
    func getAllCities() -> [CityEntity]? {
        do {
            let cities = try container?.viewContext.fetch(fetchRequest)
            return cities
        } catch {
            print("Fetching Error: \(error)")
            return nil
        }
    }

    func getCityByName(name: String) -> CityEntity? {
        let predicate = NSPredicate(format: "name == %@", name)
        fetchRequest.predicate = predicate
        do {
            let cities = try container?.viewContext.fetch(fetchRequest)
            return cities?.first
        } catch {
            print("Fetching Error: \(error)")
            return nil
        }
    }

    func getCityById(id: Int) -> CityEntity? {
        let predicate = NSPredicate(format: "id == %d", id)
        fetchRequest.predicate = predicate
        do {
            let cities = try container?.viewContext.fetch(fetchRequest)
            return cities?.first
        } catch {
            print("Fetching Error: \(error)")
            return nil
        }
    }
    
    func getCityFrom(lat: Double, lon: Double) -> CityEntity? {
        let predicate = NSPredicate(format: "coord.lat == %lf AND coord.lon == %lf", lat, lon)
        fetchRequest.predicate = predicate
        
        do {
            let result = try container?.viewContext.fetch(fetchRequest)
            return result?.first
        } catch {
            print("Error fetching city: \(error)")
            return nil
        }
    }
    
    func getFavoriteCities() -> [CityEntity]? {
        fetchRequest.predicate = NSPredicate(format: "isFavorite == %@", true as CVarArg)
        do {
            let cities = try container?.viewContext.fetch(fetchRequest)
            return cities
        } catch {
            print("Fetching Error: \(error)")
            return nil
        }
    }
    
    func addCityToFavorites(cityId: Int) {
        let context = container?.viewContext
        fetchRequest.predicate = NSPredicate(format: "id == %d", cityId)
        do {
            let result = try context?.fetch(fetchRequest)
            if let city = result?.first {
                city.isFavorite = true
                try context?.save()
            }
        } catch {
            print("Error adding city to favorites: \(error.localizedDescription)")
        }
    }

    
    
    func saveDataOf(cities:[City]) {
        
        // Updates CoreData with the new data from the server - Off the main thread
        self.container?.performBackgroundTask{ [weak self] (context) in
            self?.deleteObjectsfromCoreData(context: context)
            self?.saveDataToCoreData(cities: cities, context: context)
        }
    }
    
    // Delete Core Data objects before saving new data
    private func deleteObjectsfromCoreData(context: NSManagedObjectContext) {
        do {
            let objects = try context.fetch(fetchRequest)
            
            _ = objects.map({context.delete($0)})
            
            try context.save()
        } catch {
            print("Deleting Error: \(error)")
        }
    }

    private func saveDataToCoreData(cities:[City], context: NSManagedObjectContext) {
        // perform - Make sure that this code of block will be executed on the proper Queue
        // In this case this code should be perform off the main Queue
        context.perform {
            for city in cities {
                let cityEntity = CityEntity(context: context)
                let coordEntity = CoordEntity(context: context)
                cityEntity.name = city.name
                cityEntity.country = city.country
                cityEntity.state = city.state
                cityEntity.isFavorite = false
                cityEntity.id = Int64(city.id)
                coordEntity.lat = city.coord.lat
                coordEntity.lon = city.coord.lon
                coordEntity.city = cityEntity
                cityEntity.coord = coordEntity
            }
            do {
                try context.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        }
    }
}
