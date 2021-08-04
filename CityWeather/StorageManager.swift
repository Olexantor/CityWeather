//
//  StorageManager.swift
//  CityWeather
//
//  Created by Александр on 04.08.2021.
//
import Foundation
class StorageManager {
    
    static let shared = StorageManager()
    
    private let userDefaults = UserDefaults.standard
    private let cityKey = "cities"
    
    private init() {}
    
    func save(city: String) {
        var cities = fetchCities()
        cities.append(city)
        userDefaults.set(cities, forKey: cityKey)
    }
    
    func fetchCities() -> [String] {
        if let cities = userDefaults.value(forKey: cityKey) as? [String] {
            return cities
        }
        return DataManager.share.cities
    }
    
    func deleteCity(at index: Int) {
        var cities = fetchCities()
        cities.remove(at: index)
        userDefaults.set(cities, forKey: cityKey)
    }
}
