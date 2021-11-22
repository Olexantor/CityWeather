//
//  CurrentWeatherData.swift
//  CityWeather
//
//  Created by Александр on 22.09.2021.
//

import Foundation

struct CurrentWeatherData: Decodable {
  
  let geo_object: GeoObject
  let fact: Fact
}

struct GeoObject: Decodable {
  
  let locality: Locality
}

struct Locality: Decodable {
  
  let name: String
}

struct Fact: Decodable {
  
  let temp: Int
  let tempFeelsLike: Int
  let condition: String
  let windSpeed: Double
  let windDirection: String
  let pressure: Int
  let humidity: Int
  
  private enum CodingKeys: String, CodingKey {
    case temp
    case tempFeelsLike = "feels_like"
    case condition
    case windSpeed = "wind_speed"
    case windDirection = "wind_dir"
    case pressure = "pressure_mm"
    case humidity
  }
}
