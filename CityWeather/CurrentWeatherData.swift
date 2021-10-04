//
//  CurrentWeatherData.swift
//  CityWeather
//
//  Created by Александр on 22.09.2021.
//

import Foundation

struct CurrentWeatherData: Decodable {
    let geo_object: GeoObject
}

struct GeoObject: Decodable {
    let locality: Locality
}

struct Locality: Decodable {
    let name: String
}
