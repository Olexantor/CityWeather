//
//  Weather.swift
//  CityWeather
//
//  Created by Александр on 22.09.2021.
//

import Foundation

struct Weather: Codable {
    let geo_object: GeoObject
}

struct GeoObject: Codable {
    let locality: Locality
}

struct Locality: Codable {
    let name: String
}
