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
    private let kCity = "cities"
    
    private init() {}
    
    func save(city: String) {
        var citiesForSave = cities
        citiesForSave.append(city)
        userDefaults.set(citiesForSave, forKey: kCity)
    }
    
    var cities: [String] {
        if let cities = userDefaults.value(forKey: kCity) as? [String] {
            return !cities.isEmpty ? cities : DataManager.share.cities
        }
        return DataManager.share.cities
    }
    
    func deleteCity(at index: Int) {
        var citiesForDelete = cities
        citiesForDelete.remove(at: index)
        userDefaults.set(citiesForDelete, forKey: kCity)
    }
}
